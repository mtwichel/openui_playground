import 'package:persistence_data_source/persistence_data_source.dart';
import 'package:test/test.dart';

void main() {
  const theme = GenuiAgentThemeSnapshot(
    primaryArgb: 0xFF112233,
    onPrimaryArgb: 0xFFf8fafc,
    backgroundArgb: 0xFFFFFFFF,
    onBackgroundArgb: 0xFF020817,
    accentArgb: 0xFFf1f5f9,
    onAccentArgb: 0xFF0f172a,
    fontFamily: 'Inter',
  );

  const snapshot = GenuiAgentSnapshot(
    name: 'Agent',
    description: 'Desc',
    instructions: 'Do things',
    theme: theme,
  );

  group('GenuiAgentSnapshot', () {
    test('round-trips through JSON', () {
      final json = snapshot.toJsonString();
      final restored = GenuiAgentSnapshot.fromJsonString(json);

      expect(restored, isNotNull);
      expect(restored!.name, snapshot.name);
      expect(restored.description, snapshot.description);
      expect(restored.instructions, snapshot.instructions);
      expect(restored.theme.primaryArgb, theme.primaryArgb);
      expect(restored.theme.fontFamily, theme.fontFamily);
    });

    test('returns null for unknown schema version', () {
      final json = snapshot.toJson()..['schemaVersion'] = 99;
      expect(GenuiAgentSnapshot.fromJson(json), isNull);
    });

    test('returns null for malformed JSON', () {
      expect(GenuiAgentSnapshot.fromJsonString('{'), isNull);
      expect(GenuiAgentSnapshot.fromJsonString('[]'), isNull);
    });
  });
}
