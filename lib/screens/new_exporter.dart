import 'package:flutter/material.dart';
import 'package:gen_pdf/repository/exporters_repository.dart';
import 'package:gen_pdf/widgets/exporter_form.dart';

class NewExporter extends StatelessWidget {
  static String route = "newExporter";
  const NewExporter({super.key});

  @override
  Widget build(BuildContext context) {
    var initialValues =
        (ModalRoute.of(context)?.settings.arguments) as Map<String, dynamic>?;
    var isEditing = initialValues != null;

    return Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? "Modificar Exportador" : "Crear exportador"),
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                minimum: const EdgeInsets.fromLTRB(10, 12, 10, 20),
                child: Column(
                  children: [
                    ExporterForm(
                      initialValues: initialValues,
                      onSubmit: (values) async {
                        if (isEditing) {
                          print(values);
                          return;
                        }
                        await ExporterRepository().createExporter(values);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Creado")));
                      },
                    )
                  ],
                ))));
  }
}
