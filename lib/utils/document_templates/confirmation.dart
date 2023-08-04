import 'package:flutter/services.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Page> getConfirmationTemplate(Bill bill) async {
  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );

  var contentBorder = Border.all();
  var boldText = TextStyle(fontWeight: FontWeight.bold);

  var page = Page(
      pageFormat: PdfPageFormat.letter,
      margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
      theme: ThemeData(defaultTextStyle: const TextStyle(fontSize: 10)),
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
                              Text("Confirmación de venta".toUpperCase(),
                                  textAlign: TextAlign.right,
                                  style: boldText.copyWith(fontSize: 14)),
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
                                        child: Text("Fecha".toUpperCase(),
                                            textAlign: TextAlign.left)),
                                    SizedBox(
                                        width: 80,
                                        child: Text(
                                            DateFormat.yMMMd().format(bill.date!
                                                .add(
                                                    const Duration(days: -15))),
                                            textAlign: TextAlign.center))
                                  ]),
                              SizedBox(height: 20),
                              Text("Estimado/a ${bill.buyer}"),
                              SizedBox(height: 18),
                              Text(
                                  "Nos complace confirmar la venta de mercadería internacional a su empresa, ${bill.consignerName}. A continuación, se detallan los términos y condiciones de la transacción:",
                                  textAlign: TextAlign.left),
                              SizedBox(height: 18),
                              Text("Detalles de la Venta:"),
                              Text("Número de Referencia: ${bill.billNumber}"),
                              SizedBox(height: 18),
                              Text(
                                  "Descripción de los Productos: Como se describen en la contización."),
                              SizedBox(height: 18),
                              Text("Condiciones de Pago:"),
                              Text("Método de Pago: Credito"),
                              Text(
                                  "Plazo de Pago: 90 Días a partir de la fecha de la emision de la factura"),
                              SizedBox(height: 18),
                              Text(
                                  "Seguro: Cobertura todo riesgo sobre el 110% del valor de la mercadería, que será cubierto por nosotros Makan Global Shipping hasta el puerto de destino."),
                              SizedBox(height: 18),
                              Text("Condiciones de Entrega"),
                              Text("Incoterm: CIF"),
                              Text("Envío: China"),
                              Text("Destino: Puerto Quetzal Guatemala"),
                              SizedBox(height: 18),
                              Text(
                                  "Es importante destacar que esta confirmación de venta está sujeta a la firma de un contrato formal entre ambas partes, que incluirá los términos y condiciones específicos de la transacción."),
                              SizedBox(height: 18),
                              Text(
                                  "Agradecemos su confianza y quedamos a su disposición para cualquier consulta o requerimiento adicional. Por favor, no dude en ponerse en contacto con nosotros a través de los datos proporcionados anteriormente"),
                              SizedBox(height: 18),
                              Text("Atentamente,"),
                              SizedBox(height: 50),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: 200,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Divider(),
                                              Text(bill.seller ?? ""),
                                              Text(bill.sellerPosition ?? ""),
                                            ])),
                                    Container(
                                        width: 200,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Divider(),
                                              Text(bill.buyer ?? ""),
                                              Text(bill.buyerPosition ?? ""),
                                            ])),
                                  ]),
                            ])))
              ])),
          Watermark(
              fit: BoxFit.scaleDown,
              child: Opacity(
                  opacity: 0.1, child: Image(logo, height: 200, width: 200))),
        ]);
      });

  return page;
}
