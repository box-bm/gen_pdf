import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

Future<Widget> headerMakan() async {
  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );

  return Row(children: [
    Container(
        height: 90,
        width: 90,
        child: Center(child: Image(logo, width: 80, height: 80))),
    Expanded(
        child: Container(
            padding: const EdgeInsets.all(4),
            height: 90,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("MAKAN GLOBAL SHIPPING".toUpperCase(),
                      style: TextStyle(font: Font.timesBold(), fontSize: 20)),
                  Text(
                      "Calle Elvira Méndez, edificio Interseco, Piso B.Panamá, Panamá.")
                ])))
  ]);
}
