import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

/// Loads and applies Google Font families with network-safe fallbacks.
abstract final class GoogleFontLoader {
  /// Attempts to fetch [family] from Google Fonts.
  ///
  /// Returns `true` when the font is ready to use with [apply].
  static Future<bool> loadFamily(String family) async {
    try {
      await GoogleFonts.pendingFonts([
        GoogleFonts.getFont(family),
      ]).timeout(const Duration(seconds: 8));
      return true;
    } on Object {
      return false;
    }
  }

  /// Applies [family] to [style] when [useGoogleFont] is true.
  ///
  /// Falls back to a platform [fontFamily] without triggering network I/O.
  static TextStyle apply({
    required String family,
    required TextStyle style,
    required bool useGoogleFont,
  }) {
    if (!useGoogleFont) {
      return style.copyWith(fontFamily: family);
    }
    try {
      return GoogleFonts.getFont(family, textStyle: style);
    } on Object {
      return style.copyWith(fontFamily: family);
    }
  }
}
