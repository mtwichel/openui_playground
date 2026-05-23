import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:genui_playground/catalog/catalog.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CatalogBloc(
        context.read<GenuiAgentRepository>(),
      ),
      child: const CatalogView(),
    );
  }
}
