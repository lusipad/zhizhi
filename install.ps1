<#
.SYNOPSIS
  Install zhizhi skills for OpenAI Codex CLI and/or Claude Code on Windows.

.EXAMPLE
  .\install.ps1                  # install for every agent found on this machine
  .\install.ps1 -Codex           # Codex CLI only  (-> $env:CODEX_HOME\skills, default ~\.codex\skills)
  .\install.ps1 -Claude          # Claude Code only (-> ~\.claude\skills)
  .\install.ps1 -Rules D:\proj   # also append the 3 always-on rules to that
                                 # project's CLAUDE.md / AGENTS.md (idempotent)

  Claude Code users can skip this script entirely and use the plugin marketplace:
    /plugin marketplace add lusipad/zhizhi
    /plugin install zhizhi@zhizhi
#>
param(
  [switch]$Codex,
  [switch]$Claude,
  [string]$Rules
)

$ErrorActionPreference = 'Stop'

$repoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$src = Join-Path $repoDir 'skills'
$rulesFile = Join-Path $repoDir 'rules\unknowns-rules.md'
$rulesMarker = '## Finding your unknowns'

$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
$codexDir = Join-Path $codexHome 'skills'
$claudeDir = Join-Path $HOME '.claude\skills'

if (-not $Codex -and -not $Claude) {
  if (Test-Path $codexHome) { $Codex = $true }
  if (Test-Path (Join-Path $HOME '.claude')) { $Claude = $true }
  if (-not $Codex -and -not $Claude -and -not $Rules) {
    Write-Error 'Neither ~/.codex nor ~/.claude found. Use -Codex or -Claude to force a target.'
  }
}

function Install-To([string]$target) {
  New-Item -ItemType Directory -Force $target | Out-Null
  $count = 0
  Get-ChildItem -Directory $src | ForEach-Object {
    $dest = Join-Path $target $_.Name
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
    Copy-Item -Recurse $_.FullName $dest
    $script:count = ++$count
  }
  Write-Host "Installed $count skills to $target"
}

function Add-Rules([string]$proj) {
  if (-not (Test-Path $proj -PathType Container)) { Write-Error "Not a directory: $proj" }
  $wrote = $false
  foreach ($f in 'CLAUDE.md', 'AGENTS.md') {
    $target = Join-Path $proj $f
    if (Test-Path $target) {
      if (Select-String -Path $target -Pattern ([regex]::Escape($rulesMarker)) -Quiet) {
        Write-Host "Rules already present in $target"
      } else {
        Add-Content -Path $target -Value ("`n" + (Get-Content $rulesFile -Raw))
        Write-Host "Appended rules to $target"
      }
      $wrote = $true
    }
  }
  if (-not $wrote) {
    Copy-Item $rulesFile (Join-Path $proj 'AGENTS.md')
    Write-Host "Created $proj\AGENTS.md with rules (Claude Code users: consider copying into CLAUDE.md)"
  }
}

if ($Codex) { Install-To $codexDir }
if ($Claude) { Install-To $claudeDir }
if ($Rules) { Add-Rules $Rules }

Write-Host 'Done. Skills: kickoff (开工), wrapup (收工), quiz-me (考考我)'
