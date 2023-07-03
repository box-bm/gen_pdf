import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/widgets/person_form.dart';

class ExporterForm extends StatefulWidget {
  const ExporterForm({super.key});

  @override
  State<ExporterForm> createState() => _CreateBillFormState();
}

class _CreateBillFormState extends State<ExporterForm> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formkey,
        child: Column(
          children: [
            ...personForm,
          ],
        ));
  }
}
