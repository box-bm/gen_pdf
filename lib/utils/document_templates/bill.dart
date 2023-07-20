import 'package:flutter/services.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/utils/calculations.dart';
import 'package:gen_pdf/utils/formatter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

int rowsPerPage = 20;

Future<Document> generateBillPDF(Bill bill) async {
  final pdf = Document();

  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );

  var contentBorder = Border.all();
  var boldText = TextStyle(fontWeight: FontWeight.bold, font: Font.timesBold());

  double difference = (bill.items.length / rowsPerPage);
  int pages = difference.ceil();

  double secure = getSecure(bill.total);

  for (var i = 0; i < pages; i++) {
    var isFinal = difference - i < 1;

    var items = bill.items.sublist(i * rowsPerPage,
        isFinal ? bill.items.length : (i * rowsPerPage) + rowsPerPage);

    pdf.addPage(Page(
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
                                        child: Text(
                                            "Exportador: ${bill.exporterName}"))),
                                Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: contentBorder),
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                            "Consignatario: ${bill.consignerName}"))),
                              ])),
                          Container(
                              decoration: BoxDecoration(border: contentBorder),
                              child: Row(children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text("Direccion",
                                                  style: boldText),
                                              Text(bill.exporterAddress)
                                            ]))),
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
                                                  child: Text(
                                                      "Direccion: ${bill.consignerAddress}")),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      border: contentBorder),
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Text(
                                                      "Nit: ${(bill.consignerNIT ?? "").isEmpty ? "-" : bill.consignerNIT}"))
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
                                        child: Text(
                                            "No. Contenedor: ${bill.containerNumber}"))),
                                Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: contentBorder),
                                        padding: const EdgeInsets.all(4),
                                        child: Text("No. B/L: ${bill.bl}"))),
                              ])),
                          Container(
                              decoration: BoxDecoration(border: contentBorder),
                              child: Row(children: [
                                Expanded(
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(minHeight: 70),
                                        padding: const EdgeInsets.all(4),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text("No. Total de piezas"),
                                              Center(
                                                  child: Text(
                                                      bill.items
                                                          .map(
                                                              (e) => e.quantity)
                                                          .reduce((value,
                                                                  element) =>
                                                              value + element)
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .header2))
                                            ]))),
                                Expanded(
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(minHeight: 70),
                                        decoration: const BoxDecoration(
                                            border: Border.symmetric(
                                                vertical: BorderSide())),
                                        padding: const EdgeInsets.all(4),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text("Terminos y condiciones"),
                                              SizedBox(height: 10),
                                              Text(
                                                  (bill.termsAndConditions ??
                                                          "-")
                                                      .toUpperCase(),
                                                  style: Theme.of(context)
                                                      .defaultTextStyle
                                                      .copyWith(fontSize: 10)),
                                            ]))),
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
                                      child: Text('Numeracion',
                                          textAlign: TextAlign.center)),
                                  Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Text('Descripcion',
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
                                    .map(
                                      (e) => TableRow(children: [
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
                                        Container(
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                                moneyFormat.format(e.unitPrice),
                                                textAlign: TextAlign.right)),
                                        Container(
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                                moneyFormat.format(e.total),
                                                textAlign: TextAlign.right)),
                                      ]),
                                    )
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
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            padding: const EdgeInsets.all(2),
                                            child: Text("Valor FOB",
                                                style: boldText)),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                                moneyFormat.format(bill.total),
                                                textAlign: TextAlign.right)),
                                      ]),
                                      TableRow(children: [
                                        SizedBox(),
                                        SizedBox(),
                                        SizedBox(),
                                        SizedBox(),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            padding: const EdgeInsets.all(2),
                                            child: Text("Flete")),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                                moneyFormat
                                                    .format(bill.freight),
                                                textAlign: TextAlign.right)),
                                      ]),
                                      TableRow(children: [
                                        SizedBox(),
                                        SizedBox(),
                                        SizedBox(),
                                        SizedBox(),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            padding: const EdgeInsets.all(2),
                                            child: Text("Seguro")),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                                "\$ ${moneyFormatWithoutSimbol.format(secure)}",
                                                textAlign: TextAlign.right)),
                                      ]),
                                      TableRow(children: [
                                        SizedBox(),
                                        SizedBox(),
                                        SizedBox(),
                                        SizedBox(),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            padding: const EdgeInsets.all(2),
                                            child:
                                                Text("Total", style: boldText)),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                                moneyFormat.format(bill.total +
                                                    secure +
                                                    bill.freight),
                                                textAlign: TextAlign.right)),
                                      ]),
                                    ])
                              : Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                      "**Continua en la siguiente página**"
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
  }

  return pdf;
}
