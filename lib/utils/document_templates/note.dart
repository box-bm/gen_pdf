import 'package:flutter/services.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/utils/formatter.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Document> generateNotePDF(Bill bill) async {
  final pdf = Document();

  var signature = MemoryImage(
    (await rootBundle.load('assets/img/signature.png')).buffer.asUint8List(),
  );
  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );

  pdf.addPage(Page(
      pageFormat: PdfPageFormat.letter,
      margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
      theme: ThemeData(
          defaultTextStyle:
              TextStyle(font: Font.helvetica(), lineSpacing: 6, fontSize: 10)),
      build: (Context context) {
        return Stack(children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                Container(height: 100, child: Image(logo)),
                SizedBox(height: 90),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  "NOTA ACLARATORIA DE COMPLEMENTO AL FLETE MARÍTIMO"
                                      .toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontBold: Font.timesBold(),
                                      font: Font.times(),
                                      fontSize: 14)),
                              SizedBox(height: 28),
                              Text(
                                  "Guatemala, ${DateFormat.yMMMMd().format(bill.date!)}"),
                              SizedBox(height: 18),
                              Text("Queridos señores:"),
                              SizedBox(height: 18),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                      letterBody(
                                          bill.billNumber,
                                          bill.consignerName,
                                          bill.total,
                                          bill.total,
                                          bill.date!),
                                      textAlign: TextAlign.justify)),
                              SizedBox(height: 18),
                              Text(
                                  "Gracias por su consideración, saludos cordiales."),
                              Spacer(),
                              Container(
                                  height: 90,
                                  child: Center(child: Image(signature))),
                              Text("Rogelio A. Mansilla",
                                  textAlign: TextAlign.center),
                              Text("CEO & Manager",
                                  textAlign: TextAlign.center),
                              Spacer(),
                              Text("1013 center RD. Suite 403-A",
                                  textAlign: TextAlign.center),
                              Text("Wilmington, DE 19805",
                                  textAlign: TextAlign.center),
                              Text("Ph.: (617) 901-0751",
                                  textAlign: TextAlign.center),
                            ])))
              ])),
          Watermark(
              fit: BoxFit.scaleDown,
              child: Opacity(
                  opacity: 0.1, child: Image(logo, width: 350, height: 250))),
        ]);
      }));

  return pdf;
}

String letterBody(String billNumber, String customerName, double total,
        double marineFreigth, DateTime billDateTime) =>
    "Por la presente URRACA INTERNATIONAL SHIPPING, LLC. Certifica: Los productos detallados en la FACTURA No.$billNumber de fecha: ${DateFormat.yMMMMd().format(billDateTime)} consignados a nombre de ${customerName.toUpperCase()}. por un valor de USD ${moneyFormat.format(total)} Se emite bajo el INCOTERM CIF que incluye el costo del producto, flete marítimo y seguro. El mismo que tuvo una VARIACIÓN en el precio del FLETE MARÍTIMO, situación que se presenta por las variaciones que tienen las navieras en sus precios de última hora, lo cual hacemos constar en este documento y en la FACTURA comercial No.$billNumber emitida como COMPLEMENTO A FLETE MARÍTIMO, por un valor de USD ${moneyFormat.format(marineFreigth)} haciendo un total CIF USD ${moneyFormat.format(marineFreigth)}.";
