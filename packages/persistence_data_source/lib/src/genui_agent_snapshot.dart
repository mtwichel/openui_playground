import 'dart:convert';

import 'package:persistence_data_source/src/genui_agent_theme_snapshot.dart';

/// Supported [schemaVersion] for on-disk agent files.
const int kGenuiAgentSnapshotSchemaVersion = 1;

/// Serializable agent state for `.genuiagent` files (v1).
class GenuiAgentSnapshot {
  /// Creates a [GenuiAgentSnapshot].
  const GenuiAgentSnapshot({
    required this.name,
    required this.description,
    required this.instructions,
    required this.theme,
    this.schemaVersion = kGenuiAgentSnapshotSchemaVersion,
  });

  /// JSON schema version.
  final int schemaVersion;

  /// Agent display name.
  final String name;

  /// Agent description.
  final String description;

  /// Agent system instructions.
  final String instructions;

  /// Visual theme tokens.
  final GenuiAgentThemeSnapshot theme;

  /// Parses JSON bytes/string into a snapshot, or returns null if invalid.
  static GenuiAgentSnapshot? fromJsonString(String source) {
    try {
      final decoded = jsonDecode(source);
      return fromJson(decoded);
    } on Object {
      return null;
    }
  }

  /// Parses a JSON object into a snapshot, or returns null if invalid.
  static GenuiAgentSnapshot? fromJson(Object? json) {
    if (json is! Map<String, dynamic>) {
      return null;
    }
    final schemaVersion = json['schemaVersion'];
    if (schemaVersion != kGenuiAgentSnapshotSchemaVersion) {
      return null;
    }
    final name = json['name'];
    final description = json['description'];
    final instructions = json['instructions'];
    final theme = GenuiAgentThemeSnapshot.fromJson(json['theme']);
    if (name is! String ||
        description is! String ||
        instructions is! String ||
        theme == null) {
      return null;
    }
    return GenuiAgentSnapshot(
      schemaVersion: schemaVersion as int,
      name: name,
      description: description,
      instructions: instructions,
      theme: theme,
    );
  }

  /// Encodes this snapshot as JSON.
  Map<String, dynamic> toJson() => {
    'schemaVersion': schemaVersion,
    'name': name,
    'description': description,
    'instructions': instructions,
    'theme': theme.toJson(),
  };

  /// Encodes this snapshot as a JSON string.
  String toJsonString() => jsonEncode(toJson());
}
