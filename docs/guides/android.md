# Android Development with EPL

EPL can generate full Android Studio projects from your EPL code via Kotlin transpilation.

## Quick Start

```bash
# Generate Android project
epl android myapp.epl

# Generate and build APK
epl android myapp.epl --build

# Custom app name
epl android myapp.epl --name "My App" --build
```

## How It Works

1. EPL parses your `.epl` file
2. Transpiles to Kotlin using `kotlin_gen.py`
3. Generates a full Gradle project with:
   - `build.gradle.kts` (app + project level)
   - `AndroidManifest.xml`
   - `MainActivity.kt`
   - Jetpack Compose UI code
   - Gradle wrapper

## Example: Simple Android App

```epl
Note: A simple counter app
count = 0

Function increment
    count = count + 1
    Say "Count: " + to_string(count)
End

Function decrement
    count = count - 1
    Say "Count: " + to_string(count)
End
```

```bash
epl android counter.epl --name "Counter App" --build
```

## Build Requirements

To build APKs from the CLI, you need:

- **Android SDK** — Install via [Android Studio](https://developer.android.com/studio)
- **Java JDK 17+** — Install via `winget install Microsoft.OpenJDK.17`
- **Set ANDROID_HOME** — EPL auto-detects common paths:
  - Windows: `%LOCALAPPDATA%\Android\Sdk`
  - macOS: `~/Library/Android/sdk`
  - Linux: `~/Android/Sdk`

## CLI Options

| Flag | Description |
| ---- | ----------- |
| `--build` | Build APK after generating project |
| `--name NAME` | Set the app display name |
| `--compose` | Use Jetpack Compose UI (default) |

## Project Structure

```text
myapp_android/
├── app/
│   ├── src/main/
│   │   ├── java/com/epl/myapp/
│   │   │   └── MainActivity.kt
│   │   ├── res/
│   │   │   ├── values/
│   │   │   └── layout/
│   │   └── AndroidManifest.xml
│   └── build.gradle.kts
├── build.gradle.kts
├── settings.gradle.kts
├── gradle/wrapper/
├── gradlew
└── gradlew.bat
```

## Kotlin Transpilation

You can also just transpile to Kotlin without generating a full project:

```bash
epl kotlin myapp.epl    # Generates myapp.kt
```
