---
date: 2026-05-22
topic: theme-page
---

# Theme Page (Agent Theme)

## What We're Building

A **Theme** tab where users edit **`GenuiAgent.theme`** — six colors plus a Google Font family — with live preview on that tab only.

| Agent token | Meaning |
|-------------|---------|
| `primary` | Brand / primary actions |
| `onPrimary` | Foreground on primary surfaces |
| `background` | Page / canvas background |
| `onBackground` | Foreground on background |
| `accent` | Highlights, secondary emphasis |
| `onAccent` | Foreground on accent surfaces |

**Font:** Any **Google Font** via search/picker; store the canonical family name (e.g. `Roboto`, `Inter`) on the agent.

**Persistence:** Each edit updates `GenuiAgentRepository` immediately (same pattern as Definition). No separate Save button.

**Live preview:** Only the Theme tab subtree uses the agent theme (`ShadTheme.merge` + loaded Google Font). Nav and other tabs keep default Shad slate in v1.

**Defaults:** New agents get `AgentTheme` seeded from **Shad slate light** defaults.

**Out of scope (v1):** Global `ShadApp` theming, OpenUI catalog previews, auto-contrast for `on*` colors, theme JSON export format.

## Persistence vs preview

| Concern | v1 behavior |
|---------|-------------|
| Data | Always on `GenuiAgent.theme` via repository |
| What user sees | Theme tab reflects agent theme; other tabs unchanged |
| Later | Whole-app apply and/or GenUI export consume the same `AgentTheme` |

## Why This Approach

### AgentTheme on GenuiAgent — **Yes (chosen)**

`AgentTheme` in `genui_agent_repository`; field `GenuiAgent.theme`. `ThemeBloc` + repository setters mirror Definition. Theme tab wraps preview in `ShadTheme.merge` + `google_fonts`.

- **Pros:** Agent-owned spec; not playground-specific; serializable later; matches existing patterns.
- **Cons:** Map 6 tokens → `ShadColorScheme`; Google Fonts needs network/async load in preview.
- **Best when:** Theme is part of the agent long-term (chosen).

### Store `ShadThemeData` on agent — **No**

- **Pros:** Less mapping.
- **Cons:** Coupled to `shadcn_ui`; poor export story.

### UI-only, no repository — **No**

- Conflicts with persisting on the agent.

## Key Decisions

1. **Domain:** `AgentTheme` + `GenuiAgent.theme` in `genui_agent_repository` (not a playground-only type).
2. **Colors:** Six manual pickers; user owns contrast (no auto `on*` in v1).
3. **Font:** `google_fonts` package; searchable picker; load font on demand in preview (do not bundle the catalog).
4. **Defaults:** Shad slate light when agent is created.
5. **Module:** `lib/theme/` + `ShellTab.theme => ThemePage()`.
6. **Preview scope:** `ShadTheme.merge` / `ShadAnimatedTheme` only under Theme tab.
7. **Updates:** Bloc → repository on each change (silent, like Definition).

## Shad mapping (preview only)

Agent tokens map to `ShadColorScheme.copyWith` for the Theme tab preview:

| Agent token | Shad `ShadColorScheme` field |
|-------------|------------------------------|
| `primary` | `primary` |
| `onPrimary` | `primaryForeground` |
| `background` | `background` |
| `onBackground` | `foreground` |
| `accent` | `accent` |
| `onAccent` | `accentForeground` |

Font: `ShadTextTheme(family: …)` or `ThemeData` text theme via `GoogleFonts.getFont(theme.fontFamily)`.

## Proposed UX (Theme tab)

- Header: “Theme” + subtitle (agent visual identity).
- Six color rows: label, picker, optional hex.
- Typography: Google Font search (typeahead); debounced query against Google Fonts list.
- Preview card: primary button, input, body text, accent-styled control — inside merged theme.
- Layout: `EdgeInsets.fromLTRB(32, 28, 32, 40)`, max width `960` (match Catalog/Tools).

## Risks (accepted for v1)

- **Contrast:** Manual `on*` colors may be illegible; no guardrails until a later release.
- **Google Fonts:** Requires network for first load; handle loading/error in preview.
- **Catalog:** Component previews stay on `standardLibrary()` styling until OpenUI supports theme.

## Planning recommendations (resolved)

| Topic | Recommendation |
|-------|----------------|
| Color storage | `Color` (ARGB) on `AgentTheme`; hex only at export/UI |
| Repository API | Per-field setters or `updateTheme(AgentTheme Function)` — match Definition granularity |
| Font picker | Search over Google Fonts family names (`google_fonts` list/API); show loading spinner while font loads |
| Save indicator | None — silent persist like Definition |

## Open Questions

- Use `google_fonts` built-in font list vs remote search API for the picker?
- Include font weight picker in v1, or family only?

## File checklist

| Area | Path |
|------|------|
| Domain | `packages/genui_agent_repository/lib/src/agent_theme.dart` |
| Domain | `packages/genui_agent_repository/lib/src/genui_agent.dart` |
| Domain | `packages/genui_agent_repository/lib/src/genui_agent_repository.dart` |
| Feature | `lib/theme/` |
| Shell | `lib/shell/view/shell_view.dart` |
| Deps | `pubspec.yaml` — `google_fonts` |
