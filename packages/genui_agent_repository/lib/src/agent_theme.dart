import 'package:dart_mappable/dart_mappable.dart';

part 'agent_theme.mapper.dart';

/// Visual theme tokens for a GenUI agent (colors + font family).
@MappableClass()
class AgentTheme with AgentThemeMappable {
  /// Creates an [AgentTheme].
  const AgentTheme({
    required this.primaryArgb,
    required this.onPrimaryArgb,
    required this.backgroundArgb,
    required this.onBackgroundArgb,
    required this.accentArgb,
    required this.onAccentArgb,
    required this.fontFamily,
  });

  /// Primary brand color (ARGB).
  final int primaryArgb;

  /// Foreground on primary surfaces (ARGB).
  final int onPrimaryArgb;

  /// Page background (ARGB).
  final int backgroundArgb;

  /// Foreground on background (ARGB).
  final int onBackgroundArgb;

  /// Accent color (ARGB).
  final int accentArgb;

  /// Foreground on accent surfaces (ARGB).
  final int onAccentArgb;

  /// Google Font family name (e.g. `Inter`).
  final String fontFamily;
}
