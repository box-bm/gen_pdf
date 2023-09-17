import 'package:flutter/services.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/utils/document_templates/generics/signatures.dart';
import 'package:gen_pdf/utils/document_templates/generics/table.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

int rowsPerPage = 20;

Future<List<Page>> getConfirmationTemplate(Bill bill) async {
  List<Page> pages = [];

  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );

  var contentBorder = Border.all();
  var boldText = TextStyle(fontWeight: FontWeight.bold, font: Font.timesBold());

  double difference = (bill.items.length / rowsPerPage);
  int pagesnumbers = difference.ceil();

  for (var i = 0; i < pagesnumbers; i++) {
    var isFinal = difference - i < 1;

    var items = bill.items.sublist(i * rowsPerPage,
        isFinal ? bill.items.length : (i * rowsPerPage) + rowsPerPage);

    var page = (Page(
        pageFormat: PdfPageFormat.letter,
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        theme: ThemeData(
            defaultTextStyle: TextStyle(
                fontItalic: Font.helvetica(),
                font: Font.helvetica(),
                fontSize: 8)),
        build: (Context context) {
          return Stack(children: [
            Align(
              alignment: const Alignment(-1, 1),
              child: Container(height: 80, child: Image(logo)),
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text("Confirmación de precios".toUpperCase(),
                                    textAlign: TextAlign.right,
                                    style: boldText.copyWith(fontSize: 20)),
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
                                SizedBox(height: 45),
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
                                SizedBox(
                                    width: 180,
                                    child:
                                        Text(bill.consignerName.toUpperCase())),
                                SizedBox(
                                    width: 180,
                                    child: Text(
                                        bill.consignerAddress.toUpperCase())),
                                SizedBox(height: 18),
                                pricingTable(
                                    printingItems: items,
                                    items: bill.items,
                                    freight: bill.freight,
                                    total: bill.total,
                                    isFinal: isFinal),
                                Spacer(),
                                isFinal ? signatures(bill) : SizedBox(),
                              ])))
                ])),
            Align(
                alignment: const Alignment(-1, -0.4),
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
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text("*factory outlet".toUpperCase(),
                                        style: Theme.of(context)
                                            .defaultTextStyle
                                            .copyWith(fontSize: 10)),
                                    Text(
                                        "**CIF to puerto quetzal".toUpperCase(),
                                        style: Theme.of(context)
                                            .defaultTextStyle
                                            .copyWith(fontSize: 10)),
                                    Text("***90 days of credit".toUpperCase(),
                                        style: Theme.of(context)
                                            .defaultTextStyle
                                            .copyWith(fontSize: 10)),
                                  ]))
                        ]))),
            Watermark(
                fit: BoxFit.scaleDown,
                child: Opacity(
                    opacity: 0.1, child: Image(logo, height: 200, width: 200))),
          ]);
        }));
    pages.add(page);
  }

  return pages;
}
