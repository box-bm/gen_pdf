import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';
import 'package:gen_pdf/screens/new_exporter.dart';
import 'package:gen_pdf/widgets/empty_list.dart';

class ConsignerList extends StatefulWidget {
  final List<String> selecteds;
  final Function(String id, bool selected) onSelect;
  const ConsignerList(
      {super.key, required this.onSelect, required this.selecteds});

  @override
  State<StatefulWidget> createState() => _ConsignerListState();
}

class _ConsignerListState extends State<ConsignerList> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text =
        context.read<ConsignerBloc>().state.searchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: TextBox(
              controller: textEditingController,
              suffix: const SizedBox(
                width: 30,
                child: Icon(FluentIcons.search),
              ),
              onChanged: (value) =>
                  context.read<ConsignerBloc>().add(Filter(value)),
              suffixMode: OverlayVisibilityMode.always,
              placeholder: "Buscar",
            )),
        BlocBuilder<ConsignerBloc, ConsignerState>(builder: (context, state) {
          if (state is Loadingconsigners) {
            return const ProgressRing();
          }

          if (state.consigners.isEmpty) {
            return const EmptyList();
          }
          return Expanded(
              child: ListView.builder(
            itemCount: state.consigners.length,
            itemBuilder: (context, index) => ListTile.selectable(
              selected: widget.selecteds
                  .contains(state.consigners.elementAt(index).id),
              onSelectionChange: (value) =>
                  widget.onSelect(state.consigners.elementAt(index).id, value),
              selectionMode: ListTileSelectionMode.multiple,
              trailing: Row(children: [
                IconButton(
                    icon: const Icon(FluentIcons.delete),
                    onPressed: widget.selecteds.isNotEmpty
                        ? null
                        : () {
                            context.read<ConsignerBloc>().add(DeleteConsigner(
                                state.consigners.elementAt(index).id));
                          }),
                const SizedBox(width: 10),
                IconButton(
                    icon: const Icon(FluentIcons.edit),
                    onPressed: widget.selecteds.isNotEmpty
                        ? null
                        : () {
                            context.read<FormCubit>().setValues(
                                state.consigners.elementAt(index).toMap());
                            Navigator.pushNamed(context, NewExporter.route,
                                arguments: true);
                          })
              ]),
              title: Text(state.consigners.elementAt(index).name),
              subtitle: Text(state.consigners.elementAt(index).address),
            ),
          ));
        }),
      ],
    );
  }
}
