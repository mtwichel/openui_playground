import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Default [AgentTheme] aligned with Shad slate light.
AgentTheme slateLightAgentTheme() {
  const scheme = ShadSlateColorScheme.light();
  return AgentTheme(
    primaryArgb: scheme.primary.toARGB32(),
    onPrimaryArgb: scheme.primaryForeground.toARGB32(),
    backgroundArgb: scheme.background.toARGB32(),
    onBackgroundArgb: scheme.foreground.toARGB32(),
    accentArgb: scheme.accent.toARGB32(),
    onAccentArgb: scheme.accentForeground.toARGB32(),
    fontFamily: 'Inter',
  );
}
