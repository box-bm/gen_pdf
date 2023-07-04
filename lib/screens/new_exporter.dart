import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/exporter_form.dart';

class NewExporter extends StatelessWidget {
  static String route = "newExporter";
  const NewExporter({super.key});

  @override
  Widget build(BuildContext context) {
    var initialValues =
        (ModalRoute.of(context)?.settings.arguments) as Map<String, dynamic>?;
    var isEditing = initialValues != null;

    return NavigationView(
      appBar: NavigationAppBar(
          title: Text(isEditing ? "Modificar Exportador" : "Crear exportador")),
      content: BlocListener<ExporterBloc, ExporterState>(
        listener: (context, state) {
          if (state is ExporterSaved) {
            Navigator.pop(context);
            displayInfoBar(
              context,
              builder: (context, close) => InfoBar(
                title: Text(
                    isEditing ? "Exportador modificado" : "Exportador creado"),
                severity: InfoBarSeverity.success,
              ),
            );
          }
        },
        child: ScaffoldPage(
            header: const PageHeader(
                title: Text("Completa el formulario"),
                leading: Icon(FluentIcons.contact)),
            content: SingleChildScrollView(
                child: SafeArea(
                    minimum: const EdgeInsets.fromLTRB(10, 12, 10, 20),
                    child: Column(
                      children: [
                        ExporterForm(
                          initialValues: initialValues,
                          onSubmit: (values) async {
                            if (isEditing) {
                              context
                                  .read<ExporterBloc>()
                                  .add(EditExporter(values));
                              return;
                            } else {
                              context
                                  .read<ExporterBloc>()
                                  .add(CreateExporter(values));
                            }
                          },
                        )
                      ],
                    )))),
      ),
    );
  }
}
