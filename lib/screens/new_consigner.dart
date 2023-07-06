import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/base_form.dart';
import 'package:gen_pdf/widgets/consigne/form_inputs.dart';
import 'package:window_manager/window_manager.dart';

class NewConsigner extends StatelessWidget {
  static String route = "newConsigner";
  const NewConsigner({super.key});

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
      content: BlocListener<ConsignerBloc, ConsignerState>(
        listener: (context, state) {
          if (state is ConsignerSaved) {
            Navigator.pop(context);
            displayInfoBar(
              context,
              builder: (context, close) => InfoBar(
                title:
                    Text(isEditing ? "Cliente modificado" : "Cliente creado"),
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
                        BaseForm(
                          inputs: (values) => formInputs(values),
                          onSubmit: (values) async {
                            if (isEditing) {
                              context
                                  .read<ConsignerBloc>()
                                  .add(EditConsigner(values));
                              return;
                            } else {
                              context
                                  .read<ConsignerBloc>()
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
