import 'package:gen_pdf/utils/formatter.dart';
import 'package:pdf/widgets.dart';

Widget moneyCell(double ammount) {
  return Container(
      padding: const EdgeInsets.all(2),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("\$"),
        Text(moneyFormatWithoutSimbol.format(ammount),
            textAlign: TextAlign.right)
      ]));
}
