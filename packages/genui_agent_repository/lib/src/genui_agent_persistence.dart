import 'package:genui_agent_repository/src/agent_theme.dart';
import 'package:genui_agent_repository/src/genui_agent.dart';
import 'package:openui_core/openui_core.dart';

// OpenUI core types are @experimental in v0.1.
// ignore_for_file: experimental_member_use

/// Encodes [agent] as JSON for persistence (components/tools omitted).
String encodeAgent(GenuiAgent agent) => agent.toJson();

/// Builds a [GenuiAgent] from optional persisted JSON and runtime [library].
GenuiAgent agentFromEncoded({
  required String? encoded,
  required Library<dynamic> library,
  required AgentTheme defaultTheme,
}) {
  final decoded = _decodePersistedAgent(encoded);
  if (decoded == null) {
    return GenuiAgent(
      name: '',
      description: '',
      instructions: '',
      theme: defaultTheme,
      components: library.components,
      tools: library.tools,
    );
  }

  return decoded.withLibrary(library);
}

GenuiAgent? _decodePersistedAgent(String? encoded) {
  if (encoded == null) {
    return null;
  }
  try {
    return GenuiAgentMapper.fromJson(encoded);
  } on Object {
    return null;
  }
}
