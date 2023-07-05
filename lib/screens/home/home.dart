import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/consigneer_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:window_manager/window_manager.dart';

import './bills.dart';
import './consigneers.dart';
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
    return NavigationView(
      appBar: NavigationAppBar(
          title: const Text("Generador de facturas"),
          height: 40,
          actions: DragToMoveArea(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 138,
                height: 30,
                child: WindowCaption(
                  brightness: FluentTheme.of(context).brightness,
                  backgroundColor: const Color(0x00000FFF),
                ),
              )
            ],
          )),
          automaticallyImplyLeading: false),
      pane: NavigationPane(
          selected: currentPage,
          onChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          displayMode: PaneDisplayMode.auto,
          items: [
            PaneItem(
                onTap: () {},
                title: const Text("Facturas"),
                icon: const Icon(FluentIcons.bill),
                body: const Bills()),
            PaneItem(
                onTap: () {
                  context.read<ExporterBloc>().add(const GetAllExporters());
                },
                title: const Text("Exportadores"),
                icon: const Icon(FluentIcons.contact),
                body: const Exporters()),
            PaneItem(
                onTap: () {
                  context.read<ConsigneerBloc>().add(const GetAllConsigners());
                },
                title: const Text("Clientes"),
                icon: const Icon(FluentIcons.a_a_d_logo),
                body: const Consigneers()),
          ]),
    );
  }
}
