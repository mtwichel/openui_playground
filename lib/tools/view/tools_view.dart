// OpenUI core APIs are marked @experimental until the v0.2 API freeze.
// ignore_for_file: experimental_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genui_playground/tools/tools.dart';
import 'package:openui_core/openui_core.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _pagePadding = EdgeInsets.fromLTRB(32, 28, 32, 40);
const _maxContentWidth = 960.0;
const _sectionGap = 24.0;

class ToolsView extends StatelessWidget {
  const ToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToolsBloc, ToolsState>(
      builder: (context, state) {
        final theme = ShadTheme.of(context);
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: _pagePadding,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxContentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Tools', style: theme.textTheme.h2),
                  const SizedBox(height: 8),
                  Text(
                    'Callable tools available to the GenUI agent, with input '
                    'and output schemas.',
                    style: theme.textTheme.muted,
                  ),
                  const SizedBox(height: _sectionGap),
                  if (state.tools.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Center(
                        child: Text(
                          'No tools registered yet.',
                          style: theme.textTheme.muted,
                        ),
                      ),
                    )
                  else
                    for (final tool in state.tools)
                      Padding(
                        padding: const EdgeInsets.only(bottom: _sectionGap),
                        child: ToolRow(tool: tool),
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

class ToolRow extends StatelessWidget {
  const ToolRow({required this.tool, super.key});

  final Tool tool;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      title: Text(tool.name),
      description: Text(tool.description),
      padding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SchemaSection(
              label: 'Input',
              schemaText: formatToolSchema(tool.input),
              theme: theme,
            ),
            const SizedBox(height: 16),
            _SchemaSection(
              label: 'Output',
              schemaText: formatToolSchema(tool.output),
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }
}

class _SchemaSection extends StatelessWidget {
  const _SchemaSection({
    required this.label,
    required this.schemaText,
    required this.theme,
  });

  final String label;
  final String schemaText;
  final ShadThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: theme.textTheme.small),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.muted,
            borderRadius: BorderRadius.circular(6),
          ),
          child: SelectableText(
            schemaText,
            style: theme.textTheme.small.copyWith(
              fontFamily: 'monospace',
              fontFamilyFallback: const ['Courier', 'monospace'],
            ),
          ),
        ),
      ],
    );
  }
}
