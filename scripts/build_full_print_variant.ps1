$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$source = Join-Path $root 'books/EPL_Complete_Book_Abneesh_Singh.md'
$out = Join-Path $root 'books/print-edition/book-print-ready-full.md'

if (-not (Test-Path $source)) {
    throw "Source manuscript not found: $source"
}

$header = @'
---
title: "EPL: The Complete Book"
author: "Abneesh Singh"
subtitle: "Full Print Variant"
date: "2026-04-04"
---

# Table of Contents {#toc}

1. [Part I: Foundations](#part-i-foundations)
2. [Integrated Official References](#integrated-official-references)
3. [Practice Workbook](#practice-workbook)

Cross-reference:

- Use the split professional layout in books/print-edition/book-print-ready.md for editorial workflows.
- Use this file for full-length print generation.

\newpage
'@

$body = Get-Content -Path $source -Raw
$body = $body.Replace('(assets/epl_logo_minimal.png)', '(../assets/epl_logo_minimal.png)')
Set-Content -Path $out -Value ($header + "`n" + $body)

$lineCount = (Get-Content $out).Count
$pages = [math]::Ceiling($lineCount / 32)
Write-Output ('Full print variant generated: ' + $out)
Write-Output ('Lines: ' + $lineCount)
Write-Output ('Estimated pages: ' + $pages)
