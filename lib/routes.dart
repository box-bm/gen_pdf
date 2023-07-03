import 'package:flutter/material.dart';
import 'package:gen_pdf/screens/new_bill.dart';
import 'package:gen_pdf/screens/home/home.dart';
import 'package:gen_pdf/screens/new_consigneer.dart';
import 'package:gen_pdf/screens/new_exporter.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Home.route: (context) => const Home(),
  NewBill.route: (context) => const NewBill(),
  NewConsigneer.route: (context) => const NewConsigneer(),
  NewExporter.route: (context) => const NewExporter()
};
