$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$printDir = Join-Path $root 'books/print-edition'
$splitBuild = Join-Path $root 'scripts/assemble_print_book.ps1'
$fullBuild = Join-Path $root 'scripts/build_full_print_variant.ps1'

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Output 'Pandoc is not installed. Install pandoc to generate PDF.'
    Write-Output 'Download: https://pandoc.org/installing.html'
    exit 1
}

& $splitBuild
& $fullBuild

$source = Join-Path $printDir 'book-print-ready-full.md'
$output = Join-Path $printDir 'EPL_Complete_Book_Abneesh_Singh_Print_Theme.pdf'
$metadata = Join-Path $printDir 'theme/book-metadata.yaml'

pandoc $source -o $output --from gfm --metadata-file $metadata --pdf-engine=xelatex

if ($LASTEXITCODE -ne 0) {
    throw "Pandoc PDF generation failed with exit code $LASTEXITCODE"
}

Write-Output ('PDF generated: ' + $output)
