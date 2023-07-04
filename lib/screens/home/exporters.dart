import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/screens/new_exporter.dart';
import 'package:gen_pdf/widgets/exporters_list.dart';

class Exporters extends StatefulWidget {
  const Exporters({super.key});

  @override
  State<Exporters> createState() => _ExportersState();
}

class _ExportersState extends State<Exporters> {
  List<String> selecteds = [];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: PageHeader(
            title: const Text("Exportadores"),
            commandBar: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                primaryItems: [
                  CommandBarButton(
                      onPressed: () {
                        Navigator.pushNamed(context, NewExporter.route);
                      },
                      icon: const Icon(FluentIcons.add),
                      label: const Text("Crear")),
                  CommandBarButton(
                      onPressed: selecteds.isEmpty ? null : () {},
                      icon: const Icon(FluentIcons.delete),
                      label: const Text("Eliminar")),
                ])),
        resizeToAvoidBottomInset: true,
        content: SafeArea(
            child: ExporterList(
          selecteds: selecteds,
          onSelect: (id, selected) {
            if (selected) {
              setState(() {
                selecteds.add(id);
              });
            } else {
              setState(() {
                selecteds.remove(id);
              });
            }
          },
        )));
  }
}
