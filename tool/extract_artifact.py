"""Extract exactly one expected APK after the download action verifies its digest."""

import argparse
import os
from pathlib import Path
import re
import stat
import tempfile
import zipfile


MAX_APK_BYTES = 512 * 1024 * 1024
CHUNK_BYTES = 1024 * 1024
APK_NAME = re.compile(r"printcost-[A-Za-z0-9][A-Za-z0-9.+_-]*\.apk\Z")


def extract_apk(download_directory: Path, output_directory: Path, expected: str):
    if not APK_NAME.fullmatch(expected):
        raise ValueError("Invalid expected APK filename")

    downloads = list(download_directory.iterdir())
    if len(downloads) != 1 or downloads[0].is_symlink() or not downloads[0].is_file():
        raise ValueError("Expected exactly one downloaded archive")

    with zipfile.ZipFile(downloads[0]) as archive:
        entries = archive.infolist()
        if len(entries) != 1 or entries[0].filename != expected:
            raise ValueError("Archive must contain exactly the expected APK")
        entry = entries[0]
        mode = entry.external_attr >> 16
        file_type = stat.S_IFMT(mode)
        if entry.is_dir() or file_type not in (0, stat.S_IFREG):
            raise ValueError("APK must be a regular file")
        if entry.flag_bits & 1:
            raise ValueError("Encrypted archives are not supported")
        if entry.file_size == 0 or entry.file_size > MAX_APK_BYTES:
            raise ValueError("APK size is outside the permitted range")

        output_directory.mkdir(exist_ok=True)
        temporary_name = None
        try:
            with tempfile.NamedTemporaryFile(dir=output_directory, delete=False) as output:
                temporary_name = output.name
                with archive.open(entry) as source:
                    written = 0
                    while chunk := source.read(CHUNK_BYTES):
                        written += len(chunk)
                        if written > MAX_APK_BYTES:
                            raise ValueError("APK exceeds the permitted size")
                        output.write(chunk)
                if written != entry.file_size:
                    raise ValueError("APK size does not match the archive")
            os.link(temporary_name, output_directory / expected)
        finally:
            if temporary_name is not None:
                os.unlink(temporary_name)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("download_directory", type=Path)
    parser.add_argument("output_directory", type=Path)
    parser.add_argument("expected_apk")
    arguments = parser.parse_args()
    extract_apk(
        arguments.download_directory, arguments.output_directory, arguments.expected_apk
    )


if __name__ == "__main__":
    main()
