import 'package:bloc/bloc.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:openui_core/openui_core.dart';

part 'tools_event.dart';
part 'tools_state.dart';

class ToolsBloc extends Bloc<ToolsEvent, ToolsState> {
  ToolsBloc(
    GenuiAgentRepository genuiAgentRepository,
  ) : super(
        ToolsState(
          tools: genuiAgentRepository.genuiAgent.library.tools,
        ),
      );
}
