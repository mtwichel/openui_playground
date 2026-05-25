import 'package:genui_agent_repository/src/agent_theme.dart';
import 'package:genui_agent_repository/src/genui_agent.dart';
import 'package:genui_agent_repository/src/genui_agent_persistence.dart';
import 'package:openui_core/openui_core.dart';
import 'package:persistence_data_source/persistence_data_source.dart';

// OpenUI core types are @experimental in v0.1.
// ignore_for_file: experimental_member_use

/// {@template genui_agent_repository}
/// A genui package managing the genui agent domain.
/// {@endtemplate}
class GenuiAgentRepository {
  /// {@macro genui_agent_repository}
  GenuiAgentRepository(
    GenuiAgent genuiAgent, {
    PersistenceDataSource? dataSource,
  }) : _genuiAgent = genuiAgent,
       _dataSource = dataSource ?? const NoOpPersistenceDataSource();

  GenuiAgentRepository._(
    this._genuiAgent,
    this._dataSource,
  );

  /// Loads from [dataSource] and returns a repository backed by that source.
  static Future<GenuiAgentRepository> create({
    required PersistenceDataSource dataSource,
    required Library<dynamic> library,
    required AgentTheme defaultTheme,
  }) async {
    final encoded = await dataSource.read();
    final agent = agentFromEncoded(
      encoded: encoded,
      library: library,
      defaultTheme: defaultTheme,
    );
    return GenuiAgentRepository._(agent, dataSource);
  }

  GenuiAgent _genuiAgent;
  final PersistenceDataSource _dataSource;

  /// The genui agent.
  GenuiAgent get genuiAgent => _genuiAgent;

  /// Immediately persists any pending contents via the data source.
  Future<void> flush() => _dataSource.flush();

  /// Sets the name of the genui agent.
  void setName(String name) {
    _genuiAgent = _copyPreservingLibrary(name: name);
    _persist();
  }

  /// Sets the description of the genui agent.
  void setDescription(String description) {
    _genuiAgent = _copyPreservingLibrary(description: description);
    _persist();
  }

  /// Sets the instructions of the genui agent.
  void setInstructions(String instructions) {
    _genuiAgent = _copyPreservingLibrary(instructions: instructions);
    _persist();
  }

  /// Sets the visual theme of the genui agent.
  void setTheme(AgentTheme theme) {
    _genuiAgent = _copyPreservingLibrary(theme: theme);
    _persist();
  }

  GenuiAgent _copyPreservingLibrary({
    String? name,
    String? description,
    String? instructions,
    AgentTheme? theme,
  }) {
    final library = _genuiAgent.library;
    return _genuiAgent
        .copyWith(
          name: name,
          description: description,
          instructions: instructions,
          theme: theme,
        )
        .withLibrary(library);
  }

  void _persist() {
    _dataSource.write(encodeAgent(_genuiAgent));
  }
}
