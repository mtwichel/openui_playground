import 'package:dart_mappable/dart_mappable.dart';
import 'package:genui_agent_repository/src/agent_theme.dart';
import 'package:openui_core/openui_core.dart';

part 'genui_agent.mapper.dart';

// OpenUI core types are @experimental in v0.1.
// ignore_for_file: experimental_member_use

final _agentLibraries = Expando<Library<dynamic>>('genuiAgentLibraries');

/// Hosts playground state backed by an OpenUI component [library].
@MappableClass()
class GenuiAgent with GenuiAgentMappable {
  /// Creates a [GenuiAgent] with optional starting [components] and [tools].
  GenuiAgent({
    required this.name,
    required this.description,
    required this.instructions,
    required this.theme,
    List<Component>? components,
    List<Tool>? tools,
  }) {
    if (components != null || tools != null) {
      _agentLibraries[this] = Library<dynamic>(
        components: components ?? <Component>[],
        tools: tools ?? <Tool>[],
      );
    }
  }

  /// Agent display name.
  final String name;

  /// Agent description.
  final String description;

  /// Agent system instructions.
  final String instructions;

  /// Agent visual theme (colors + font family).
  final AgentTheme theme;

  /// Component and tool registry for OpenUI rendering.
  Library<dynamic> get library =>
      _agentLibraries[this] ??
      Library<dynamic>(components: <Component>[], tools: <Tool>[]);

  /// Associates [library] with this agent instance.
  GenuiAgent withLibrary(Library<dynamic> library) {
    _agentLibraries[this] = library;
    return this;
  }
}
