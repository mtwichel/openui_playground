import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:genui_playground/agent_theme_editor/bloc/agent_theme_editor_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockGenuiAgentRepository extends Mock implements GenuiAgentRepository {}

void main() {
  late GenuiAgentRepository repository;

  const initialTheme = AgentTheme(
    primaryArgb: 0xFF0f172a,
    onPrimaryArgb: 0xFFf8fafc,
    backgroundArgb: 0xFFFFFFFF,
    onBackgroundArgb: 0xFF020817,
    accentArgb: 0xFFf1f5f9,
    onAccentArgb: 0xFF0f172a,
    fontFamily: 'Inter',
  );

  const updatedTheme = AgentTheme(
    primaryArgb: 0xFF112233,
    onPrimaryArgb: 0xFFf8fafc,
    backgroundArgb: 0xFFFFFFFF,
    onBackgroundArgb: 0xFF020817,
    accentArgb: 0xFFf1f5f9,
    onAccentArgb: 0xFF0f172a,
    fontFamily: 'Roboto',
  );

  final agent = GenuiAgent(
    name: '',
    description: '',
    instructions: '',
    theme: initialTheme,
  );

  setUp(() {
    repository = _MockGenuiAgentRepository();
    registerFallbackValue(initialTheme);
    when(() => repository.genuiAgent).thenReturn(agent);
    when(() => repository.setTheme(any())).thenReturn(null);
  });

  blocTest<AgentThemeEditorBloc, AgentThemeEditorState>(
    'emits updated theme and calls setTheme',
    build: () => AgentThemeEditorBloc(genuiAgentRepository: repository),
    act: (bloc) => bloc.add(const AgentThemeUpdated(updatedTheme)),
    expect: () => [const AgentThemeEditorState(theme: updatedTheme)],
    verify: (_) {
      verify(() => repository.setTheme(updatedTheme)).called(1);
    },
  );
}
