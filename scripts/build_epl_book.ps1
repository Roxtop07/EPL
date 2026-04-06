$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot

Write-Output 'Step 1/3: Generating full manuscript...'
& (Join-Path $root 'scripts/generate_book_clean.ps1')

Write-Output 'Step 2/3: Assembling split print edition...'
& (Join-Path $root 'scripts/assemble_print_book.ps1')

Write-Output 'Step 3/3: Building full-length print variant...'
& (Join-Path $root 'scripts/build_full_print_variant.ps1')

Write-Output 'Book pipeline complete.'
