import contextlib
import io
import os
import unittest
from unittest import mock

import run


class RunTests(unittest.TestCase):
    def test_device_menu_retries_and_runs_selected_device(self):
        devices = (
            '[{"name":"Phone","id":"phone","isSupported":true,'
            '"targetPlatform":"ios","emulator":false},'
            '{"name":"Browser","id":"chrome","isSupported":true,'
            '"targetPlatform":"web-javascript"}]'
        )
        output = io.StringIO()
        with (
            mock.patch.object(run.sys, "argv", ["run.py", "flutter", "--verbose"]),
            mock.patch.dict(os.environ, {"DEVICE": ""}),
            mock.patch.object(run.subprocess, "run") as discover,
            mock.patch("builtins.input", side_effect=["5", "1"]),
            mock.patch.object(run.os, "execvp") as execute,
            contextlib.redirect_stdout(output),
        ):
            discover.return_value.stdout = devices
            run.main()

        self.assertIn("Phone", output.getvalue())
        self.assertNotIn("Browser", output.getvalue())
        self.assertIn("Opção inválida", output.getvalue())
        execute.assert_called_once_with(
            "flutter", ["flutter", "run", "-d", "phone", "--verbose"]
        )

    def test_explicit_device_skips_discovery(self):
        with (
            mock.patch.object(run.sys, "argv", ["run.py", "flutter"]),
            mock.patch.dict(os.environ, {"DEVICE": "phone"}),
            mock.patch.object(run.subprocess, "run") as discover,
            mock.patch.object(run.os, "execvp") as execute,
        ):
            run.main()

        discover.assert_not_called()
        execute.assert_called_once_with("flutter", ["flutter", "run", "-d", "phone"])

    def test_no_devices_fails_without_launch(self):
        with (
            mock.patch.object(run.sys, "argv", ["run.py", "flutter"]),
            mock.patch.dict(os.environ, {"DEVICE": ""}),
            mock.patch.object(run.subprocess, "run") as discover,
            mock.patch.object(run.os, "execvp") as execute,
            contextlib.redirect_stdout(io.StringIO()),
        ):
            discover.return_value.stdout = "[]"
            self.assertEqual(run.main(), 1)

        execute.assert_not_called()

    def test_cancel_does_not_launch(self):
        with (
            mock.patch.object(run.sys, "argv", ["run.py", "flutter"]),
            mock.patch.dict(os.environ, {"DEVICE": ""}),
            mock.patch.object(run.subprocess, "run") as discover,
            mock.patch("builtins.input", return_value="0"),
            mock.patch.object(run.os, "execvp") as execute,
            contextlib.redirect_stdout(io.StringIO()),
        ):
            discover.return_value.stdout = (
                '[{"name":"Phone","id":"phone","isSupported":true,'
                '"targetPlatform":"ios"}]'
            )
            self.assertEqual(run.main(), 0)

        execute.assert_not_called()


if __name__ == "__main__":
    unittest.main()
