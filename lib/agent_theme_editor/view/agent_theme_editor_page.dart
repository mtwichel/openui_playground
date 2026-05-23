import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:genui_playground/agent_theme_editor/bloc/agent_theme_editor_bloc.dart';
import 'package:genui_playground/agent_theme_editor/view/agent_theme_editor_view.dart';

/// Theme tab route.
class AgentThemeEditorPage extends StatelessWidget {
  /// Creates [AgentThemeEditorPage].
  const AgentThemeEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AgentThemeEditorBloc(
        genuiAgentRepository: context.read<GenuiAgentRepository>(),
      ),
      child: const AgentThemeEditorView(),
    );
  }
}
