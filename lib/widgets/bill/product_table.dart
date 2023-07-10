import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/models/bill_item.dart';
import 'package:gen_pdf/utils/formatter.dart';
import 'package:gen_pdf/widgets/bill/new_item_form.dart';

class ProductTable extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const ProductTable({super.key, required this.formKey});

  void removeElement(String id) {
    var field = formKey.currentState?.fields['items'];
    var items = field?.value.where((element) => element['id'] != id).toList();

    field?.didChange(items);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: 'items',
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
        builder: (field) {
          var items = field.value as List<dynamic>? ?? [];
          double total = items.isEmpty
              ? 0
              : items
                  .map((e) => e['total'])
                  .reduce((value, element) => value + element);

          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Productos"),
                      Text(
                        moneyFormat.format(total),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  )),
                  ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            enableDrag: true,
                            useSafeArea: true,
                            isDismissible: true,
                            isScrollControlled: true,
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                            constraints: const BoxConstraints(
                                minWidth: 200,
                                maxWidth: 600,
                                maxHeight: 1000,
                                minHeight: 300),
                            showDragHandle: true,
                            builder: (context) => SafeArea(
                                minimum:
                                    const EdgeInsets.fromLTRB(12, 10, 12, 20),
                                child: NewItemForm(
                                  onSubmit: (values) {
                                    var newElement = BillItem.newByMap(values);

                                    var items =
                                        field.value as List<dynamic>? ?? [];

                                    formKey.currentState?.fields['items']
                                        ?.didChange(
                                            [...items, newElement.toMap()]);
                                    Navigator.pop(context);
                                  },
                                )));
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Agregar"))
                ]),
                Card(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(100),
                        1: FlexColumnWidth(2),
                        2: FixedColumnWidth(80),
                        3: FixedColumnWidth(80),
                        4: FlexColumnWidth(1),
                        5: FlexColumnWidth(1),
                        6: FixedColumnWidth(50)
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: TableBorder(
                          verticalInside: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                          horizontalInside: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                      children: [
                        TableRow(children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Text("Numeracion",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Text("Descripcion",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Text("Cantidad",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Text("PRS",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            child: Text("Precio unitario",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                          Container(
                              padding: const EdgeInsets.all(6),
                              child: Text("Sub total",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                          const SizedBox(),
                        ]),
                        ...(items).map((e) {
                          BillItem item = BillItem().fromMap(e);
                          return TableRow(children: [
                            Container(
                                padding: const EdgeInsets.all(6),
                                child: Text(item.numeration,
                                    textAlign: TextAlign.center)),
                            Container(
                                padding: const EdgeInsets.all(6),
                                child: Text(item.description,
                                    textAlign: TextAlign.center)),
                            Container(
                                padding: const EdgeInsets.all(6),
                                child: Text(item.quantity.toString(),
                                    textAlign: TextAlign.center)),
                            Container(
                                padding: const EdgeInsets.all(6),
                                child: Text(item.prs ?? "",
                                    textAlign: TextAlign.center)),
                            Container(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  moneyFormat.format(item.unitPrice),
                                  textAlign: TextAlign.end,
                                )),
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  moneyFormat.format(item.total),
                                  textAlign: TextAlign.end,
                                )),
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          removeElement(item.id);
                                        })
                                  ],
                                )),
                          ]);
                        }).toList()
                      ]),
                ))
              ]);
        });
  }
}
