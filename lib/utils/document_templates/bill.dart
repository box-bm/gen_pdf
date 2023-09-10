import 'package:flutter/services.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/utils/calculations.dart';
import 'package:gen_pdf/utils/document_templates/money_cell.dart';
import 'package:gen_pdf/utils/formatter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

int rowsPerPage = 20;

Future<List<Page>> getBillTemplate(Bill bill) async {
  List<Page> pages = [];

  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );

  var contentBorder = Border.all();
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

  double difference = (bill.items.length / rowsPerPage);
  int numberOfPages = difference.ceil();

  double secure = getSecure(bill.total);

  for (var i = 0; i < numberOfPages; i++) {
    var isFinal = difference - i < 1;

    var items = bill.items.sublist(i * rowsPerPage,
        isFinal ? bill.items.length : (i * rowsPerPage) + rowsPerPage);

    var page = (Page(
        pageFormat: PdfPageFormat.letter,
        theme: ThemeData(
            defaultTextStyle: TextStyle(
                fontItalic: Font.timesItalic(),
                font: Font.times(),
                fontSize: 10)),
        build: (Context context) {
          return Stack(children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(border: contentBorder),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(children: [
                            Container(
                                decoration:
                                    BoxDecoration(border: contentBorder),
                                height: 90,
                                width: 90,
                                child: Center(
                                    child: Image(logo, width: 80, height: 80))),
                            Expanded(
                                child: Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    padding: const EdgeInsets.all(4),
                                    height: 90,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              "MAKAN GLOBAL SHIPPING"
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  font: Font.timesBold(),
                                                  fontSize: 20)),
                                          Text(
                                              "Calle Elvira Méndez, edificio Interseco, Piso B.Panamá, Panamá.")
                                        ])))
                          ]),
                          Row(children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                    decoration:
                                        BoxDecoration(border: contentBorder),
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text("Fecha", style: boldText),
                                          Text(dateFormat.format(
                                              bill.date ?? DateTime.now()))
                                        ]))),
                            Expanded(
                                child: Container(
                                    decoration:
                                        BoxDecoration(border: contentBorder),
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text("No", style: boldText),
                                          Text(bill.billNumber)
                                        ])))
                          ]),
                          Container(
                              decoration: BoxDecoration(border: contentBorder),
                              child: Row(children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        padding: const EdgeInsets.all(4),
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: "Exportador: ",
                                              style: boldText),
                                          TextSpan(text: bill.exporterName)
                                        ])))),
                                Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: contentBorder),
                                        padding: const EdgeInsets.all(4),
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: "Consignatario: ",
                                              style: boldText),
                                          TextSpan(text: bill.consignerName),
                                        ])))),
                              ])),
                          Container(
                              decoration: BoxDecoration(border: contentBorder),
                              child: Row(children: [
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(2),
                                              child: Text("Dirección",
                                                  style: boldText)),
                                          Container(
                                              padding: const EdgeInsets.all(2),
                                              child: Text(bill.exporterAddress))
                                        ])),
                                Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: contentBorder),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: RichText(
                                                      text: TextSpan(children: [
                                                    TextSpan(
                                                        text: "Dirección: ",
                                                        style: boldText),
                                                    TextSpan(
                                                        text: bill
                                                            .consignerAddress)
                                                  ]))),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      border: contentBorder),
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Row(children: [
                                                    Text("Nit:",
                                                        style: boldText),
                                                    Text((bill.consignerNIT ??
                                                        "-"))
                                                  ]))
                                            ]))),
                              ])),
                          Container(
                              decoration: BoxDecoration(border: contentBorder),
                              child: Row(children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: contentBorder),
                                        padding: const EdgeInsets.all(4),
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: "No. Contenedor:",
                                              style: boldText),
                                          TextSpan(text: bill.containerNumber)
                                        ])))),
                                Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: contentBorder),
                                        padding: const EdgeInsets.all(4),
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: "No. B/L: ",
                                              style: boldText),
                                          TextSpan(text: bill.bl)
                                        ]))))
                              ])),
                          Container(
                              decoration: BoxDecoration(border: contentBorder),
                              constraints: const BoxConstraints(minHeight: 34),
                              padding: const EdgeInsets.all(4),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Términos y condiciones * SALDOS DE FABRICA** CIF A PUERTO QUETZAL***90 DIAS CREDITO ",
                                        style: boldText),
                                  ])),
                          Table(
                              border: TableBorder.all(),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
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
                                  Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text('Numeración',
                                          textAlign: TextAlign.center)),
                                  Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text('Descripción',
                                          textAlign: TextAlign.center)),
                                  Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text('Cantidad',
                                          textAlign: TextAlign.center)),
                                  Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text('PRS',
                                          textAlign: TextAlign.center)),
                                  Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text('Precio Unitario',
                                          textAlign: TextAlign.center)),
                                  Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text('Monto total',
                                          textAlign: TextAlign.center)),
                                ]),
                                ...items
                                    .map((e) => TableRow(children: [
                                          Container(
                                              padding: const EdgeInsets.all(2),
                                              child: Text(e.numeration,
                                                  textAlign: TextAlign.center)),
                                          Container(
                                              padding: const EdgeInsets.all(2),
                                              child: Text(e.description,
                                                  textAlign: TextAlign.center)),
                                          Container(
                                              padding: const EdgeInsets.all(2),
                                              child: Text(
                                                  e.quantity.toStringAsFixed(0),
                                                  textAlign: TextAlign.center)),
                                          Container(
                                              padding: const EdgeInsets.all(2),
                                              child: Text(e.prs ?? "",
                                                  textAlign: TextAlign.center)),
                                          moneyCell(e.unitPrice),
                                          moneyCell(e.total),
                                        ]))
                                    .toList(),
                              ]),
                          isFinal
                              ? Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
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
                                            child: Text("Valor FOB",
                                                style: boldText)),
                                        Container(
                                            decoration: finalDataColumnsRight,
                                            child: moneyCell(bill.total))
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
                                            child: moneyCell(bill.freight))
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
                                            child: Text("Total CIF",
                                                style: boldText)),
                                        Container(
                                            decoration: finalDataColumnsRight,
                                            child: moneyCell(bill.total +
                                                secure +
                                                bill.freight))
                                      ]),
                                    ])
                              : Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                      "**Continúa en la siguiente página**"
                                          .toUpperCase(),
                                      style: boldText,
                                      textAlign: TextAlign.right))
                        ]))),
            Watermark(
                fit: BoxFit.scaleDown,
                child: Opacity(
                    opacity: 0.1, child: Image(logo, height: 200, width: 200))),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text((i + 1).toString())))
          ]);
        }));

    pages.add(page);
  }

  return pages;
}
