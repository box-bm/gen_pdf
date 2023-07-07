import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';
import 'package:gen_pdf/screens/new_bill.dart';
import 'package:gen_pdf/utils/gen_test_pdf.dart';
import 'package:gen_pdf/widgets/bills_list.dart';

class Bills extends StatefulWidget {
  const Bills({super.key});

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  List<String> selecteds = [];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: PageHeader(
            title: const Text("Facturas"),
            commandBar: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                primaryItems: [
                  CommandBarButton(
                      onPressed: () {
                        context.read<FormCubit>().resetForm();
                        Navigator.pushNamed(context, NewBill.route);
                      },
                      icon: const Icon(FluentIcons.add),
                      label: const Text("Crear")),
                  CommandBarButton(
                      onPressed: selecteds.isEmpty ? null : () {},
                      icon: const Icon(FluentIcons.delete),
                      label: const Text("Eliminar")),
                  CommandBarButton(
                      onPressed: selecteds.isEmpty ? null : () {},
                      icon: const Icon(FluentIcons.pdf),
                      label: const Text("Generar PDFs")),
                  CommandBarButton(
                      onPressed: () {
                        genTestPDF();
                      },
                      icon: const Icon(FluentIcons.pdf),
                      label: const Text("Pdf de prueba")),
                ])),
        resizeToAvoidBottomInset: true,
        content: SafeArea(
            child: BillsList(
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
