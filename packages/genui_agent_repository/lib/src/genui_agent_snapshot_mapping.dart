import 'package:genui_agent_repository/src/agent_theme.dart';
import 'package:genui_agent_repository/src/genui_agent.dart';
import 'package:genui_agent_repository/src/genui_agent_snapshot.dart';
import 'package:genui_agent_repository/src/genui_agent_theme_snapshot.dart';
import 'package:openui_core/openui_core.dart';

// OpenUI core types are @experimental in v0.1.
// ignore_for_file: experimental_member_use

/// Builds a [GenuiAgentSnapshot] from [agent].
GenuiAgentSnapshot snapshotFromAgent(GenuiAgent agent) {
  final theme = agent.theme;
  return GenuiAgentSnapshot(
    name: agent.name,
    description: agent.description,
    instructions: agent.instructions,
    theme: GenuiAgentThemeSnapshot(
      primaryArgb: theme.primaryArgb,
      onPrimaryArgb: theme.onPrimaryArgb,
      backgroundArgb: theme.backgroundArgb,
      onBackgroundArgb: theme.onBackgroundArgb,
      accentArgb: theme.accentArgb,
      onAccentArgb: theme.onAccentArgb,
      fontFamily: theme.fontFamily,
    ),
  );
}

/// Encodes [agent] as a JSON string for persistence.
String encodeAgent(GenuiAgent agent) => snapshotFromAgent(agent).toJsonString();

/// Builds a [GenuiAgent] from optional persisted JSON and runtime [library].
GenuiAgent agentFromEncoded({
  required String? encoded,
  required Library<dynamic> library,
  required AgentTheme defaultTheme,
}) {
  final snapshot = GenuiAgentSnapshot.fromJsonString(encoded);
  if (snapshot == null) {
    return GenuiAgent(
      name: '',
      description: '',
      instructions: '',
      theme: defaultTheme,
      components: library.components,
      tools: library.tools,
    );
  }

  return GenuiAgent(
    name: snapshot.name,
    description: snapshot.description,
    instructions: snapshot.instructions,
    theme: agentThemeFromSnapshot(snapshot.theme),
    components: library.components,
    tools: library.tools,
  );
}

/// Maps a persisted theme snapshot to [AgentTheme].
AgentTheme agentThemeFromSnapshot(GenuiAgentThemeSnapshot snapshot) {
  return AgentTheme(
    primaryArgb: snapshot.primaryArgb,
    onPrimaryArgb: snapshot.onPrimaryArgb,
    backgroundArgb: snapshot.backgroundArgb,
    onBackgroundArgb: snapshot.onBackgroundArgb,
    accentArgb: snapshot.accentArgb,
    onAccentArgb: snapshot.onAccentArgb,
    fontFamily: snapshot.fontFamily,
  );
}
