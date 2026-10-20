#!/usr/bin/env bash
# Install or upgrade Graphify and register its Claude Code skill.
# Re-run any time to update. Works on macOS, Linux, WSL2.
set -euo pipefail

command -v python3 >/dev/null || { echo "Python 3.10+ required"; exit 1; }
python3 -c 'import sys; sys.exit(sys.version_info < (3, 10))' || { echo "Python 3.10+ required"; exit 1; }

command -v uv >/dev/null || python3 -m pip install --user uv

if uv tool list | grep -q '^graphifyy '; then
  uv tool upgrade graphifyy
else
  uv tool install graphifyy
fi

# Package is "graphifyy" (double y); the command is "graphify".
command -v graphify >/dev/null || uv tool update-shell
graphify install   # registers /graphify in ~/.claude; refreshes it on upgrade

echo "Done. Open a NEW terminal, cd into a folder, start Claude Code, run: /graphify ."
