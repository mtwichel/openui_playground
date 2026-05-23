import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:genui_playground/agent_theme_editor/agent_theme_defaults.dart';
import 'package:genui_playground/agent_theme_editor/agent_theme_presentation.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Live preview of [theme] using merged Shad theme + Google Font.
class AgentThemePreviewCard extends StatefulWidget {
  /// Creates [AgentThemePreviewCard].
  const AgentThemePreviewCard({required this.theme, super.key});

  /// Theme to preview.
  final AgentTheme theme;

  @override
  State<AgentThemePreviewCard> createState() => _AgentThemePreviewCardState();
}

class _AgentThemePreviewCardState extends State<AgentThemePreviewCard> {
  String? _loadedFamily;
  String? _error;
  bool _loading = false;
  int _requestId = 0;

  @override
  void initState() {
    super.initState();
    unawaited(_loadFont(widget.theme.fontFamily));
  }

  @override
  void didUpdateWidget(AgentThemePreviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme.fontFamily != widget.theme.fontFamily) {
      unawaited(_loadFont(widget.theme.fontFamily));
    }
  }

  Future<void> _loadFont(String family) async {
    final id = ++_requestId;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await GoogleFonts.pendingFonts([
        GoogleFonts.getFont(family),
      ]);
      if (!mounted || id != _requestId) return;
      setState(() {
        _loadedFamily = family;
        _loading = false;
        _error = null;
      });
    } on Exception {
      if (!mounted || id != _requestId) return;
      setState(() {
        _loading = false;
        _error = "Couldn't load font";
        _loadedFamily = slateLightAgentTheme().fontFamily;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final base = ShadTheme.of(context);
    final merged = widget.theme.applyTo(base);
    final family = _loadedFamily ?? widget.theme.fontFamily;
    TextStyle textStyle(TextStyle style) {
      try {
        return GoogleFonts.getFont(family, textStyle: style);
      } on Exception {
        return style;
      }
    }

    return ShadTheme(
      data: merged,
      child: ShadCard(
        title: const Text('Preview'),
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Heading',
                  style: textStyle(merged.textTheme.h3),
                ),
                const SizedBox(height: 8),
                Text(
                  'Body text on the agent background color.',
                  style: textStyle(merged.textTheme.muted),
                ),
                const SizedBox(height: 16),
                ShadButton(
                  onPressed: () {},
                  child: const Text('Primary'),
                ),
                const SizedBox(height: 12),
                const ShadInput(placeholder: Text('Input field')),
                const SizedBox(height: 12),
                ShadButton.secondary(
                  onPressed: () {},
                  child: const Text('Accent action'),
                ),
              ],
            ),
            if (_loading)
              const Positioned.fill(
                child: ColoredBox(
                  color: Color(0x88FFFFFF),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            if (_error != null && !_loading)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Text(
                  _error!,
                  style: merged.textTheme.small.copyWith(
                    color: merged.colorScheme.destructive,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
