import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:test/test.dart';

void main() {
  group('AgentTheme', () {
    const theme = AgentTheme(
      primaryArgb: 0xFF000001,
      onPrimaryArgb: 0xFF000002,
      backgroundArgb: 0xFF000003,
      onBackgroundArgb: 0xFF000004,
      accentArgb: 0xFF000005,
      onAccentArgb: 0xFF000006,
      fontFamily: 'Inter',
    );

    test('copyWith replaces single field', () {
      expect(
        theme.copyWith(primaryArgb: 0xFF111111).primaryArgb,
        0xFF111111,
      );
      expect(theme.copyWith(primaryArgb: 0xFF111111).fontFamily, 'Inter');
    });

    test('equality uses all fields', () {
      expect(theme, theme.copyWith());
      expect(theme, isNot(theme.copyWith(fontFamily: 'Roboto')));
    });
  });
}
