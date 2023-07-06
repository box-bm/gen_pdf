import 'dart:io';
import 'package:flutter/services.dart';
import 'package:gen_pdf/utils/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<void> genTestPDF() async {
  final pdf = Document();

  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );

  var contentBorder = Border.all();
  var boldText = TextStyle(fontWeight: FontWeight.bold, font: Font.timesBold());

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
                              decoration: BoxDecoration(border: contentBorder),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                        Text(DateTime.now().toIso8601String())
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
                                        Text("123")
                                      ])))
                        ]),
                        Container(
                            decoration: BoxDecoration(border: contentBorder),
                            child: Row(children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      padding: const EdgeInsets.all(4),
                                      child:
                                          Text("Exportador: Test exportador"))),
                              Expanded(
                                  child: Container(
                                      decoration:
                                          BoxDecoration(border: contentBorder),
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                          "Consignatario: Test consignatario"))),
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
                                            Text("Direccion", style: boldText),
                                            Text("Test direccion")
                                          ]))),
                              Expanded(
                                  child: Container(
                                      decoration:
                                          BoxDecoration(border: contentBorder),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Text(
                                                    "Direccion: Test Direccion",
                                                    style: boldText)),
                                            Container(
                                                decoration: BoxDecoration(
                                                    border: contentBorder),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Text("Nit: test NIT"))
                                          ]))),
                            ])),
                        Container(
                            decoration: BoxDecoration(border: contentBorder),
                            child: Row(children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      decoration:
                                          BoxDecoration(border: contentBorder),
                                      padding: const EdgeInsets.all(4),
                                      child: Text("No. Contenedor"))),
                              Expanded(
                                  child: Container(
                                      decoration:
                                          BoxDecoration(border: contentBorder),
                                      padding: const EdgeInsets.all(4),
                                      child: Text("No. B/L"))),
                            ])),
                        Container(
                            decoration: BoxDecoration(border: contentBorder),
                            child: Row(children: [
                              Expanded(
                                  child: Container(
                                      constraints:
                                          const BoxConstraints(minHeight: 90),
                                      padding: const EdgeInsets.all(4),
                                      child: Text("No. Total de piezas"))),
                              Expanded(
                                  child: Container(
                                      constraints:
                                          const BoxConstraints(minHeight: 90),
                                      decoration: const BoxDecoration(
                                          border: Border.symmetric(
                                              vertical: BorderSide())),
                                      padding: const EdgeInsets.all(4),
                                      child: Text("Terminos y condiciones"))),
                            ])),
                        Table(
                            border: TableBorder.all(),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: {
                              0: const FlexColumnWidth(1),
                              1: const FlexColumnWidth(2),
                              2: const FlexColumnWidth(1),
                              3: const FlexColumnWidth(1),
                              4: const FlexColumnWidth(1),
                              5: const FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(children: [
                                Text('Numeracion', textAlign: TextAlign.center),
                                Text('Descripcion',
                                    textAlign: TextAlign.center),
                                Text('Cantidad', textAlign: TextAlign.center),
                                Text('PRS', textAlign: TextAlign.center),
                                Text('Precio Unitario',
                                    textAlign: TextAlign.center),
                                Text('Monto total',
                                    textAlign: TextAlign.center),
                              ]),
                              TableRow(children: [
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('\$0.00', textAlign: TextAlign.right),
                              ]),
                              TableRow(children: [
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('\$0.00', textAlign: TextAlign.right),
                              ]),
                              TableRow(children: [
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('\$0.00', textAlign: TextAlign.right),
                              ]),
                              TableRow(children: [
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('', textAlign: TextAlign.center),
                                Text('\$0.00', textAlign: TextAlign.right),
                              ])
                            ])
                      ]))),
          Watermark(
              child: Opacity(
                  opacity: 0.1, child: Image(logo, height: 150, width: 150))),
        ]);
      }));

  FileManager manager = FileManager();

  final filePath =
      await manager.saveFile(fileName: "Test.pdf", allowedExtensions: ['pdf']);

  if (filePath == null) {
    return;
  }

  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());
}
