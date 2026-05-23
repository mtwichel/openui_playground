import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genui_playground/description_editor/description_editor.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _pagePadding = EdgeInsets.fromLTRB(32, 28, 32, 40);
const _maxContentWidth = 720.0;
const _fieldGap = 24.0;

class DescriptionEditorView extends StatelessWidget {
  const DescriptionEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DescriptionEditorBloc, DescriptionEditorState>(
      builder: (context, state) {
        final theme = ShadTheme.of(context);
        final bloc = context.read<DescriptionEditorBloc>();

        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: _pagePadding,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxContentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Definition', style: theme.textTheme.h2),
                  const SizedBox(height: 8),
                  Text(
                    'Name, description, and instructions for the GenUI agent.',
                    style: theme.textTheme.muted,
                  ),
                  const SizedBox(height: _fieldGap),
                  _LabeledField(
                    label: 'Name',
                    child: ShadInput(
                      placeholder: const Text('Agent name'),
                      initialValue: state.name,
                      onChanged: (value) => bloc.add(NameChanged(name: value)),
                    ),
                  ),
                  const SizedBox(height: _fieldGap),
                  _LabeledField(
                    label: 'Description',
                    child: ShadTextarea(
                      placeholder: const Text(
                        'What this agent does and when to use it',
                      ),
                      initialValue: state.description,
                      minHeight: 120,
                      maxHeight: 240,
                      onChanged: (value) => bloc.add(
                        DescriptionChanged(description: value),
                      ),
                    ),
                  ),
                  const SizedBox(height: _fieldGap),
                  _LabeledField(
                    label: 'Instructions',
                    child: ShadTextarea(
                      placeholder: const Text(
                        'System instructions and behavior guidelines',
                      ),
                      initialValue: state.instructions,
                      minHeight: 200,
                      maxHeight: 480,
                      onChanged: (value) => bloc.add(
                        InstructionsChanged(instructions: value),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: theme.textTheme.small),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
