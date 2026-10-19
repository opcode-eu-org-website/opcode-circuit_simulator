#!/bin/sh

# SPDX-FileCopyrightText: Robert Ryszard Paciorek <rrp@opcode.eu.org>
# SPDX-License-Identifier: MIT

. "$(dirname "$0")/create_redirect.sh"

create_circuit_file() {
	code=$(echo "$1" | {
		IFS="=" read mode code
		case $mode in
			"cct")
				echo $code | python3 -c "import sys; from urllib.parse import unquote_plus; print(unquote_plus(sys.stdin.read()))"
				;;
			"ctz")
				echo $code | python3 -c "import sys; import lzstring; ctx = lzstring.LZString(); print(ctx.decompressFromEncodedURIComponent(sys.stdin.read()))"
				;;
			*)
				echo "Unknown mode $mode" >&2
				return 1
				;;
		esac
	})
	echo "$code" > "circuitjs1/circuits/$2"
}

while read tag url; do
	if [ "$tag" = "" -o "$tag" = "#" ]; then continue; fi
	if create_circuit_file "$url" "$tag"; then
		create_redirect "../circuitjs.html?startCircuit=$tag" "$tag";
		echo "/$tag /circuitjs.html?startCircuit=$tag 302" >> _redirects
	else
		create_redirect "../circuitjs.html?$url" "$tag";
	fi
done
