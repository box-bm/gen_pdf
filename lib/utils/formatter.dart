import 'package:intl/intl.dart';

final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
final NumberFormat moneyFormat = NumberFormat("\$#,##0.00", "en_US");

extension IntParsing on int {
  String suffixNumber({int length = 4}) {
    String result = "";
    var numberLength = toString().length;

    if (numberLength >= length) {
      throw "It cant be a number lenght greater than lenght $length";
    }
    result = result.padRight(length, "0");
    result =
        result.replaceRange(result.length - numberLength, null, toString());
    return result;
  }
}
