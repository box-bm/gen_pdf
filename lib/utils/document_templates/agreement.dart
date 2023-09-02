import 'package:flutter/services.dart';
import 'package:gen_pdf/models/bill.dart';
import 'package:gen_pdf/utils/document_templates/generics/signatures.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Page> getAgreementTemplate(Bill bill) async {
  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );

  var boldText = TextStyle(fontWeight: FontWeight.bold);

  var page = Page(
      pageFormat: PdfPageFormat.letter,
      margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
      theme: ThemeData(
          defaultTextStyle: TextStyle(
              font: Font.helvetica(), lineSpacing: 0.5, fontSize: 9.3)),
      build: (Context context) {
        return Stack(children: [
          Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Spacer(),
                        Text("CONTRATO DE VENTA".toUpperCase(),
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
                                  width: 100,
                                  child: Text(
                                      DateFormat.yMMMd().format(bill.date!),
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
                                  width: 100,
                                  padding: const EdgeInsets.all(1),
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Text(bill.billNumber,
                                      textAlign: TextAlign.center))
                            ]),
                        SizedBox(height: 28),
                        Text("términos del acuerdo".toUpperCase(),
                            style: boldText, textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        Text(
                            "CONTRATO DE VENTA en el que la empresa MAKAN GLOBAL SHIPPING. (el vendedor) Vende diversas mercancías a la empresa ${bill.consignerName.toUpperCase()}. (el comprador) Calle Elvira Méndez, edifico Interseco, piso B. Panamá, panamá. EL VENDEDOR y EL COMPRADOR, acuerdan conjuntamente llevar a cabo este contrato de acuerdo con las siguientes cláusulas, ACUERDO DE COMPRA DE MERCANCÍA MISCELÁNEA."),
                        SizedBox(height: 8),
                        Text(
                            "PRIMERO: Ambas empresas están debidamente representadas, tienen plenos derechos y tienen el poder de celebrar contratos comerciales."),
                        SizedBox(height: 6),
                        Text(
                            "1. Ambas empresas expresan sus intereses en poner en práctica una relación comercial de compra y venta continua, para lo cual SE ACUERDEN LOS SIGUIENTES TÉRMINOS Y CONDICIONES: Se establece una relación comercial entre ambas compañías donde:"),
                        Text(
                            "2. La operación de compra y venta se lleva a cabo en condiciones de libre mercado."),
                        Text(
                            "3. No hay ningún tipo de restricción sobre el uso y el destino final de los productos para el Comprador, están totalmente disponibles al comprarlos."),
                        Text(
                            "4. Tanto la venta como el precio no dependen de ninguna condición o contraprestación impuesta por el Vendedor al Comprador."),
                        Text(
                            "5. El precio es libre y sin condiciones a que el vendedor se devuelva directa o indirectamente a cualquier parte de los ingresos de la reventa o a cualquier transferencia o uso posterior de los productos por parte del Comprador; no hay ningún tipo de pago de regalías, regalías o uso de mercancía."),
                        Text(
                            "6. Ambas partes del contrato, comprador y vendedor, son entidades legales totalmente independientes y ninguno de sus empleados, administradores o propietarios tiene ningún vínculo, excepto el que está vinculado por la presente."),
                        Text("7. No hay descuentos para el pronto pago."),
                        Text("8. Condiciones de entrega y pago:"),
                        Container(
                            margin: const EdgeInsets.only(left: 36),
                            child:
                                Text("8.1. Punto de entrega: Puerto Quetzal")),
                        Container(
                            margin: const EdgeInsets.only(left: 36),
                            child: Text(
                                "8.2. Pago: crédito de 90 días a partir de la fecha de la factura.")),
                        Text(
                            "9. Las discrepancias en la recepción de la mercancía enviada y facturada correrán a cargo del comprador."),
                        Text(
                            "10. El vendedor se encargará de cubrir los costos de exportación, de acuerdo con el incoterm CIF."),
                        SizedBox(height: 8),
                        Text(
                            "SEGUNDO: Se establece el siguiente mecanismo de compra-venta: Cualquier controversia derivada de este contrato se transmitirá a través del Procedimiento."),
                        SizedBox(height: 8),
                        Text(
                            "TERCERO: A este documento, adjunto los documentos originales, emitidos por MAKAN GLOBAL SHIPPING. que consisten en: Cotización de los productos; número ${bill.billNumber}, número de confirmación de compra ${bill.billNumber} del que se atestigua su legitimidad."),
                        SizedBox(height: 8),
                        Text(
                            "Las partes declaran que aceptan todos y cada uno de los términos y condiciones establecidos en este contrato, con la emisión de la factura en el frente y el envío de la mercancía o el envío."),
                        Spacer(),
                        signatures(bill),
                        Spacer(),
                      ]))),
          Watermark(
              fit: BoxFit.scaleDown,
              child: Opacity(
                  opacity: 0.1, child: Image(logo, width: 350, height: 250))),
        ]);
      });

  return page;
}
