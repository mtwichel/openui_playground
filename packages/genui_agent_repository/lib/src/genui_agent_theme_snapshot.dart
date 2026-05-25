/// Serializable theme fields for a [GenuiAgentSnapshot].
class GenuiAgentThemeSnapshot {
  /// Creates a [GenuiAgentThemeSnapshot].
  const GenuiAgentThemeSnapshot({
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

  /// Google Font family name.
  final String fontFamily;

  /// Parses a theme map from JSON.
  static GenuiAgentThemeSnapshot? fromJson(Object? json) {
    if (json is! Map<String, dynamic>) {
      return null;
    }
    final primary = json['primary'];
    final onPrimary = json['onPrimary'];
    final background = json['background'];
    final onBackground = json['onBackground'];
    final accent = json['accent'];
    final onAccent = json['onAccent'];
    final fontFamily = json['fontFamily'];
    if (primary is! int ||
        onPrimary is! int ||
        background is! int ||
        onBackground is! int ||
        accent is! int ||
        onAccent is! int ||
        fontFamily is! String) {
      return null;
    }
    return GenuiAgentThemeSnapshot(
      primaryArgb: primary,
      onPrimaryArgb: onPrimary,
      backgroundArgb: background,
      onBackgroundArgb: onBackground,
      accentArgb: accent,
      onAccentArgb: onAccent,
      fontFamily: fontFamily,
    );
  }

  /// Encodes this theme as JSON.
  Map<String, dynamic> toJson() => {
    'primary': primaryArgb,
    'onPrimary': onPrimaryArgb,
    'background': backgroundArgb,
    'onBackground': onBackgroundArgb,
    'accent': accentArgb,
    'onAccent': onAccentArgb,
    'fontFamily': fontFamily,
  };
}
