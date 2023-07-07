import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/create_bill_form.dart';
import 'package:window_manager/window_manager.dart';

class NewBill extends StatelessWidget {
  static String route = "newBill";
  const NewBill({super.key});

  @override
  Widget build(BuildContext context) {
    var isEditing =
        (ModalRoute.of(context)?.settings.arguments) as bool? ?? false;

    return NavigationView(
        appBar: NavigationAppBar(
          height: 40,
          title: Text(isEditing ? "Modificar Factura" : "Crear Factura"),
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
        ),
        content: BlocListener<BillsBloc, BillsState>(
          listener: (context, state) {
            // if (state is ConsignerSaved) {
            //   Navigator.pop(context);
            //   displayInfoBar(
            //     context,
            //     builder: (context, close) => InfoBar(
            //       title: Text(isEditing
            //           ? "Consignatario modificado"
            //           : "Consignatario creado"),
            //       severity: InfoBarSeverity.success,
            //     ),
            //   );
            // }
          },
          child: ScaffoldPage(
              header: const PageHeader(title: Text("Completa el formulario")),
              content: SafeArea(
                  minimum: const EdgeInsets.fromLTRB(10, 12, 10, 20),
                  child: CreateBillForm(
                    onSubmit: (Map<String, dynamic> values) {
                      print(values);
                    },
                  ))),
        ));
  }
}
