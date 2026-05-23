import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genui_playground/agent_theme_editor/agent_theme_editor.dart';
import 'package:genui_playground/catalog/catalog.dart';
import 'package:genui_playground/description_editor/description_editor.dart';
import 'package:genui_playground/shell/shell.dart';
import 'package:genui_playground/tools/tools.dart';
import 'package:recase/recase.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ShellView extends StatelessWidget {
  const ShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShellBloc, ShellState>(
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              ShadNavRail(
                selectedIndex: state.selectedTab.index,
                extended: true,
                destinations: [
                  for (final tab in ShellTab.values)
                    ShadNavRailDestination(
                      icon: switch (tab) {
                        .definition => Icons.description,
                        .components => Icons.widgets,
                        .tools => Icons.build,
                        .theme => Icons.palette,
                      },
                      label: tab.name.titleCase,
                    ),
                ],
                onDestinationSelected: (index) {
                  context.read<ShellBloc>().add(
                    ShellTabSelected(tab: ShellTab.values[index]),
                  );
                },
              ),
              Expanded(
                child: switch (state.selectedTab) {
                  ShellTab.definition => const DescriptionEditorPage(),
                  ShellTab.components => const CatalogPage(),
                  ShellTab.tools => const ToolsPage(),
                  ShellTab.theme => const AgentThemeEditorPage(),
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ShadNavRail extends StatelessWidget {
  const ShadNavRail({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
    this.extended = false,
    this.leading,
    this.trailing,
  });

  final List<ShadNavRailDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool extended;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      width: extended ? 220 : 64,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        border: Border(
          right: BorderSide(color: theme.colorScheme.border),
        ),
      ),
      child: Column(
        children: [
          if (leading != null) ...[
            const SizedBox(height: 12),
            leading!,
          ],
          const SizedBox(height: 8),
          for (var i = 0; i < destinations.length; i++)
            _RailItem(
              destination: destinations[i],
              selected: i == selectedIndex,
              extended: extended,
              onTap: () => onDestinationSelected(i),
            ),
          const Spacer(),
          ?trailing,
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class ShadNavRailDestination {
  const ShadNavRailDestination({
    required this.icon,
    required this.label,
  });
  final IconData icon;
  final String label;
}

class _RailItem extends StatelessWidget {
  const _RailItem({
    required this.destination,
    required this.selected,
    required this.extended,
    required this.onTap,
  });

  final ShadNavRailDestination destination;
  final bool selected;
  final bool extended;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final button = ShadButton.ghost(
      onPressed: onTap,
      backgroundColor: selected
          ? theme.colorScheme.accent
          : const Color(0x00000000),
      foregroundColor: selected
          ? theme.colorScheme.accentForeground
          : theme.colorScheme.mutedForeground,
      width: extended ? double.infinity : 48,
      mainAxisAlignment: extended
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      leading: Icon(destination.icon, size: 18),
      child: extended ? Text(destination.label) : null,
    );

    if (extended) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: button,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ShadTooltip(
        builder: (_) => Text(destination.label),
        child: button,
      ),
    );
  }
}
