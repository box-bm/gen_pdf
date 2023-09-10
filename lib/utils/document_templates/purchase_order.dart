import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/utils/calculations.dart';
import 'package:gen_pdf/utils/document_templates/generics/table.dart';
import 'package:gen_pdf/utils/formatter.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

int rowsPerPage = 20;

Future<List<Page>> getPurchaseOrderTemplate(Bill bill) async {
  List<Page> pages = [];

  double difference = (bill.items.length / rowsPerPage);
  int pagesnumbers = difference.ceil();

  for (var i = 0; i < pagesnumbers; i++) {
    var isFinal = difference - i < 1;

    var items = bill.items.sublist(i * rowsPerPage,
        isFinal ? bill.items.length : (i * rowsPerPage) + rowsPerPage);

    var page = (Page(
        pageFormat: PdfPageFormat.letter,
        theme: ThemeData(
            defaultTextStyle: TextStyle(
                fontItalic: Font.helvetica(),
                font: Font.helvetica(),
                fontSize: 10)),
        build: (Context context) {
          return Stack(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Text(bill.consignerName,
                      style: const TextStyle(fontSize: 50),
                      textAlign: TextAlign.center),
                  Text(bill.consignerAddress, textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  Text(
                      DateFormat.yMMMd().format(
                          Jiffy.parseFromDateTime(bill.date!)
                              .add(months: -1, days: 2)
                              .dateTime),
                      textAlign: TextAlign.right),
                  SizedBox(height: 20),
                  Text(
                      "Orden de compra A-${bill.date?.year.toString().substring(2, 4)}${bill.number.suffixNumber()}"
                          .toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  Text("Señores: Makan Global Shipping.",
                      textAlign: TextAlign.left),
                  Text(
                      "Es un placer para nosotros informales que procedemos con la presente ORDEN DE COMPRA de los productos especificados en su cotización No. ${bill.billNumber} de fecha ${DateFormat.yMMMd().format(Jiffy.parseFromDateTime(bill.date!).add(months: -1).dateTime)}. A continuación, detallo los productos y las cantidades que deseamos adquirir:",
                      textAlign: TextAlign.left),
                  Spacer(),
                  pricingTable(
                      items: items,
                      freight: bill.freight,
                      total: bill.total,
                      isFinal: isFinal,
                      fillTable: false),
                  Spacer(),
                  Text(
                      "El monto total de la orden de compra, incluyendo envío y seguro (CIF), asciende a \$${(bill.total + getSecure(bill.total) + bill.freight).toStringAsFixed(2)}",
                      textAlign: TextAlign.left),
                  Spacer(flex: 2),
                  Text("Atentamente,", textAlign: TextAlign.left),
                  Spacer(),
                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        SizedBox(width: 200, child: Divider()),
                        Text(bill.buyer ?? "")
                      ])),
                  SizedBox(height: 30)
                ])),
          ]);
        }));
    pages.add(page);
  }

  return pages;
}
