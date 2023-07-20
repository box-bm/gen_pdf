import 'package:flutter/services.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/utils/calculations.dart';
import 'package:gen_pdf/utils/document_templates/money_cell.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

int rowsPerPage = 20;

Future<Document> generateQuotationPDF(Bill bill) async {
  final pdf = Document();

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
  int pages = difference.ceil();

  double secure = getSecure(bill.total);

  for (var i = 0; i < pages; i++) {
    var isFinal = difference - i < 1;

    var items = bill.items.sublist(i * rowsPerPage,
        isFinal ? bill.items.length : (i * rowsPerPage) + rowsPerPage);

    pdf.addPage(Page(
        pageFormat: PdfPageFormat.letter,
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        theme: ThemeData(
            defaultTextStyle: TextStyle(
                fontItalic: Font.timesItalic(),
                font: Font.times(),
                fontSize: 10)),
        build: (Context context) {
          return Stack(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Container(height: 80, child: Image(logo)),
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text("Cotizacion".toUpperCase(),
                                    textAlign: TextAlign.right,
                                    style: boldText.copyWith(fontSize: 14)),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                          width: 70,
                                          child: Text("Fecha".toUpperCase(),
                                              textAlign: TextAlign.left)),
                                      SizedBox(
                                          width: 80,
                                          child: Text(
                                              DateFormat.yMMMd().format(
                                                  Jiffy.parseFromDateTime(
                                                          bill.date!)
                                                      .add(months: -1)
                                                      .dateTime),
                                              textAlign: TextAlign.center))
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                          width: 70,
                                          child: Text("No.".toUpperCase(),
                                              textAlign: TextAlign.left)),
                                      Container(
                                          width: 80,
                                          padding: const EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                              border: contentBorder),
                                          child: Text(bill.billNumber,
                                              textAlign: TextAlign.center))
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                          width: 70,
                                          child: Text("Página".toUpperCase(),
                                              textAlign: TextAlign.left)),
                                      Container(
                                          width: 80,
                                          padding: const EdgeInsets.all(1),
                                          child: Text("${i + 1}-$pages",
                                              textAlign: TextAlign.center))
                                    ]),
                                SizedBox(height: 20),
                                Row(children: [
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 2),
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                          color: PdfColors.black),
                                      child: Text("Comprador:".toUpperCase(),
                                          style: const TextStyle(
                                              color: PdfColors.white)))
                                ]),
                                Text(bill.consignerName.toUpperCase()),
                                SizedBox(
                                    width: 180,
                                    child: Text(
                                        bill.consignerAddress.toUpperCase())),
                                SizedBox(height: 18),
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
                                            color: PdfColors.black,
                                            padding: const EdgeInsets.all(2),
                                            child: Text('Numeracion',
                                                style: const TextStyle(
                                                    color: PdfColors.white),
                                                textAlign: TextAlign.center)),
                                        Container(
                                            color: PdfColors.black,
                                            padding: const EdgeInsets.all(2),
                                            child: Text('Descripciones',
                                                style: const TextStyle(
                                                    color: PdfColors.white),
                                                textAlign: TextAlign.center)),
                                        Container(
                                            color: PdfColors.black,
                                            padding: const EdgeInsets.all(2),
                                            child: Text('Cantidad',
                                                style: const TextStyle(
                                                    color: PdfColors.white),
                                                textAlign: TextAlign.center)),
                                        Container(
                                            color: PdfColors.black,
                                            padding: const EdgeInsets.all(2),
                                            child: Text('PRS',
                                                style: const TextStyle(
                                                    color: PdfColors.white),
                                                textAlign: TextAlign.center)),
                                        Container(
                                            color: PdfColors.black,
                                            padding: const EdgeInsets.all(2),
                                            child: Text('Precio Unitario',
                                                style: const TextStyle(
                                                    color: PdfColors.white),
                                                textAlign: TextAlign.center)),
                                        Container(
                                            color: PdfColors.black,
                                            padding: const EdgeInsets.all(2),
                                            child: Text('Total',
                                                style: const TextStyle(
                                                    color: PdfColors.white),
                                                textAlign: TextAlign.center)),
                                      ]),
                                      ...items
                                          .map(
                                            (e) => TableRow(children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Text(e.numeration,
                                                      textAlign:
                                                          TextAlign.center)),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Text(e.description,
                                                      textAlign:
                                                          TextAlign.center)),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Text(
                                                      e.quantity
                                                          .toStringAsFixed(0),
                                                      textAlign:
                                                          TextAlign.center)),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Text(e.prs ?? "",
                                                      textAlign:
                                                          TextAlign.center)),
                                              moneyCell(e.unitPrice),
                                              moneyCell(e.total)
                                            ]),
                                          )
                                          .toList(),
                                      ...(items.length < rowsPerPage
                                          ? List.filled(
                                                  rowsPerPage - items.length,
                                                  null)
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
                                                  decoration:
                                                      finalDataColumnsLeft,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Text("Valor FOB",
                                                      style: boldText)),
                                              Container(
                                                  decoration:
                                                      finalDataColumnsRight,
                                                  child: moneyCell(bill.total))
                                            ]),
                                            TableRow(children: [
                                              SizedBox(),
                                              SizedBox(),
                                              SizedBox(),
                                              SizedBox(),
                                              Container(
                                                  decoration:
                                                      finalDataColumnsLeft,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Text("Flete")),
                                              Container(
                                                  decoration:
                                                      finalDataColumnsRight,
                                                  child:
                                                      moneyCell(bill.freight))
                                            ]),
                                            TableRow(children: [
                                              SizedBox(),
                                              SizedBox(),
                                              SizedBox(),
                                              SizedBox(),
                                              Container(
                                                  decoration:
                                                      finalDataColumnsLeft,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Text("Seguro")),
                                              Container(
                                                  decoration:
                                                      finalDataColumnsRight,
                                                  child: moneyCell(secure))
                                            ]),
                                            TableRow(children: [
                                              SizedBox(),
                                              SizedBox(),
                                              SizedBox(),
                                              SizedBox(),
                                              Container(
                                                  decoration:
                                                      finalDataColumnsLeft,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Text("Total",
                                                      style: boldText)),
                                              Container(
                                                  decoration:
                                                      finalDataColumnsRight,
                                                  child: moneyCell(bill.total +
                                                      secure +
                                                      bill.freight))
                                            ]),
                                          ])
                                    : Container(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                            "**Continua en la siguiente página**"
                                                .toUpperCase(),
                                            style: boldText,
                                            textAlign: TextAlign.right))
                              ])))
                ])),
            Align(
                alignment: const Alignment(-1, -0.73),
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    constraints: const BoxConstraints(
                        maxWidth: 200, minHeight: 50, maxHeight: 60),
                    decoration: BoxDecoration(border: contentBorder),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              width: 200,
                              padding: const EdgeInsets.all(2),
                              decoration:
                                  const BoxDecoration(color: PdfColors.black),
                              child: Text("Terminos y condiciones",
                                  style:
                                      const TextStyle(color: PdfColors.white))),
                          Container(
                              padding: const EdgeInsets.all(2),
                              child: Text(bill.termsAndConditions ?? ""))
                        ]))),
            Watermark(
                fit: BoxFit.scaleDown,
                child: Opacity(
                    opacity: 0.1, child: Image(logo, height: 200, width: 200))),
          ]);
        }));
  }

  return pdf;
}
