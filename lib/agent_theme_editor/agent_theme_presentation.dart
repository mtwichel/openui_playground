import 'package:flutter/material.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Converts agent ARGB tokens to [Color].
extension AgentThemeColorX on int {
  /// ARGB int to [Color].
  Color toColor() => Color(this);
}

/// Maps [AgentTheme] onto [ShadThemeData] for preview.
extension AgentThemeShadX on AgentTheme {
  /// Merges agent colors into [base].
  ShadThemeData applyTo(ShadThemeData base) {
    return base.merge(
      ShadThemeData(
        colorScheme: base.colorScheme.copyWith(
          primary: primaryArgb.toColor(),
          primaryForeground: onPrimaryArgb.toColor(),
          background: backgroundArgb.toColor(),
          foreground: onBackgroundArgb.toColor(),
          accent: accentArgb.toColor(),
          accentForeground: onAccentArgb.toColor(),
        ),
        textTheme: ShadTextTheme(family: fontFamily),
      ),
    );
  }
}

/// Converts [Color] to opaque ARGB for [AgentTheme].
int colorToArgb(Color color) => color.toARGB32();
