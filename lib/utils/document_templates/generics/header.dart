import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

Future<Widget> headerMakan({
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.end,
  double height = 90,
  EdgeInsets textMargin = EdgeInsets.zero,
}) async {
  var logo = MemoryImage(
    (await rootBundle.load('assets/img/logo.png')).buffer.asUint8List(),
  );

  return Row(children: [
    Container(
        height: height,
        width: 90,
        child: Center(child: Image(logo, width: 80, height: height - 10))),
    Expanded(
        child: Container(
            margin: textMargin,
            padding: const EdgeInsets.all(4),
            height: height,
            child: Column(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  Text("MAKAN GLOBAL SHIPPING".toUpperCase(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("Calle Elvira Méndez No. 10 último piso"),
                  Text("Panamá, República de Panamá ")
                ])))
  ]);
}
