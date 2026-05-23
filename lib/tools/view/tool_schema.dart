import 'dart:convert';

import 'package:openui_core/openui_core.dart';

const _jsonEncoder = JsonEncoder.withIndent('  ');

/// Pretty-prints a tool [schema] as indented JSON, or `"null"` when absent.
String formatToolSchema(Schema? schema) {
  if (schema == null) return 'null';
  return _jsonEncoder.convert(schema.toJson());
}
