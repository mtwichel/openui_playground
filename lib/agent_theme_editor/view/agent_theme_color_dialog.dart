import 'package:flutter/material.dart';
import 'package:genui_playground/agent_theme_editor/agent_theme_presentation.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Simple RGB dialog for picking an opaque color.
Future<Color?> showAgentThemeColorDialog({
  required BuildContext context,
  required Color initial,
}) {
  return showDialog<Color>(
    context: context,
    builder: (context) => _AgentThemeColorDialog(initial: initial),
  );
}

class _AgentThemeColorDialog extends StatefulWidget {
  const _AgentThemeColorDialog({required this.initial});

  final Color initial;

  @override
  State<_AgentThemeColorDialog> createState() => _AgentThemeColorDialogState();
}

class _AgentThemeColorDialogState extends State<_AgentThemeColorDialog> {
  late int _red;
  late int _green;
  late int _blue;

  @override
  void initState() {
    super.initState();
    _red = (widget.initial.r * 255).round().clamp(0, 255);
    _green = (widget.initial.g * 255).round().clamp(0, 255);
    _blue = (widget.initial.b * 255).round().clamp(0, 255);
  }

  Color get _color => Color.fromARGB(255, _red, _green, _blue);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick color'),
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            _ChannelSlider(
              label: 'R',
              value: _red,
              onChanged: (v) => setState(() => _red = v.round()),
            ),
            _ChannelSlider(
              label: 'G',
              value: _green,
              onChanged: (v) => setState(() => _green = v.round()),
            ),
            _ChannelSlider(
              label: 'B',
              value: _blue,
              onChanged: (v) => setState(() => _blue = v.round()),
            ),
            const SizedBox(height: 8),
            Text(
              '#${colorToArgb(_color).toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(
          onPressed: () => Navigator.of(context).pop(_color),
          child: const Text('Apply'),
        ),
      ],
    );
  }
}

class _ChannelSlider extends StatelessWidget {
  const _ChannelSlider({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16, child: Text(label)),
        Expanded(
          child: Slider(
            value: value.toDouble(),
            max: 255,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 32, child: Text('$value')),
      ],
    );
  }
}
