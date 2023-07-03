import 'package:flutter/material.dart';
import 'package:gen_pdf/widgets/exporter_form.dart';

class NewExporter extends StatelessWidget {
  static String route = "newExporter";
  const NewExporter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Exportador"),
        ),
        body: const SingleChildScrollView(
            child: SafeArea(
                minimum: EdgeInsets.fromLTRB(10, 12, 10, 20),
                child: Column(
                  children: [ExporterForm()],
                ))));
  }
}
