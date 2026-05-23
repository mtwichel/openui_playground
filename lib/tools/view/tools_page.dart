import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:genui_playground/tools/tools.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ToolsBloc(
        context.read<GenuiAgentRepository>(),
      ),
      child: const ToolsView(),
    );
  }
}
