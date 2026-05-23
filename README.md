# OpenUI Playground

A Flutter desktop and mobile playground for configuring a **GenUI agent** — the metadata, components, tools, and visual theme that power OpenUI-generated interfaces.

Use it to explore the standard OpenUI component library, inspect callable tools, edit agent instructions, and preview a custom color palette and Google Font on the Theme tab.

## Features

- **Definition** — name, description, and system instructions for the agent
- **Components** — live previews of each OpenUI standard component
- **Tools** — input/output schemas for registered agent tools
- **Theme** — six agent colors plus a Google Font family, with live preview on the Theme tab

Agent state is held in memory via `genui_agent_repository` (no API keys required to run the app today).

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

From VS Code / Cursor, use the **genui_playground** launch configuration in `.vscode/launch.json`.

## Tests

```bash
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

## Dependencies

OpenUI packages are pulled from [pub.dev](https://pub.dev) (`openui`, `openui_core`, `openui_components` at `0.0.1-dev.2`). UI chrome uses [shadcn_ui](https://pub.dev/packages/shadcn_ui); fonts on the Theme tab use [google_fonts](https://pub.dev/packages/google_fonts) (network required for font preview).

## Secrets

Do not commit API keys. If you add LLM or external integrations later, use environment variables or `--dart-define` locally — `.env` files are gitignored.
