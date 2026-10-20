# Install or upgrade Graphify and register its Claude Code skill (native Windows).
# Re-run any time to update. Run in PowerShell: .\setup-graphify.ps1
$ErrorActionPreference = "Stop"

if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw "Python 3.10+ required" }
python -c "import sys; sys.exit(sys.version_info < (3, 10))"
if ($LASTEXITCODE -ne 0) { throw "Python 3.10+ required" }

if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    python -m pip install --user uv
    $env:Path += ";$(python -m site --user-base)\Scripts"
}

if (uv tool list | Select-String '^graphifyy ') { uv tool upgrade graphifyy } else { uv tool install graphifyy }

# Package is "graphifyy" (double y); the command is "graphify".
if (-not (Get-Command graphify -ErrorAction SilentlyContinue)) { uv tool update-shell }
graphify install   # registers /graphify in %USERPROFILE%\.claude; refreshes it on upgrade

Write-Host "Done. Open a NEW terminal, cd into a folder, start Claude Code, run: /graphify ."
