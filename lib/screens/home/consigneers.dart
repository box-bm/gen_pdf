import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/screens/new_consigneer.dart';
import 'package:gen_pdf/widgets/consigner_list.dart';

class Consigneers extends StatefulWidget {
  const Consigneers({super.key});

  @override
  State<Consigneers> createState() => _ConsigneersState();
}

class _ConsigneersState extends State<Consigneers> {
  List<String> selecteds = [];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: PageHeader(
            title: const Text("Consignatarios"),
            commandBar: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                primaryItems: [
                  CommandBarButton(
                      onPressed: () {
                        Navigator.pushNamed(context, NewConsigneer.route);
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
            child: ConsignerList(
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
