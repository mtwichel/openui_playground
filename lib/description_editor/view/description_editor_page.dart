import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:genui_playground/description_editor/description_editor.dart';

class DescriptionEditorPage extends StatelessWidget {
  const DescriptionEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DescriptionEditorBloc(
        genuiAgentRepository: context.read<GenuiAgentRepository>(),
      ),
      child: const DescriptionEditorView(),
    );
  }
}
