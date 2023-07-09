import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/screens/new_bill.dart';
import 'package:gen_pdf/screens/new_consigner.dart';
import 'package:gen_pdf/screens/new_exporter.dart';

import './bills.dart';
import './consigners.dart';
import './exporters.dart';

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
      appBar: AppBar(toolbarHeight: 30),
      body: PageView.builder(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pages.length,
          itemBuilder: (context, index) => pages.elementAt(index).content),
      bottomNavigationBar: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          currentIndex: currentPage,
          onTap: (value) {
            _controller.jumpToPage(value);
            setState(() {
              currentPage = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.document_scanner),
              icon: Icon(Icons.document_scanner_outlined),
              label: "Facturas",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.local_shipping),
              icon: Icon(Icons.local_shipping_outlined),
              label: "Exportadores",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.people_alt),
              icon: Icon(Icons.people_alt_outlined),
              label: "Clientes",
            ),
          ]),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            switch (currentPage) {
              case 0:
                Navigator.pushNamed(context, NewBill.route);
                break;
              case 1:
                Navigator.pushNamed(context, NewExporter.route);
                break;
              case 2:
                Navigator.pushNamed(context, NewConsigner.route);
                break;
            }
          },
          label: const Text("Crear")),
    );
  }
}

class Page {
  final String title;
  final Widget content;

  Page(this.title, this.content);
}

List<Page> pages = [
  Page("Facturas", const Bills()),
  Page("Exportadores", const Exporters()),
  Page("Clientes", const Consigners()),
];
