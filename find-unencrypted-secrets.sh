#!/usr/bin/env bash
set -eu

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin

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