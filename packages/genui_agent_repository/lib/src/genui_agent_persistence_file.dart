import 'dart:io';

import 'package:path/path.dart' as p;

/// Default on-disk location for the playground's single agent file.
File defaultGenuiAgentPersistenceFile({Directory? rootDirectory}) {
  final root = rootDirectory ?? Directory.systemTemp;
  return File(
    p.join(root.path, 'genui_playground', 'default.genuiagent'),
  );
}
