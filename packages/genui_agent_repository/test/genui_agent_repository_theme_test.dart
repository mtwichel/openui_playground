import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:test/test.dart';

void main() {
  group('GenuiAgentRepository theme', () {
    const initialTheme = AgentTheme(
      primaryArgb: 0xFF0f172a,
      onPrimaryArgb: 0xFFf8fafc,
      backgroundArgb: 0xFFFFFFFF,
      onBackgroundArgb: 0xFF020817,
      accentArgb: 0xFFf1f5f9,
      onAccentArgb: 0xFF0f172a,
      fontFamily: 'Inter',
    );

    late GenuiAgentRepository repository;

    setUp(() {
      repository = GenuiAgentRepository(
        GenuiAgent(
          name: 'n',
          description: 'd',
          instructions: 'i',
          theme: initialTheme,
        ),
      );
    });

    test('setTheme updates agent theme', () {
      const updated = AgentTheme(
        primaryArgb: 0xFF112233,
        onPrimaryArgb: 0xFFf8fafc,
        backgroundArgb: 0xFFFFFFFF,
        onBackgroundArgb: 0xFF020817,
        accentArgb: 0xFFf1f5f9,
        onAccentArgb: 0xFF0f172a,
        fontFamily: 'Roboto',
      );

      repository.setTheme(updated);

      expect(repository.genuiAgent.theme, updated);
      expect(repository.genuiAgent.name, 'n');
    });
  });
}
