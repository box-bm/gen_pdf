import 'package:gen_pdf/models/bill_item.dart';
import 'package:gen_pdf/utils/calculations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:gen_pdf/utils/document_templates/money_cell.dart';

var finalDataColumnsLeft = const BoxDecoration(
    border: Border(
        bottom: BorderSide(),
        top: BorderSide(),
        right: BorderSide(),
        left: BorderSide(width: 3)));

var finalDataColumnsRight = const BoxDecoration(
    border: Border(
        bottom: BorderSide(),
        top: BorderSide(),
        right: BorderSide(width: 3),
        left: BorderSide()));
var boldText = TextStyle(fontWeight: FontWeight.bold, font: Font.timesBold());

Widget pricingTable({
  required List<BillItem> items,
  required List<BillItem> printingItems,
  required double freight,
  required double total,
  bool isFinal = false,
  bool fillTable = true,
  int rowsPerPage = 20,
}) {
  double secure = getSecure(total);

  return Column(children: [
    Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: const FixedColumnWidth(60),
          1: const FlexColumnWidth(3),
          2: const FlexColumnWidth(1),
          3: const FixedColumnWidth(55),
          4: const FlexColumnWidth(2),
          5: const FlexColumnWidth(2),
        },
        children: [
          TableRow(children: [
            Container(
                color: PdfColors.black,
                padding: const EdgeInsets.all(2),
                child: Text('Numeración',
                    style: const TextStyle(color: PdfColors.white),
                    textAlign: TextAlign.center)),
            Container(
                color: PdfColors.black,
                padding: const EdgeInsets.all(2),
                child: Text('Descripciónes',
                    style: const TextStyle(color: PdfColors.white),
                    textAlign: TextAlign.center)),
            Container(
                color: PdfColors.black,
                padding: const EdgeInsets.all(2),
                child: Text('Cantidad',
                    style: const TextStyle(color: PdfColors.white),
                    textAlign: TextAlign.center)),
            Container(
                color: PdfColors.black,
                padding: const EdgeInsets.all(2),
                child: Text('PRS',
                    style: const TextStyle(color: PdfColors.white),
                    textAlign: TextAlign.center)),
            Container(
                color: PdfColors.black,
                padding: const EdgeInsets.all(2),
                child: Text('Precio Unitario',
                    style: const TextStyle(color: PdfColors.white),
                    textAlign: TextAlign.center)),
            Container(
                color: PdfColors.black,
                padding: const EdgeInsets.all(2),
                child: Text('Total',
                    style: const TextStyle(color: PdfColors.white),
                    textAlign: TextAlign.center)),
          ]),
          ...printingItems
              .map(
                (e) => TableRow(children: [
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                          (items.indexWhere((element) => element.id == e.id) +
                                  1)
                              .toString(),
                          textAlign: TextAlign.center)),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(e.description, textAlign: TextAlign.center)),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(e.quantity.toStringAsFixed(0),
                          textAlign: TextAlign.center)),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(e.prs ?? "", textAlign: TextAlign.center)),
                  moneyCell(e.unitPrice),
                  moneyCell(e.total)
                ]),
              )
              .toList(),
          ...(fillTable && printingItems.length < rowsPerPage
              ? List.filled(rowsPerPage - printingItems.length, null)
                  .map((e) => TableRow(children: [
                        SizedBox(height: 14),
                        SizedBox(height: 14),
                        SizedBox(height: 14),
                        SizedBox(height: 14),
                        SizedBox(height: 14),
                        SizedBox(height: 14)
                      ]))
                  .toList()
              : [])
        ]),
    isFinal
        ? Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
                0: const FixedColumnWidth(55),
                1: const FlexColumnWidth(3),
                2: const FlexColumnWidth(1),
                3: const FixedColumnWidth(55),
                4: const FlexColumnWidth(2),
                5: const FlexColumnWidth(2),
              },
            children: [
                TableRow(children: [
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  Container(
                      decoration: finalDataColumnsLeft,
                      padding: const EdgeInsets.all(2),
                      child: Text("Valor FOB", style: boldText)),
                  Container(
                      decoration: finalDataColumnsRight,
                      child: moneyCell(total))
                ]),
                TableRow(children: [
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  Container(
                      decoration: finalDataColumnsLeft,
                      padding: const EdgeInsets.all(2),
                      child: Text("Flete")),
                  Container(
                      decoration: finalDataColumnsRight,
                      child: moneyCell(freight))
                ]),
                TableRow(children: [
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  Container(
                      decoration: finalDataColumnsLeft,
                      padding: const EdgeInsets.all(2),
                      child: Text("Seguro")),
                  Container(
                      decoration: finalDataColumnsRight,
                      child: moneyCell(secure))
                ]),
                TableRow(children: [
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  Container(
                      decoration: finalDataColumnsLeft,
                      padding: const EdgeInsets.all(2),
                      child: Text("Total CIF", style: boldText)),
                  Container(
                      decoration: finalDataColumnsRight,
                      child: moneyCell(total + secure + freight))
                ]),
              ])
        : Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text("**Continúa en la siguiente página**".toUpperCase(),
                style: boldText, textAlign: TextAlign.right))
  ]);
}
