/// Visual theme tokens for a GenUI agent (colors + font family).
class AgentTheme {
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

  /// Returns a copy with the given fields replaced.
  AgentTheme copyWith({
    int? primaryArgb,
    int? onPrimaryArgb,
    int? backgroundArgb,
    int? onBackgroundArgb,
    int? accentArgb,
    int? onAccentArgb,
    String? fontFamily,
  }) {
    return AgentTheme(
      primaryArgb: primaryArgb ?? this.primaryArgb,
      onPrimaryArgb: onPrimaryArgb ?? this.onPrimaryArgb,
      backgroundArgb: backgroundArgb ?? this.backgroundArgb,
      onBackgroundArgb: onBackgroundArgb ?? this.onBackgroundArgb,
      accentArgb: accentArgb ?? this.accentArgb,
      onAccentArgb: onAccentArgb ?? this.onAccentArgb,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentTheme &&
          primaryArgb == other.primaryArgb &&
          onPrimaryArgb == other.onPrimaryArgb &&
          backgroundArgb == other.backgroundArgb &&
          onBackgroundArgb == other.onBackgroundArgb &&
          accentArgb == other.accentArgb &&
          onAccentArgb == other.onAccentArgb &&
          fontFamily == other.fontFamily;

  @override
  int get hashCode => Object.hash(
    primaryArgb,
    onPrimaryArgb,
    backgroundArgb,
    onBackgroundArgb,
    accentArgb,
    onAccentArgb,
    fontFamily,
  );
}
