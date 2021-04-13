#!/usr/bin/env bash

set -e

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin

exit_status=1

parse_arguments() {
	while (($# > 0)); do
		# Grab param and value splitting on " " or "=" with parameter expansion
		local PARAMETER="${1%[ =]*}"
		local VALUE="${1#*[ =]}"
		if [[ "$PARAMETER" == "$VALUE" ]]; then VALUE="$2"; fi
		shift
		case "$PARAMETER" in
		-*)
			echo "Error: Unknown option: $PARAMETER" >&2
			exit 1
			;;
		*)
			files="$files $PARAMETER"
			;;
		esac
	done
}

parse_arguments "$@"

for FILE in $files; do
  SECRET_REGEX='^kind:\s+secret'
  SOPS_REGEX='ENC.AES256'
  echo "$@"
	if (grep -Pi "$SECRET_REGEX" "$FILE" >/dev/null); then
		if ! (grep -P "$SOPS_REGEX" "$FILE" >/dev/null); then
			exit_status=1
      echo "$FILE: has unencrypted secrets! (or at least not encrypted with AES256)"
		fi
	fi
done

exit $exit_status