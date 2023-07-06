import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/screens/new_bill.dart';
import 'package:gen_pdf/screens/home/home.dart';
import 'package:gen_pdf/screens/new_consigner.dart';
import 'package:gen_pdf/screens/new_exporter.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Home.route: (context) => const Home(),
  NewBill.route: (context) => const NewBill(),
  NewConsigner.route: (context) => const NewConsigner(),
  NewExporter.route: (context) => const NewExporter()
};
