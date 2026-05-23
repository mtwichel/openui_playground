import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';

part 'description_editor_bloc.mapper.dart';
part 'description_editor_event.dart';
part 'description_editor_state.dart';

class DescriptionEditorBloc
    extends Bloc<DescriptionEditorEvent, DescriptionEditorState> {
  DescriptionEditorBloc({
    required GenuiAgentRepository genuiAgentRepository,
  }) : _genuiAgentRepository = genuiAgentRepository,
       super(
         DescriptionEditorState(
           name: genuiAgentRepository.genuiAgent.name,
           description: genuiAgentRepository.genuiAgent.description,
           instructions: genuiAgentRepository.genuiAgent.instructions,
         ),
       ) {
    on<DescriptionChanged>(_onDescriptionChanged);
    on<NameChanged>(_onNameChanged);
    on<InstructionsChanged>(_onInstructionsChanged);
  }

  final GenuiAgentRepository _genuiAgentRepository;

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<DescriptionEditorState> emit,
  ) {
    _genuiAgentRepository.setDescription(event.description);
    emit(state.copyWith(description: event.description));
  }

  void _onNameChanged(NameChanged event, Emitter<DescriptionEditorState> emit) {
    _genuiAgentRepository.setName(event.name);
    emit(state.copyWith(name: event.name));
  }

  void _onInstructionsChanged(
    InstructionsChanged event,
    Emitter<DescriptionEditorState> emit,
  ) {
    _genuiAgentRepository.setInstructions(event.instructions);
    emit(state.copyWith(instructions: event.instructions));
  }
}
