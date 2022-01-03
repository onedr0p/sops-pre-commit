from __future__ import print_function

import argparse
import re
import sys

SECRET_REGEX = r"^kind:\ssecret"
SOPS_REGEX = r"ENC.AES256"
KUSTOMIZE_REGEX = r"^\$patch:\sdelete"


def contains_secret(filename):
    with open(filename, mode="r") as file_checked:
        lines = file_checked.read()
        kubernetes_secret = re.findall(
            SECRET_REGEX, lines, flags=re.IGNORECASE | re.MULTILINE
        )
        if kubernetes_secret:
            ignore_secret = re.findall(
                SOPS_REGEX, lines, flags=re.IGNORECASE | re.MULTILINE
            ) or re.findall(KUSTOMIZE_REGEX, lines, flags=re.IGNORECASE | re.MULTILINE)
            if not ignore_secret:
                return True
    return False


def main(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument("filenames", nargs="*", help="filenames to check")
    args = parser.parse_args(argv)
    files_with_secrets = [f for f in args.filenames if contains_secret(f)]
    return_code = 0
    for file_with_secrets in files_with_secrets:
        print(
            "Unencrypted Kubernetes secret detected in file: {0}".format(
                file_with_secrets
            )
        )
        return_code = 1
    return return_code


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
