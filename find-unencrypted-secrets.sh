#!/usr/bin/env bash
set -eux

secret_regex="^kind:\s+secret"
sops_regex="ENC.AES256"


has_error=0
for file in "$@"; do
    if (grep -q -i -P "${secret_regex}" "${file}"); then
        if ! (grep -q -P "${sops_regex}" "${file}"); then
            echo "ERROR: ${file} is not encrypted"
            has_error=1
        fi
    fi
done

if [[ "${has_error}" -eq 1 ]] ; then
    echo "To ignore, use --no-verify"
fi

exit $has_error