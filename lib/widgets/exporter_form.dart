import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/widgets/person_form.dart';

class ExporterForm extends StatefulWidget {
  final Function(Map<String, dynamic> values) onSubmit;
  final Map<String, dynamic>? initialValues;
  const ExporterForm({super.key, required this.onSubmit, this.initialValues});

  @override
  State<ExporterForm> createState() => _CreateBillFormState();
}

class _CreateBillFormState extends State<ExporterForm> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _formkey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formkey,
        initialValue: widget.initialValues ?? {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...personForm,
            ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.saveAndValidate()) {
                    widget.onSubmit(_formkey.currentState!.value);
                  }
                },
                child: const Text("Guardar"))
          ],
        ));
  }
}
