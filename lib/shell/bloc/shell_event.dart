part of 'shell_bloc.dart';

sealed class ShellEvent {
  const ShellEvent();
}

class ShellTabSelected extends ShellEvent {
  const ShellTabSelected({required this.tab});
  final ShellTab tab;
}
