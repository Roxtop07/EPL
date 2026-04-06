$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$bookDir = Join-Path $root 'books'
$assetsDir = Join-Path $bookDir 'assets'
$outFile = Join-Path $bookDir 'EPL_Complete_Book_Abneesh_Singh.md'

New-Item -ItemType Directory -Force -Path $bookDir | Out-Null
New-Item -ItemType Directory -Force -Path $assetsDir | Out-Null

$logoSrc = Join-Path $root 'epl_logo_minimal.png'
$logoDst = Join-Path $assetsDir 'epl_logo_minimal.png'
if (Test-Path $logoSrc) {
    Copy-Item -Force $logoSrc $logoDst
}

$front = @'
# EPL: The Complete Book

## Author: Abneesh Singh

![EPL Logo](assets/epl_logo_minimal.png)

Version: 7.0.x  
Date: 2026-04-04

---

## Introduction

This book is a complete EPL language guide from beginner to production level. It includes syntax, architecture, tooling, standard library, and large practice sections.

---

## Architecture Overview

```mermaid
flowchart TD
    A[.epl source] --> B[Lexer]
    B --> C[Parser]
    C --> D[AST]
    D --> E[Interpreter]
    D --> F[Bytecode Compiler]
    F --> G[VM]
    D --> H[LLVM Compiler]
    H --> I[Native Binary]
    D --> J[Transpilers]
    J --> K[JS / Kotlin / Python / MicroPython]
```

## Example: Beginner

```epl
Remember name as "EPL"
Say "Hello, " + name
```

## Example: Intermediate

```epl
Function sum_to takes n
    Remember total as 0
    For i from 1 to n
        Set total to total + i
    End
    Return total
End

Say sum_to(10)
```

## Example: Advanced

```epl
Class Account
    Set owner to ""
    Set balance to 0

    Method deposit takes amount
        If amount is less than or equal to 0 then
            Throw "Invalid amount"
        End
        Set balance to balance + amount
    End
End

Remember a as new Account
Set a.owner to "Alice"
Try
    a.deposit(100)
    Say a.balance
Catch err
    Say err
End
```

---

# Integrated Official References
'@

Set-Content -Path $outFile -Value $front

$files = @(
    'docs/language-spec.md',
    'docs/language-reference.md',
    'GRAMMAR.md',
    'docs/stdlib-reference.md',
    'docs/package-manager.md',
    'docs/architecture.md',
    'docs/tutorials.md',
    'EPL_SYNTAX_REFERENCE.txt'
)

foreach ($f in $files) {
    $path = Join-Path $root $f
    if (Test-Path $path) {
        Add-Content -Path $outFile -Value "`n---`n`n## Integrated Source: $f`n"
        Get-Content $path | Add-Content -Path $outFile
    }
}

Add-Content -Path $outFile -Value "`n---`n`n# Practice Workbook`n"

for ($i = 1; $i -le 150; $i++) {
    Add-Content -Path $outFile -Value @"

## Beginner Exercise $i

Goal: print a personalized greeting.

```epl
Remember learner as "Student"
Say "Welcome " + learner + " (Exercise $i)"
```
"@
}

for ($i = 1; $i -le 130; $i++) {
    Add-Content -Path $outFile -Value @"

## Intermediate Exercise $i

Goal: process list data with loop and condition.

```epl
Remember nums as [1, 2, 3, 4, 5, 6]
Remember total as 0
For each n in nums
    If n mod 2 equals 0 then
        Set total to total + n
    End
End
Say "Even total: " + total
```
"@
}

for ($i = 1; $i -le 100; $i++) {
    Add-Content -Path $outFile -Value @"

## Advanced Exercise $i

Goal: combine classes, validation, and exceptions.

```epl
Class Validator
    Method require_non_empty takes text
        If text equals "" then
            Throw "Text must not be empty"
        End
        Return text
    End
End

Remember v as new Validator
Try
    Say v.require_non_empty("EPL")
Catch err
    Say "Error: " + err
End
```
"@
}

$lineCount = (Get-Content $outFile).Count
$pages = [math]::Ceiling($lineCount / 32)

Write-Output ('Book file: ' + $outFile)
Write-Output ('Lines: ' + $lineCount)
Write-Output ('Estimated pages: ' + $pages)
