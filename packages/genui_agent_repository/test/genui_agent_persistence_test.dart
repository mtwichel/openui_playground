import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:test/test.dart';

void main() {
  const theme = AgentTheme(
    primaryArgb: 0xFF112233,
    onPrimaryArgb: 0xFFf8fafc,
    backgroundArgb: 0xFFFFFFFF,
    onBackgroundArgb: 0xFF020817,
    accentArgb: 0xFFf1f5f9,
    onAccentArgb: 0xFF0f172a,
    fontFamily: 'Inter',
  );

  final agent = GenuiAgent(
    name: 'Agent',
    description: 'Desc',
    instructions: 'Do things',
    theme: theme,
  );

  group('GenuiAgent persistence JSON', () {
    test('toJson round-trips persistable fields', () {
      final json = agent.toJson();
      final restored = GenuiAgentMapper.fromJson(json);

      expect(restored.name, agent.name);
      expect(restored.description, agent.description);
      expect(restored.instructions, agent.instructions);
      expect(restored.theme, agent.theme);
      expect(restored.library.components, isEmpty);
      expect(restored.library.tools, isEmpty);
    });

    test('encodeAgent matches toJson', () {
      expect(encodeAgent(agent), agent.toJson());
    });

    test('returns default agent for invalid JSON', () {
      final restored = agentFromEncoded(
        encoded: '{',
        library: agent.library,
        defaultTheme: theme,
      );

      expect(restored.name, '');
      expect(restored.theme, theme);
    });
  });
}
