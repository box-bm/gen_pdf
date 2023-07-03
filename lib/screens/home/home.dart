import 'package:flutter/material.dart';
import 'package:gen_pdf/screens/new_bill.dart';
import 'package:gen_pdf/screens/new_consigneer.dart';
import 'package:gen_pdf/screens/new_exporter.dart';
import 'package:gen_pdf/widgets/appbar_button.dart';
import './bills.dart';
import './consigneers.dart';
import './exporters.dart';

List<Widget> screens = const [Bills(), Exporters(), Consigneers()];

class Home extends StatefulWidget {
  static String route = "home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0, keepPage: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generador de pdf"),
        actions: [
          AppbarButton(
              active: currentPage == 0,
              onPressed: () {
                _controller.jumpToPage(0);
              },
              label: "Facturas"),
          AppbarButton(
              active: currentPage == 1,
              onPressed: () {
                _controller.jumpToPage(1);
              },
              label: "Exportadores"),
          AppbarButton(
              active: currentPage == 2,
              onPressed: () {
                _controller.jumpToPage(2);
              },
              label: "Consignadores")
        ],
      ),
      body: Builder(
          builder: (context) => PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                allowImplicitScrolling: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: screens.length,
                controller: _controller,
                itemBuilder: (context, index) => screens[index],
              )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var route = "";
          if (currentPage == 0) {
            route = NewBill.route;
          } else if (currentPage == 1) {
            route = NewExporter.route;
          } else if (currentPage == 2) {
            route = NewConsigneer.route;
          }
          Navigator.restorablePushNamed(context, route);
        },
        icon: const Icon(Icons.add),
        label: const Text("Crear"),
      ),
    );
  }
}
