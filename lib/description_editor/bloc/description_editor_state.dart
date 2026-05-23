part of 'description_editor_bloc.dart';

@MappableClass()
class DescriptionEditorState with DescriptionEditorStateMappable {
  const DescriptionEditorState({
    this.name = '',
    this.description = '',
    this.instructions = '',
  });

  final String name;
  final String description;
  final String instructions;
}
