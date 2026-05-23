part of 'agent_theme_editor_bloc.dart';

sealed class AgentThemeEditorEvent {
  const AgentThemeEditorEvent();
}

/// Replaces the agent theme (persisted immediately).
class AgentThemeUpdated extends AgentThemeEditorEvent {
  /// Creates [AgentThemeUpdated].
  const AgentThemeUpdated(this.theme);

  /// New theme value.
  final AgentTheme theme;
}
