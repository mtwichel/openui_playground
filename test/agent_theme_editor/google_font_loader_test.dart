import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genui_playground/agent_theme_editor/google_font_loader.dart';

void main() {
  group('GoogleFontLoader.apply', () {
    test('uses platform family when Google Font is disabled', () {
      const style = TextStyle(fontSize: 16);

      final result = GoogleFontLoader.apply(
        family: 'Inter',
        style: style,
        useGoogleFont: false,
      );

      expect(result.fontFamily, 'Inter');
      expect(result.fontSize, 16);
    });
  });
}
