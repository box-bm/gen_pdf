import 'package:flutter/services.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/utils/calculations.dart';
import 'package:gen_pdf/utils/formatter.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Page> getExplanatoryNoteTemplate(Bill bill) async {
  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );

  var page = Page(
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
                                  "NOTA EXPLICATIVA DE LA NEGOCIACIÓN"
                                      .toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontBold: Font.timesBold(),
                                      font: Font.times(),
                                      fontSize: 14)),
                              SizedBox(height: 40),
                              Text(
                                  "Delaware, ${DateFormat.yMMMMd().format(bill.date!)}"),
                              SizedBox(height: 40),
                              Text("Estimados señores:"),
                              SizedBox(height: 20),
                              Text(
                                  "Certificados URRACA INTERNATIONAL SHIPPING, LLC.: Los productos detallados en la FACTURA N° ${bill.billNumber} de fecha: ${DateFormat.yMMMMd().format(bill.date!)}, consignados a favor de ${bill.consignerName} por valor de USD ${moneyFormat.format(bill.total + getSecure(bill.total) + bill.freight)} Se emite bajo el INCOTERM CIF que incluye el costo producto, flete marítimo y seguro, por lo que se detallan las características de la negociación: A) La FACTURA N° ${bill.billNumber} tiene un crédito pagadero a 90 días B) La entrega en el punto de destino será en PUERTO QUETZAL, ubicado en el departamento de ESCUINTLA en el país de GUATEMALA C) URRACA INTERNATIONAL SHIPPING, LLC Designa y paga el transporte:"),
                              SizedBox(height: 40),
                              Text(
                                  "Gracias por su consideración, saludos cordiales."),
                              Spacer(),
                            ])))
              ])),
          Watermark(
              fit: BoxFit.scaleDown,
              child: Opacity(
                  opacity: 0.1, child: Image(logo, width: 350, height: 250))),
        ]);
      });

  return page;
}
