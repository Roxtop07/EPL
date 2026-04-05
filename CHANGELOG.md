# Changelog

All notable changes to EPL are documented in this file.

## [7.2.0] — 2026-04-06

### Added
- **Documentation Website** — Full MkDocs Material docs at [abneeshsingh21.github.io/EPL](https://abneeshsingh21.github.io/EPL)
  - Getting started guide, language reference, stdlib reference
  - Web, Database, and Android development guides
  - Examples gallery with real-world projects
  - Online playground integration
- **LSP Autocomplete Expansion** — 90+ new stdlib function signatures for IDE autocomplete, hover docs, and signature help (database, web, crypto, concurrency, GUI, game dev, ML)
- **Project Templates** — `epl new --template android` and `epl new --template fullstack` (7 templates total)
- **Error Diagnostics** — 19 new error hint patterns for common mistakes (type coercion, database, web server, block matching)
- **CI/CD** — GitHub Actions for automated testing (3 OSes × 3 Python versions) and docs auto-deploy

## [7.1.0] — 2026-04-06

### Added
- **Production Server Defaults** — `epl serve` now defaults to waitress/gunicorn/uvicorn
  - `--dev` flag for development mode with hot-reload
  - `--engine` flag for manual server selection
  - Auto-install of waitress if no production server found
- **Android Build Pipeline** — `epl android --build` compiles APKs via Gradle
  - Auto-detection of ANDROID_HOME across Windows/Linux/macOS
  - `--name` flag for custom app display name
- **Stdlib Modularization** — Domain registry mapping 725 functions to 33 domains
  - `epl/stdlib_modules/` package with lookup utilities
  - 100% coverage of all stdlib functions
- **Example Projects** — `examples/hello_web`, `examples/todo_api`, `examples/calculator`

## [7.0.1] — 2026-04-05

### Added
- LLVM compiler backend with native executable output
- Bytecode VM for faster interpretation
- Package manager with `epl.toml` manifest
- Web framework with WSGI/ASGI adapters
- ORM with models, migrations, relationships
- Concurrency primitives (threads, channels, mutexes, barriers)
- Desktop GUI via tkinter
- Game development via Pygame
- Data science via Pandas/NumPy
- Machine Learning via scikit-learn/PyTorch
- Android project generation via Kotlin transpilation
- iOS project generation via Swift transpilation

## [1.0.0] — 2024

### Initial Release
- EPL language interpreter with tree-walking evaluation
- English-like syntax for variables, functions, classes, modules
- 725 standard library functions
- VS Code extension with LSP support
- Interactive REPL
- Code formatter and type checker
