import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/screens/new_consigner.dart';
import 'package:gen_pdf/widgets/base_home_screen.dart';

class Consigners extends StatelessWidget {
  const Consigners({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsignerBloc, ConsignerState>(
        listener: (context, state) {
          if (state is DeletingConsigner) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.quantity == 1
                    ? "Eliminando cliente"
                    : "Eliminando clientes"),
              ),
            );
          } else if (state is DeletedConsigner) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.quantity == 1
                    ? "Cliente eliminado"
                    : "Se han eliminado ${state.quantity} clientes"),
              ),
            );
          }
        },
        builder: (context, state) => BaseHomeScreen(
            title: "Clientes",
            actions: (selecteds) => [
                  TextButton.icon(
                      onPressed: selecteds.isEmpty
                          ? null
                          : () {
                              context
                                  .read<ConsignerBloc>()
                                  .add(DeleteConsigners(selecteds));
                            },
                      icon: const Icon(Icons.delete),
                      label: const Text("Eliminar")),
                ],
            onInit: () =>
                context.read<ConsignerBloc>().add(const GetAllConsigners()),
            itemCount: state.consigners.length,
            itemBuilder: (index, selecteds, select) => Card(
                borderOnForeground: true,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: selecteds
                              .contains(state.consigners.elementAt(index).id),
                          onChanged: (value) {
                            select(state.consigners.elementAt(index).id);
                          }),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            state.consigners.elementAt(index).name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(height: 0),
                          ),
                          Text(state.consigners.elementAt(index).address),
                          Text(
                              "NIT: ${state.consigners.elementAt(index).nit ?? "-"}"),
                        ],
                      )),
                      IconButton(
                          onPressed: () {
                            context.read<ConsignerBloc>().add(DeleteConsigner(
                                state.consigners.elementAt(index).id));
                          },
                          icon: const Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, NewConsigner.route,
                                arguments:
                                    state.consigners.elementAt(index).toMap());
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                )),
            onChangedFilter: (value) =>
                context.read<ConsignerBloc>().add(Filter(value)),
            isLoading: state is Loadingconsigners));
  }
}
