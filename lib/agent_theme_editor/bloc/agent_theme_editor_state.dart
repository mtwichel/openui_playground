part of 'agent_theme_editor_bloc.dart';

class AgentThemeEditorState {
  /// Creates [AgentThemeEditorState].
  const AgentThemeEditorState({required this.theme});

  /// Current agent theme.
  final AgentTheme theme;

  /// Returns a copy with the given fields replaced.
  AgentThemeEditorState copyWith({AgentTheme? theme}) {
    return AgentThemeEditorState(theme: theme ?? this.theme);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentThemeEditorState && theme == other.theme;

  @override
  int get hashCode => theme.hashCode;
}
