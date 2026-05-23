import 'package:bloc/bloc.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';

part 'agent_theme_editor_event.dart';
part 'agent_theme_editor_state.dart';

/// Manages agent theme editing and repository persistence.
class AgentThemeEditorBloc
    extends Bloc<AgentThemeEditorEvent, AgentThemeEditorState> {
  /// Creates [AgentThemeEditorBloc].
  AgentThemeEditorBloc({
    required GenuiAgentRepository genuiAgentRepository,
  }) : _genuiAgentRepository = genuiAgentRepository,
       super(
         AgentThemeEditorState(
           theme: genuiAgentRepository.genuiAgent.theme,
         ),
       ) {
    on<AgentThemeUpdated>(_onAgentThemeUpdated);
  }

  final GenuiAgentRepository _genuiAgentRepository;

  void _onAgentThemeUpdated(
    AgentThemeUpdated event,
    Emitter<AgentThemeEditorState> emit,
  ) {
    _genuiAgentRepository.setTheme(event.theme);
    emit(state.copyWith(theme: event.theme));
  }
}
