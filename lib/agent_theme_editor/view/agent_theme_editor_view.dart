import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:genui_playground/agent_theme_editor/agent_theme_presentation.dart';
import 'package:genui_playground/agent_theme_editor/bloc/agent_theme_editor_bloc.dart';
import 'package:genui_playground/agent_theme_editor/view/agent_theme_color_dialog.dart';
import 'package:genui_playground/agent_theme_editor/view/agent_theme_preview_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _pagePadding = EdgeInsets.fromLTRB(32, 28, 32, 40);
const _maxContentWidth = 960.0;
const _sectionGap = 24.0;

/// Cached Google Font family names for search.
final List<String> kGoogleFontFamilies = GoogleFonts.asMap().keys.toList()
  ..sort();

class AgentThemeEditorView extends StatelessWidget {
  const AgentThemeEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgentThemeEditorBloc, AgentThemeEditorState>(
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
                  Text('Theme', style: theme.textTheme.h2),
                  const SizedBox(height: 8),
                  Text(
                    'Agent visual identity. Preview updates here; other tabs '
                    'use the default playground theme in this release.',
                    style: theme.textTheme.muted,
                  ),
                  const SizedBox(height: _sectionGap),
                  _ColorSection(
                    agentTheme: state.theme,
                    onThemeChanged: (t) =>
                        context.read<AgentThemeEditorBloc>().add(
                          AgentThemeUpdated(t),
                        ),
                  ),
                  const SizedBox(height: _sectionGap),
                  _FontSection(
                    fontFamily: state.theme.fontFamily,
                    onSelected: (family) =>
                        context.read<AgentThemeEditorBloc>().add(
                          AgentThemeUpdated(
                            state.theme.copyWith(fontFamily: family),
                          ),
                        ),
                  ),
                  const SizedBox(height: _sectionGap),
                  AgentThemePreviewCard(theme: state.theme),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ColorSection extends StatelessWidget {
  const _ColorSection({
    required this.agentTheme,
    required this.onThemeChanged,
  });

  final AgentTheme agentTheme;
  final ValueChanged<AgentTheme> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final shad = ShadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Colors', style: shad.textTheme.h4),
        const SizedBox(height: 12),
        _ColorRow(
          label: 'Primary',
          argb: agentTheme.primaryArgb,
          onChanged: (c) => onThemeChanged(
            agentTheme.copyWith(primaryArgb: colorToArgb(c)),
          ),
        ),
        _ColorRow(
          label: 'On primary',
          argb: agentTheme.onPrimaryArgb,
          onChanged: (c) => onThemeChanged(
            agentTheme.copyWith(onPrimaryArgb: colorToArgb(c)),
          ),
        ),
        _ColorRow(
          label: 'Background',
          argb: agentTheme.backgroundArgb,
          onChanged: (c) => onThemeChanged(
            agentTheme.copyWith(backgroundArgb: colorToArgb(c)),
          ),
        ),
        _ColorRow(
          label: 'On background',
          argb: agentTheme.onBackgroundArgb,
          onChanged: (c) => onThemeChanged(
            agentTheme.copyWith(onBackgroundArgb: colorToArgb(c)),
          ),
        ),
        _ColorRow(
          label: 'Accent',
          argb: agentTheme.accentArgb,
          onChanged: (c) => onThemeChanged(
            agentTheme.copyWith(accentArgb: colorToArgb(c)),
          ),
        ),
        _ColorRow(
          label: 'On accent',
          argb: agentTheme.onAccentArgb,
          onChanged: (c) => onThemeChanged(
            agentTheme.copyWith(onAccentArgb: colorToArgb(c)),
          ),
        ),
      ],
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow({
    required this.label,
    required this.argb,
    required this.onChanged,
  });

  final String label;
  final int argb;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    final color = argb.toColor();
    final hex =
        '#${(argb & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
    final shad = ShadTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: Text(label, style: shad.textTheme.small)),
          Text(
            hex,
            style: shad.textTheme.small.copyWith(fontFamily: 'monospace'),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () async {
              final picked = await showAgentThemeColorDialog(
                context: context,
                initial: color,
              );
              if (picked != null) onChanged(picked);
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: shad.colorScheme.border),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FontSection extends StatefulWidget {
  const _FontSection({
    required this.fontFamily,
    required this.onSelected,
  });

  final String fontFamily;
  final ValueChanged<String> onSelected;

  @override
  State<_FontSection> createState() => _FontSectionState();
}

class _FontSectionState extends State<_FontSection> {
  final _controller = TextEditingController();
  List<String> _matches = [];

  @override
  void initState() {
    super.initState();
    _controller.text = widget.fontFamily;
    _filter(widget.fontFamily);
  }

  @override
  void didUpdateWidget(_FontSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fontFamily != widget.fontFamily) {
      _controller.text = widget.fontFamily;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _filter(String query) {
    final q = query.trim().toLowerCase();
    setState(() {
      _matches = q.isEmpty
          ? kGoogleFontFamilies.take(20).toList()
          : kGoogleFontFamilies
                .where((f) => f.toLowerCase().contains(q))
                .take(20)
                .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final shad = ShadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Typography', style: shad.textTheme.h4),
        const SizedBox(height: 8),
        ShadInput(
          controller: _controller,
          placeholder: const Text('Search Google Fonts'),
          onChanged: _filter,
        ),
        const SizedBox(height: 8),
        if (_matches.isEmpty)
          Text('No fonts match', style: shad.textTheme.muted)
        else
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: shad.colorScheme.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _matches.length,
              itemBuilder: (context, index) {
                final family = _matches[index];
                final selected = family == widget.fontFamily;
                return ListTile(
                  dense: true,
                  title: Text(family),
                  selected: selected,
                  onTap: () {
                    _controller.text = family;
                    widget.onSelected(family);
                    _filter(family);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
