import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';
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
            if (state is BillSaved) {
              Navigator.pop(context);
              displayInfoBar(
                context,
                builder: (context, close) => InfoBar(
                  title:
                      Text(isEditing ? "Factura modificada" : "Factura creada"),
                  severity: InfoBarSeverity.success,
                ),
              );
            }
          },
          child: ScaffoldPage(
              header: PageHeader(
                  title: const Text("Completa el formulario"),
                  commandBar: CommandBar(
                      mainAxisAlignment: MainAxisAlignment.end,
                      primaryItems: [
                        CommandBarButton(
                            onPressed: () {
                              var data = context.read<FormCubit>().state.values;
                              for (var item in [
                                'billNumber',
                                'exporterName',
                                'exporterAddress',
                                'consignerName',
                                'consignerAddress',
                                'containerNumber',
                                'bl'
                              ]) {
                                if (!data.keys.contains(item)) {
                                  displayInfoBar(context,
                                      builder: (context, close) => const InfoBar(
                                          severity: InfoBarSeverity.warning,
                                          title: Text(
                                              "Debe completar el formulario")));
                                  return;
                                }
                              }
                              if ((data['items'] as List? ?? []).isEmpty) {
                                displayInfoBar(context,
                                    builder: (context, close) => const InfoBar(
                                        severity: InfoBarSeverity.warning,
                                        title: Text(
                                            "Agregue al menos un elemento")));
                                return;
                              }
                              context.read<BillsBloc>().add(CreateBill(data));
                            },
                            icon: const Icon(FluentIcons.save),
                            label: const Text("Guardar Factura"))
                      ])),
              content: const SafeArea(
                  minimum: EdgeInsets.fromLTRB(10, 12, 10, 20),
                  child: CreateBillForm())),
        ));
  }
}
