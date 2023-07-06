import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/consigneer_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/consignee_form.dart';
import 'package:window_manager/window_manager.dart';

class NewConsigneer extends StatelessWidget {
  static String route = "newConsigneer";
  const NewConsigneer({super.key});

  @override
  Widget build(BuildContext context) {
    var isEditing =
        (ModalRoute.of(context)?.settings.arguments) as bool? ?? false;

    return NavigationView(
      appBar: NavigationAppBar(
          height: 40,
          title: Text(isEditing ? "Modificar Cliente" : "Crear cliente"),
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
          ))),
      content: BlocListener<ConsigneerBloc, ConsigneerState>(
        listener: (context, state) {
          if (state is ConsignerSaved) {
            Navigator.pop(context);
            displayInfoBar(
              context,
              builder: (context, close) => InfoBar(
                title: Text(isEditing
                    ? "Consignatario modificado"
                    : "Consignatario creado"),
                severity: InfoBarSeverity.success,
              ),
            );
          }
        },
        child: ScaffoldPage(
            header: const PageHeader(title: Text("Completa el formulario")),
            content: SingleChildScrollView(
                child: SafeArea(
                    minimum: const EdgeInsets.fromLTRB(10, 12, 10, 20),
                    child: Column(
                      children: [
                        ConsigneeForm(
                          onSubmit: (values) async {
                            if (isEditing) {
                              context
                                  .read<ConsigneerBloc>()
                                  .add(EditConsigner(values));
                              return;
                            } else {
                              context
                                  .read<ConsigneerBloc>()
                                  .add(CreateConsigner(values));
                            }
                          },
                        )
                      ],
                    )))),
      ),
    );
  }
}
