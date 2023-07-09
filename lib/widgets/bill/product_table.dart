import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart' as form_cubit;
import 'package:gen_pdf/models/bill_item.dart';
import 'package:gen_pdf/widgets/bill/new_item_form.dart';

class ProductTable extends StatefulWidget {
  final List<BillItem> initialItems;
  const ProductTable({super.key, this.initialItems = const []});

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  List<BillItem> items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      items = widget.initialItems;
    });
  }

  void removeElement(String id) {
    var items = this.items.where((element) => element.id != id).toList();

    setState(() {
      this.items = items;
    });

    context.read<form_cubit.FormCubit>().setValue(
        items.isEmpty ? [] : items.map((e) => e.toMap()).toList(), "items");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          BlocBuilder<form_cubit.FormCubit, form_cubit.FormState>(
              builder: (context, state) {
            var items = (state.values['items'] as List<dynamic>? ?? []);

            double total = items.isEmpty
                ? 0
                : items
                    .map((e) => e['total'])
                    .toList()
                    .reduce((value, element) => value + element);

            return Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Productos"),
                Text(
                  "Total: \$${total.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ));
          }),
          ElevatedButton.icon(
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (context) => NewItemForm(
                          onSubmit: (values) {
                            var newElement = BillItem.newByMap(values);
                            var newList = [...items, newElement];
                            setState(() {
                              items = newList;
                            });
                            context.read<form_cubit.FormCubit>().setValue(
                                newList.map((e) => e.toMap()).toList(),
                                "items");
                            Navigator.pop(context);
                          },
                        ));
              },
              icon: const Icon(Icons.add),
              label: const Text("Agregar"))
        ]),
        Table(
            columnWidths: const {
              0: FixedColumnWidth(100),
              6: FixedColumnWidth(50)
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: const TableBorder(
                horizontalInside:
                    BorderSide(color: Color.fromARGB(24, 253, 253, 253))),
            children: [
              TableRow(children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text("Numeracion"),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text("Descripcion"),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text("Cantidad"),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text("PRS"),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text("Precio unitario"),
                ),
                Container(
                    padding: const EdgeInsets.all(4),
                    child: const Text("Sub total")),
              ]),
              ...items
                  .map((e) => TableRow(children: [
                        Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(e.numeration)),
                        Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(e.description)),
                        Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(e.quantity.toString())),
                        Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(e.prs ?? "")),
                        Container(
                            padding: const EdgeInsets.all(4),
                            child: Text("\$${e.unitPrice.toStringAsFixed(2)}")),
                        Container(
                            padding: const EdgeInsets.all(4),
                            child: Text("\$${e.total.toStringAsFixed(2)}")),
                        Container(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      removeElement(e.id);
                                    })
                              ],
                            )),
                      ]))
                  .toList()
            ])
      ],
    );
  }
}
