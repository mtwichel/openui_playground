import 'package:genui_agent_repository/src/agent_theme.dart';
import 'package:openui_core/openui_core.dart';

// OpenUI core types are @experimental in v0.1.
// ignore_for_file: experimental_member_use

/// Hosts playground state backed by an OpenUI component [library].
class GenuiAgent {
  /// Creates a [GenuiAgent] with optional starting [components] and [tools].
  GenuiAgent({
    required this.name,
    required this.description,
    required this.instructions,
    required this.theme,
    List<Component>? components,
    List<Tool>? tools,
  }) : _components = components ?? <Component>[],
       _tools = tools ?? <Tool>[];

  final List<Component> _components;
  final List<Tool> _tools;
  final String name;
  final String description;
  final String instructions;

  /// Agent visual theme (colors + font family).
  final AgentTheme theme;

  /// Component and tool registry for OpenUI rendering.
  Library<dynamic> get library =>
      Library<dynamic>(components: _components, tools: _tools);

  /// Returns a copy with the given fields replaced.
  GenuiAgent copyWith({
    String? name,
    String? description,
    String? instructions,
    AgentTheme? theme,
    List<Component>? components,
    List<Tool>? tools,
  }) {
    return GenuiAgent(
      name: name ?? this.name,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      theme: theme ?? this.theme,
      components: components ?? _components,
      tools: tools ?? _tools,
    );
  }
}
