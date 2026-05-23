import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';

/// Flushes agent persistence when the app pauses or detaches.
class AgentPersistenceLifecycleObserver with WidgetsBindingObserver {
  /// Creates an [AgentPersistenceLifecycleObserver].
  AgentPersistenceLifecycleObserver(this._repository);

  final GenuiAgentRepository _repository;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      unawaited(_repository.flush());
    }
  }
}
