import 'package:genui_agent_repository/src/agent_theme.dart';
import 'package:genui_agent_repository/src/genui_agent.dart';

/// {@template genui_agent_repository}
/// A genui package managing the genui agent domain.
/// {@endtemplate}
class GenuiAgentRepository {
  /// {@macro genui_agent_repository}
  GenuiAgentRepository(
    GenuiAgent genuiAgent,
  ) : _genuiAgent = genuiAgent;

  GenuiAgent _genuiAgent;

  /// The genui agent.
  GenuiAgent get genuiAgent => _genuiAgent;

  /// Sets the name of the genui agent.
  void setName(String name) {
    _genuiAgent = _genuiAgent.copyWith(name: name);
  }

  /// Sets the description of the genui agent.
  void setDescription(String description) {
    _genuiAgent = _genuiAgent.copyWith(description: description);
  }

  /// Sets the instructions of the genui agent.
  void setInstructions(String instructions) {
    _genuiAgent = _genuiAgent.copyWith(instructions: instructions);
  }

  /// Sets the visual theme of the genui agent.
  void setTheme(AgentTheme theme) {
    _genuiAgent = _genuiAgent.copyWith(theme: theme);
  }
}
