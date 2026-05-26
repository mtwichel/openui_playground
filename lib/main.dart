import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:genui_playground/agent_theme_editor/agent_theme_defaults.dart';
import 'package:genui_playground/app_lifecycle.dart';
import 'package:genui_playground/shell/shell.dart';
import 'package:openui_components/openui_components.dart';
import 'package:persistence_data_source/persistence_data_source.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Runs the app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final library = standardLibrary();
  final dataSource = FilePersistenceDataSource(
    file: defaultGenuiAgentPersistenceFile(),
  );
  final repository = await GenuiAgentRepository.create(
    dataSource: dataSource,
    library: library,
    defaultTheme: slateLightAgentTheme(),
  );

  final lifecycleObserver = AgentPersistenceLifecycleObserver(repository);
  WidgetsBinding.instance.addObserver(lifecycleObserver);

  runApp(
    RepositoryProvider<GenuiAgentRepository>.value(
      value: repository,
      child: const MainApp(),
    ),
  );
}

/// Root widget for the playground app.
class MainApp extends StatelessWidget {
  /// Creates a [MainApp].
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadApp(
      title: 'GenUI Playground',
      home: ShellPage(),
    );
  }
}
