import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';
import 'package:gen_pdf/screens/new_exporter.dart';
import 'package:gen_pdf/widgets/empty_list.dart';

class ExporterList extends StatelessWidget {
  final List<String> selecteds;
  final Function(String id, bool selected) onSelect;
  const ExporterList(
      {super.key, required this.onSelect, required this.selecteds});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExporterBloc, ExporterState>(
        builder: (context, state) => state.exporters.isEmpty
            ? const EmptyList()
            : ListView.builder(
                itemCount: state.exporters.length,
                itemBuilder: (context, index) => ListTile.selectable(
                  selected:
                      selecteds.contains(state.exporters.elementAt(index).id),
                  onSelectionChange: (value) =>
                      onSelect(state.exporters.elementAt(index).id, value),
                  selectionMode: ListTileSelectionMode.multiple,
                  trailing: Row(children: [
                    IconButton(
                      icon: const Icon(FluentIcons.delete),
                      onPressed: selecteds.isNotEmpty
                          ? null
                          : () {
                              context.read<ExporterBloc>().add(DeleteExporter(
                                  state.exporters.elementAt(index).id));
                            },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(FluentIcons.edit),
                      onPressed: selecteds.isNotEmpty
                          ? null
                          : () {
                              context.read<FormCubit>().setValues(
                                  state.exporters.elementAt(index).toMap());
                              Navigator.pushNamed(context, NewExporter.route,
                                  arguments: true);
                            },
                    )
                  ]),
                  title: Text(state.exporters[index].name),
                  subtitle: Text(state.exporters.elementAt(index).address),
                ),
              ));
  }
}
