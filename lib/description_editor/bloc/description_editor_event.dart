part of 'description_editor_bloc.dart';

sealed class DescriptionEditorEvent {
  const DescriptionEditorEvent();
}

class DescriptionChanged extends DescriptionEditorEvent {
  const DescriptionChanged({required this.description});
  final String description;
}

class NameChanged extends DescriptionEditorEvent {
  const NameChanged({required this.name});
  final String name;
}

class InstructionsChanged extends DescriptionEditorEvent {
  const InstructionsChanged({required this.instructions});
  final String instructions;
}
