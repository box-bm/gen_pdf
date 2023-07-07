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
      children: [
        PageHeader(
            padding: 0,
            title: BlocBuilder<form_cubit.FormCubit, form_cubit.FormState>(
                builder: (context, state) {
              var items = (state.values['items'] as List<dynamic>? ?? []);

              double total = items.isEmpty
                  ? 0
                  : items
                      .map((e) => e['total'])
                      .toList()
                      .reduce((value, element) => value + element);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Productos"),
                  Text(
                    "Total: \$${total.toStringAsFixed(2)}",
                    style: FluentTheme.of(context).typography.bodyLarge,
                  )
                ],
              );
            }),
            commandBar: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                primaryItems: [
                  CommandBarButton(
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
                                    context
                                        .read<form_cubit.FormCubit>()
                                        .setValue(
                                            newList
                                                .map((e) => e.toMap())
                                                .toList(),
                                            "items");
                                    Navigator.pop(context);
                                  },
                                ));
                      },
                      icon: const Icon(FluentIcons.add),
                      label: const Text("Agregar"))
                ])),
        Card(
            child: Table(
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
                      child: Text("Numeracion",
                          style: FluentTheme.of(context).typography.bodyStrong),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Text("Descripcion",
                          style: FluentTheme.of(context).typography.bodyStrong),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Text("Cantidad",
                          style: FluentTheme.of(context).typography.bodyStrong),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Text("PRS",
                          style: FluentTheme.of(context).typography.bodyStrong),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Text("Precio unitario",
                          style: FluentTheme.of(context).typography.bodyStrong),
                    ),
                    Container(
                        padding: const EdgeInsets.all(4),
                        child: Text("Sub total",
                            style:
                                FluentTheme.of(context).typography.bodyStrong)),
                    Container(
                        padding: const EdgeInsets.all(4),
                        child: Text("",
                            style:
                                FluentTheme.of(context).typography.bodyStrong)),
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
                                child: Text(e.prs)),
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                    "\$${e.unitPrice.toStringAsFixed(2)}")),
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: Text("\$${e.total.toStringAsFixed(2)}")),
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: const Icon(FluentIcons.delete),
                                        onPressed: () {
                                          removeElement(e.id);
                                        })
                                  ],
                                )),
                          ]))
                      .toList()
                ]))
      ],
    );
  }
}
