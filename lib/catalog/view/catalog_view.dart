// OpenUI core APIs are marked @experimental until the v0.2 API freeze.
// ignore_for_file: experimental_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genui_playground/catalog/catalog.dart';
import 'package:openui/openui.dart';
import 'package:openui_components/openui_components.dart';
import 'package:openui_core/openui_core.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _pagePadding = EdgeInsets.fromLTRB(32, 28, 32, 40);
const _maxContentWidth = 960.0;
const _sectionGap = 24.0;

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        final theme = ShadTheme.of(context);
        final library = standardLibrary();
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: _pagePadding,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxContentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Components', style: theme.textTheme.h2),
                  const SizedBox(height: 8),
                  Text(
                    'Live previews of each OpenUI component in the standard '
                    'library.',
                    style: theme.textTheme.muted,
                  ),
                  const SizedBox(height: _sectionGap),
                  for (final component in state.components)
                    Padding(
                      padding: const EdgeInsets.only(bottom: _sectionGap),
                      child: ComponentRow(
                        component: component,
                        library: library,
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

class ComponentRow extends StatelessWidget {
  const ComponentRow({
    required this.component,
    required this.library,
    super.key,
  });

  final Component component;
  final Library<Widget> library;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      title: Text(component.name),
      description: component.description == null
          ? null
          : Text(component.description!),
      padding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Renderer(
          response: catalogPreviewSource(component.name),
          library: library,
        ),
      ),
    );
  }
}
