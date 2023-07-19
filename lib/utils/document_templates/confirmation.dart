import 'package:flutter/services.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/utils/formatter.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Document> generateConfirmationPDF(Bill bill) async {
  final pdf = Document();

  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );
  var signature = MemoryImage(
    (await rootBundle.load('assets/img/signature.png')).buffer.asUint8List(),
  );

  var contentBorder = Border.all();
  var boldText = TextStyle(fontWeight: FontWeight.bold);

  pdf.addPage(Page(
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
                              Text("Confirmación de compra".toUpperCase(),
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
                                            DateFormat.yMMMd().format(bill.date!
                                                .add(
                                                    const Duration(days: -15))),
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
                              SizedBox(
                                  width: 150,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text("Queridos señores:".toUpperCase(),
                                            textAlign: TextAlign.left),
                                        Text(
                                            "Confirmamos venderle los siguientes productos en términos y condiciones estipulados a continuación."
                                                .toUpperCase(),
                                            textAlign: TextAlign.left)
                                      ])),
                              SizedBox(height: 18),
                              Row(children: [
                                SizedBox(
                                    width: 102,
                                    child: Text("Cotizacion No.:".toUpperCase(),
                                        style: boldText)),
                                Text(bill.billNumber),
                                SizedBox(width: 8),
                                Text("Total:".toUpperCase(), style: boldText),
                                SizedBox(width: 2),
                                Text(moneyFormat.format(bill.total))
                              ]),
                              SizedBox(height: 4),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 102,
                                        child: Text(
                                            "Descripcion:".toUpperCase(),
                                            style: boldText)),
                                    Expanded(
                                        child: Text(
                                            "COMO SE DESCRIBE EN LA COTIZACION"
                                                .toUpperCase()))
                                  ]),
                              SizedBox(height: 4),
                              Row(children: [
                                SizedBox(
                                    width: 102,
                                    child: Text("Embalaje:".toUpperCase(),
                                        style: boldText)),
                                Text("CTNS")
                              ]),
                              SizedBox(height: 4),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 102,
                                        child: Text("seguro:".toUpperCase(),
                                            style: boldText)),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                          Text(
                                              "COBERTURA TODO RIESGO SOBRE EL 110% DEL VALOR DE LA MERCANCÍA,"),
                                          Text(
                                              "QUE SERÁ CUBIERTO POR EL VENDEDOR HASTA EL PUERTO DE DESTINO."),
                                        ]))
                                  ]),
                              SizedBox(height: 4),
                              Row(children: [
                                SizedBox(
                                    width: 102,
                                    child: Text("Envío:".toUpperCase(),
                                        style: boldText)),
                                Text("China".toUpperCase()),
                                SizedBox(width: 50),
                                Text("DESTINO: PUERTO QUETZAL GUATEMALA.")
                              ]),
                              SizedBox(height: 4),
                              Row(children: [
                                SizedBox(
                                    width: 102,
                                    child: Text("Pago:".toUpperCase(),
                                        style: boldText)),
                                Text(
                                    "CRÉDITO A 90 DÍAS A PARTIR DE LA FECHA DE LA FACTURA")
                              ]),
                              SizedBox(height: 4),
                              Row(children: [
                                SizedBox(
                                    width: 102,
                                    child: Text("Notificar:".toUpperCase(),
                                        style: boldText)),
                                Text(
                                    "${bill.consignerName.toUpperCase()} COMO CONSIGNATARIO EN EL DOCUMENTO DE TRANSPORTE")
                              ]),
                              SizedBox(height: 18),
                              Text(
                                  "POR 100% CONFIRMADA E IRREVOCABLE L/C DISPONIBLE POR GIRA AL SIGG 30 DÍAS ANTES DEL MES PERMANECE VÁLIDO PARA NEGOCIACIÓN EN CHINA HASTA EL DÍA 15 DESPUÉS DE LA ÚLTIMA FECHA DE ENVÍO Y PERMITE ENVÍOS PARCIALES Y TRANSBORDO."),
                              SizedBox(height: 18),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 102,
                                        child: Text(
                                            "shipping samp:".toUpperCase(),
                                            style: boldText)),
                                    SizedBox(width: 20),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                          Text(
                                              "JUEGOS DE MUESTRA DE ENVÍO A ENVIAR ANTES DEL ENVÍO"),
                                          Text(
                                              "1. EL VENDEDOR SE RESERVA EL DERECHO DE CANCELAR ESTA VENTA O PARTE DE VED DE ACUERDO CON LOS TÉRMINOS ESTIPULADOS EN ESTA CONFIMACIÓN DE VENTA."),
                                          Text(
                                              "2. DIFERENCIAS RAZONABLES EN LOS DISEÑOS Y DEBEN PERMITIRSE."),
                                          Text(
                                              "3. LOS COMPRADORES DEBEN INDICAR SIEMPRE EL NÚMERO DE ESTA CONFIRMACIÓN DE VENTA EN LA L/C."),
                                        ]))
                                  ]),
                              SizedBox(height: 18),
                              Text(
                                  "POR FAVOR FIRME Y DEVUELVA UNA COPIA PARA EL ARCHIVO."),
                              Text("FIRMADO Y CONFIRMADO POR:"),
                              SizedBox(height: 20),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Center(
                                                  child: SizedBox(
                                                      height: 80,
                                                      child: Image(signature))),
                                              Divider(height: 4),
                                              Text("Mr. Rogelio Mansilla",
                                                  textAlign: TextAlign.center),
                                              Text("(Los vendedores)",
                                                  textAlign: TextAlign.center),
                                            ])),
                                    SizedBox(
                                        width: 150,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Divider(height: 4),
                                              Text("Mr. Guillermo Asencio",
                                                  textAlign: TextAlign.center),
                                              Text("(Agente de compra)",
                                                  textAlign: TextAlign.center),
                                            ]))
                                  ])
                            ])))
              ])),
          Watermark(
              fit: BoxFit.scaleDown,
              child: Opacity(
                  opacity: 0.1, child: Image(logo, height: 200, width: 200))),
        ]);
      }));

  return pdf;
}
