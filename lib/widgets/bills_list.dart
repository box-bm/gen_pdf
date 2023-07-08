import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/empty_list.dart';

class BillsList extends StatefulWidget {
  final List<String> selecteds;
  final Function(String id, bool selected) onSelect;
  const BillsList({super.key, required this.onSelect, required this.selecteds});

  @override
  State<StatefulWidget> createState() => _BillsListState();
}

class _BillsListState extends State<BillsList> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = context.read<BillsBloc>().state.searchValue;
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
                  context.read<BillsBloc>().add(Filter(value)),
              suffixMode: OverlayVisibilityMode.always,
              placeholder: "Buscar",
            )),
        BlocBuilder<BillsBloc, BillsState>(builder: (context, state) {
          if (state is LoadingBills) {
            return const ProgressRing();
          }
          if (state.bills.isEmpty) {
            return const EmptyList();
          }

          return Expanded(
              child: ListView.builder(
                  itemCount: state.bills.length,
                  itemBuilder: (context, index) => ListTile.selectable(
                        selected: widget.selecteds
                            .contains(state.bills.elementAt(index).id),
                        onSelectionChange: (value) => widget.onSelect(
                            state.bills.elementAt(index).id, value),
                        selectionMode: ListTileSelectionMode.multiple,
                        trailing: Row(children: [
                          IconButton(
                              icon: const Icon(FluentIcons.delete),
                              onPressed: widget.selecteds.isNotEmpty
                                  ? null
                                  : () {
                                      context.read<BillsBloc>().add(DeleteBill(
                                          state.bills.elementAt(index).id));
                                    }),
                          const SizedBox(width: 10),
                          IconButton(
                              icon: const Icon(FluentIcons.preview),
                              onPressed: widget.selecteds.isNotEmpty
                                  ? null
                                  : () {
                                      context.read<BillsBloc>().add(PreviewPDF(
                                          state.bills.elementAt(index).id));
                                    }),
                        ]),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                                "Fact. ${state.bills.elementAt(index).billNumber}"),
                            Text(
                              "Cliente: ${state.bills.elementAt(index).consignerName}",
                              style: FluentTheme.of(context).typography.body,
                            ),
                            Text(
                              state.bills.elementAt(index).bl,
                              style: FluentTheme.of(context).typography.body,
                            )
                          ],
                        ),
                      )));
        })
      ],
    );
  }
}
