import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/screens/new_exporter.dart';
import 'package:gen_pdf/widgets/base_home_screen.dart';

class Exporters extends StatelessWidget {
  const Exporters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExporterBloc, ExporterState>(
      listener: (context, state) {
        if (state is DeletingExporter) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Eliminando exportadores"),
            ),
          );
        } else if (state is DeletedExporter) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Exportador/es eliminados"),
            ),
          );
        }
      },
      builder: (context, state) => BaseHomeScreen(
          title: "Exportadores",
          actions: (ids) => [
                TextButton.icon(
                    onPressed: ids.isEmpty
                        ? null
                        : () {
                            context
                                .read<ExporterBloc>()
                                .add(DeleteExporters(ids));
                          },
                    icon: const Icon(Icons.delete),
                    label: const Text("Eliminar"))
              ],
          onInit: () =>
              context.read<ExporterBloc>().add(const GetAllExporters()),
          itemCount: state.exporters.length,
          itemBuilder: (index, selecteds, select) => Card(
              borderOnForeground: true,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    Checkbox(
                        value: selecteds
                            .contains(state.exporters.elementAt(index).id),
                        onChanged: (value) {
                          select(state.exporters.elementAt(index).id);
                        }),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          state.exporters.elementAt(index).name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(height: 0),
                        ),
                        Text(state.exporters.elementAt(index).address)
                      ],
                    )),
                    IconButton(
                        onPressed: () {
                          context.read<ExporterBloc>().add(DeleteExporter(
                              state.exporters.elementAt(index).id));
                        },
                        icon: const Icon(Icons.delete)),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, NewExporter.route,
                              arguments:
                                  state.exporters.elementAt(index).toMap());
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
              )),
          onChangedFilter: (searchValue) =>
              context.read<ExporterBloc>().add(Filter(searchValue)),
          isLoading: state is LoadingExporters),
    );
  }
}
