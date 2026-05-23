import 'package:bloc/bloc.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:openui_core/openui_core.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc(
    GenuiAgentRepository genuiAgentRepository,
  ) : super(
        CatalogState(
          components: genuiAgentRepository.genuiAgent.library.components,
        ),
      );
}
