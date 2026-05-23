part of 'shell_bloc.dart';

@MappableEnum()
enum ShellTab {
  definition,
  components,
  tools,
  theme,
}

@MappableClass()
class ShellState with ShellStateMappable {
  const ShellState({this.selectedTab = ShellTab.definition});

  final ShellTab selectedTab;
}
