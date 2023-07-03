import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/widgets/person_form.dart';

class ConsigneeForm extends StatefulWidget {
  const ConsigneeForm({super.key});

  @override
  State<ConsigneeForm> createState() => _CreateBillFormState();
}

class _CreateBillFormState extends State<ConsigneeForm> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formkey,
        child: Column(
          children: [
            ...personForm,
            FormBuilderTextField(
              name: 'nit',
              decoration: const InputDecoration(
                  labelText: "NIT", border: OutlineInputBorder()),
            ),
          ],
        ));
  }
}
