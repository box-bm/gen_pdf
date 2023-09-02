import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/screens/home/bills.dart';
import 'package:gen_pdf/screens/new_bill.dart';
import 'package:gen_pdf/utils/calculations.dart';
import 'package:gen_pdf/utils/formatter.dart';

class BillCard extends StatelessWidget {
  final dynamic Function(String) select;
  final List<String> selecteds;
  final Bill bill;

  const BillCard(
      {super.key,
      required this.select,
      required this.selecteds,
      required this.bill});

  @override
  Widget build(BuildContext context) {
    return Card(
        borderOnForeground: false,
        elevation: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Checkbox(
                  value: selecteds.contains(bill.id),
                  onChanged: (value) {
                    select(bill.id);
                  }),
              const SizedBox(width: 8),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("#${bill.billNumber}"),
                  Text(
                    bill.consignerName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(height: 0),
                  ),
                  Text(
                    "Sub Total: ${moneyFormat.format(bill.total)}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(height: 0),
                  ),
                  Text(
                    "Flete: ${moneyFormat.format(bill.freight)}, Seguro: ${moneyFormat.format(getSecure(bill.total))}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(height: 0),
                  ),
                  Text(
                    "Total: ${moneyFormat.format(getSecure(bill.total) + bill.total + bill.freight)}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(height: 0),
                  ),
                  Text(
                    "BL: ${bill.bl}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(height: 0),
                  ),
                  Text(
                    "Contenedor: ${bill.containerNumber}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(height: 0),
                  ),
                  Text(
                    "Fecha: ${dateFormat.format(bill.date!)}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )),
              IconButton(
                  onPressed: () {
                    context.read<BillsBloc>().add(DeleteBill(bill.id));
                  },
                  icon: const Icon(Icons.delete)),
              PopupMenuButton(
                  color: Theme.of(context).iconButtonTheme.style?.iconColor
                      as Color?,
                  icon: const Icon(Icons.print),
                  itemBuilder: (context) => getBillOptions(context, bill.id)
                      .map((e) => e.menuItem)
                      .toList()),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, NewBill.route,
                        arguments: bill.toListAsMap());
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
        ));
  }
}

List<PrintOption> getBillOptions(BuildContext context, String id) => [
      PrintOption(Icons.remove_red_eye, "Vista previa", () {
        context.read<BillsBloc>().add(PreviewPDF(id));
      }),
      PrintOption(Icons.print, "Guardar todo", () {
        context.read<BillsBloc>().add(GenerateBillDocuments(id));
      }),
      PrintOption(Icons.request_page, "Generar Documento General", () {
        context.read<BillsBloc>().add(GenerateGeneralDocument(id));
      }),
      PrintOption(Icons.document_scanner, "Generar Factura", () {
        context.read<BillsBloc>().add(GenerateBill(id));
      }),
      PrintOption(Icons.attach_money, "Generar Cotizacion", () {
        context.read<BillsBloc>().add(GenerateQuotation(id));
      }),
      PrintOption(Icons.attach_money, "Generar Confirmacion de precios", () {
        context.read<BillsBloc>().add(GeneratePriceConfirmation(id));
      }),
      PrintOption(Icons.attach_money, "Generar Orden de compra", () {
        context.read<BillsBloc>().add(GeneratePurchaseOrder(id));
      }),
      PrintOption(Icons.note_alt_sharp, "Generar Contrato", () {
        context.read<BillsBloc>().add(GenerateAgreement(id));
      }),
      PrintOption(Icons.note, "Generar nota expl.", () {
        context.read<BillsBloc>().add(GenerateExplanatoryNote(id));
      }),
    ];
