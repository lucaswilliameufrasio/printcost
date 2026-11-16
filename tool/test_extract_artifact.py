import stat
import tempfile
import unittest
import zipfile
from pathlib import Path
from unittest import mock

from extract_artifact import extract_apk


class ExtractArtifactTests(unittest.TestCase):
    def setUp(self):
        self.temporary_directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary_directory.cleanup)
        self.root = Path(self.temporary_directory.name)
        self.downloads = self.root / "download"
        self.downloads.mkdir()
        self.archive_path = self.downloads / "artifact.zip"
        self.output = self.root / "dist"
        self.name = "printcost-dev.apk"

    def make_archive(self, entries):
        with zipfile.ZipFile(self.archive_path, "w") as archive:
            for name, data in entries:
                archive.writestr(name, data)

    def test_extracts_expected_apk(self):
        self.make_archive([(self.name, b"apk content")])
        extract_apk(self.downloads, self.output, self.name)
        self.assertEqual((self.output / self.name).read_bytes(), b"apk content")

    def test_extracts_versioned_apk(self):
        name = "printcost-1.2.3-rc.1+4.apk"
        self.make_archive([(name, b"release")])
        extract_apk(self.downloads, self.output, name)
        self.assertEqual((self.output / name).read_bytes(), b"release")

    def test_rejects_traversal_and_unexpected_or_multiple_entries(self):
        for entries in (
            [("../printcost-dev.apk", b"bad")],
            [("other.apk", b"bad")],
            [(self.name, b"valid"), ("extra", b"bad")],
            [(self.name, b"valid"), (self.name, b"duplicate")],
        ):
            with self.subTest(entries=entries):
                with mock.patch("warnings.warn"):
                    self.make_archive(entries)
                with self.assertRaises(ValueError):
                    extract_apk(self.downloads, self.output, self.name)

    def test_rejects_symlink_entry(self):
        entry = zipfile.ZipInfo(self.name)
        entry.create_system = 3
        entry.external_attr = (stat.S_IFLNK | 0o777) << 16
        self.make_archive([(entry, b"target")])
        with self.assertRaises(ValueError):
            extract_apk(self.downloads, self.output, self.name)

    def test_rejects_oversized_or_empty_apk(self):
        self.make_archive([(self.name, b"12345")])
        with mock.patch("extract_artifact.MAX_APK_BYTES", 4):
            with self.assertRaises(ValueError):
                extract_apk(self.downloads, self.output, self.name)
        self.make_archive([(self.name, b"")])
        with self.assertRaises(ValueError):
            extract_apk(self.downloads, self.output, self.name)

    def test_rejects_corrupted_archive_without_output(self):
        self.make_archive([(self.name, b"apk content")])
        data = bytearray(self.archive_path.read_bytes())
        data[data.index(b"apk content")] ^= 1
        self.archive_path.write_bytes(data)
        with self.assertRaises(zipfile.BadZipFile):
            extract_apk(self.downloads, self.output, self.name)
        self.assertFalse((self.output / self.name).exists())
        self.assertEqual(list(self.output.iterdir()), [])

    def test_does_not_replace_existing_file(self):
        self.make_archive([(self.name, b"new")])
        self.output.mkdir()
        (self.output / self.name).write_bytes(b"existing")
        with self.assertRaises(FileExistsError):
            extract_apk(self.downloads, self.output, self.name)
        self.assertEqual((self.output / self.name).read_bytes(), b"existing")

    def test_rejects_invalid_expected_names_and_downloads(self):
        self.make_archive([(self.name, b"valid")])
        with self.assertRaises(ValueError):
            extract_apk(self.downloads, self.output, "../printcost-dev.apk")
        (self.downloads / "extra").write_bytes(b"extra")
        with self.assertRaises(ValueError):
            extract_apk(self.downloads, self.output, self.name)


if __name__ == "__main__":
    unittest.main()
