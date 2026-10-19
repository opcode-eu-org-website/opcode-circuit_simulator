#!/bin/sh

# SPDX-FileCopyrightText: Robert Ryszard Paciorek <rrp@opcode.eu.org>
# SPDX-License-Identifier: MIT

create_redirect() {

mkdir -p "$2"
cat > "$2/index.html" << EOF
<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="0; url=$1">
    <title>Page Redirection</title>
    <script type="text/javascript">
        window.location.href = "$1";
    </script>
  </head>
  <body><p>If you are not redirected automatically, follow this <a href="$1">link to simulation</a>.</p></body>
</html>
EOF

}

if [ $# -eq 2 ]; then
  create_redirect "$@"
fi
