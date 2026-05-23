# OpenUI Playground

A Flutter desktop and mobile playground for configuring a **GenUI agent** — the metadata, components, tools, and visual theme that power OpenUI-generated interfaces.

Use it to explore the standard OpenUI component library, inspect callable tools, edit agent instructions, and preview a custom color palette and Google Font on the Theme tab.

## Features

- **Definition** — name, description, and system instructions for the agent
- **Components** — live previews of each OpenUI standard component
- **Tools** — input/output schemas for registered agent tools
- **Theme** — six agent colors plus a Google Font family, with live preview on the Theme tab

Agent state is managed by `genui_agent_repository` and **auto-saved** to a temp `.genuiagent` JSON file (name, description, instructions, and theme). Browsing components, tools, definition, and theme does not require an API key; Gemini is only needed when you run features that call the model (see [Gemini API key](#gemini-api-key)).

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.11.5** or newer (Dart **3.11.5+**)
- Xcode (macOS/iOS) or Android Studio (Android), depending on target platform

Check your setup:

```bash
flutter doctor
```

## Getting started

Clone the repository and install dependencies:

```bash
git clone https://github.com/mtwichel/openui_playground.git
cd openui_playground
flutter pub get
cd packages/genui_agent_repository && dart pub get && cd ../..
```

Run the app (macOS example):

```bash
flutter run -d macos
```

Other targets:

```bash
flutter run -d chrome   # web
flutter run -d ios      # iOS simulator or device
```

From VS Code / Cursor, use the **genui_playground** launch configuration in `.vscode/launch.json` (see [Gemini API key](#gemini-api-key) below to pass your key from the environment).

## Gemini API key

Some GenUI / OpenUI workflows call Gemini. Pass your key at **run time** — never commit it to the repo.

1. Create an API key in [Google AI Studio](https://aistudio.google.com/apikey).
2. Provide it when you run or debug the app.

**Terminal**

```bash
flutter run -d macos --dart-define=GEMINI_API_KEY=your_api_key_here
```

Replace `your_api_key_here` with your key. Use the same flag for other targets (`chrome`, `ios`, etc.).

**Environment variable (recommended)**

Set the key in your shell profile or session, then reference it so it does not appear in your shell history:

```bash
export GEMINI_API_KEY=your_api_key_here
flutter run -d macos --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY
```

**VS Code / Cursor**

Add `toolArgs` to `.vscode/launch.json` so the debugger passes the define from your environment:

```json
{
  "name": "genui_playground",
  "request": "launch",
  "type": "dart",
  "toolArgs": [
    "--dart-define=GEMINI_API_KEY=${env:GEMINI_API_KEY}"
  ]
}
```

Set `GEMINI_API_KEY` in your environment (or in a local `.env` loaded by your shell) before starting a debug session.

**Optional: define file**

You can keep defines in a gitignored file and pass it to Flutter:

```bash
# dart_defines.json (add to .gitignore if not already covered)
{
  "GEMINI_API_KEY": "your_api_key_here"
}
```

```bash
flutter run -d macos --dart-define-from-file=dart_defines.json
```

The app reads the key via `String.fromEnvironment('GEMINI_API_KEY')` when Gemini-backed features are enabled.

## Agent persistence

Edits on the Definition and Theme tabs are written automatically to:

`{temporaryDirectory}/genui_playground/default.genuiagent`

On launch, the app restores from that file when it exists and is valid. Components and tools always come from the OpenUI standard library at runtime (not stored in the file yet).

## Tests

```bash
# Persistence package
cd packages/persistence_data_source && dart test

# Repository package
cd packages/genui_agent_repository && dart test

# App (from repo root)
flutter test
```

## Project layout

| Path | Purpose |
|------|---------|
| `lib/shell/` | App shell and navigation |
| `lib/description_editor/` | Agent definition tab |
| `lib/catalog/` | Component catalog and previews |
| `lib/tools/` | Tools list and schemas |
| `lib/agent_theme_editor/` | Agent theme tab |
| `packages/genui_agent_repository/` | Agent domain model and repository |
| `packages/persistence_data_source/` | `.genuiagent` file persistence (debounced) |

## Dependencies

OpenUI packages are pulled from [pub.dev](https://pub.dev) (`openui`, `openui_core`, `openui_components` at `0.0.1-dev.2`). UI chrome uses [shadcn_ui](https://pub.dev/packages/shadcn_ui); fonts on the Theme tab use [google_fonts](https://pub.dev/packages/google_fonts) (network required for font preview).

## Secrets

Do not commit API keys. Use `--dart-define=GEMINI_API_KEY=...`, an environment variable, or a local `--dart-define-from-file` (see [Gemini API key](#gemini-api-key)). `.env` files and common secret paths are gitignored.
