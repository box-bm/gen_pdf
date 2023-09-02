import 'package:gen_pdf/models/bill.dart';
import 'package:pdf/widgets.dart';

Widget signatures(Bill bill) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Container(
        width: 200,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Divider(),
          Text(bill.seller ?? ""),
          Text(bill.sellerPosition ?? ""),
        ])),
    Container(
        width: 200,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Divider(),
          Text(bill.buyer ?? ""),
          Text(bill.buyerPosition ?? ""),
        ])),
  ]);
}
