$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$printDir = Join-Path $root 'books/print-edition'
$template = Join-Path $printDir 'book-master.md'
$output = Join-Path $printDir 'book-print-ready.md'

if (-not (Test-Path $template)) {
    throw "Template not found: $template"
}

$content = Get-Content -Path $template -Raw

$includePattern = '<!-- INCLUDE: ([^ ]+) -->'
$matches = [regex]::Matches($content, $includePattern)

foreach ($m in $matches) {
    $rel = $m.Groups[1].Value
    $full = Join-Path $printDir $rel
    if (-not (Test-Path $full)) {
        throw "Missing include file: $rel"
    }
    $inc = Get-Content -Path $full -Raw
    $content = $content.Replace($m.Value, $inc)
}

Set-Content -Path $output -Value $content

$lineCount = (Get-Content $output).Count
$pages = [math]::Ceiling($lineCount / 32)
Write-Output ('Print-ready book generated: ' + $output)
Write-Output ('Lines: ' + $lineCount)
Write-Output ('Estimated pages: ' + $pages)
