import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/consigneer_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';
import 'package:gen_pdf/screens/new_exporter.dart';
import 'package:gen_pdf/widgets/empty_list.dart';

class ConsignerList extends StatelessWidget {
  final List<String> selecteds;
  final Function(String id, bool selected) onSelect;
  const ConsignerList(
      {super.key, required this.onSelect, required this.selecteds});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsigneerBloc, ConsigneerState>(
        builder: (context, state) => state.consigners.isEmpty
            ? const EmptyList()
            : ListView.builder(
                itemCount: state.consigners.length,
                itemBuilder: (context, index) => ListTile.selectable(
                  selected:
                      selecteds.contains(state.consigners.elementAt(index).id),
                  onSelectionChange: (value) =>
                      onSelect(state.consigners.elementAt(index).id, value),
                  selectionMode: ListTileSelectionMode.multiple,
                  trailing: Row(children: [
                    IconButton(
                      icon: const Icon(FluentIcons.delete),
                      onPressed: selecteds.isNotEmpty
                          ? null
                          : () {
                              context.read<ConsigneerBloc>().add(
                                  DeleteConsigner(
                                      state.consigners.elementAt(index).id));
                            },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(FluentIcons.edit),
                      onPressed: selecteds.isNotEmpty
                          ? null
                          : () {
                              context.read<FormCubit>().setValues(
                                  state.consigners.elementAt(index).toMap());
                              Navigator.pushNamed(context, NewExporter.route,
                                  arguments: true);
                            },
                    )
                  ]),
                  title: Text(state.consigners[index].name),
                  subtitle: Text(state.consigners.elementAt(index).address),
                ),
              ));
  }
}
