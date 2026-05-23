import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'shell_bloc.mapper.dart';
part 'shell_event.dart';
part 'shell_state.dart';

class ShellBloc extends Bloc<ShellEvent, ShellState> {
  ShellBloc() : super(const ShellState()) {
    on<ShellTabSelected>(_onShellTabSelected);
  }

  void _onShellTabSelected(ShellTabSelected event, Emitter<ShellState> emit) {
    emit(
      state.copyWith(
        selectedTab: event.tab,
      ),
    );
  }
}
