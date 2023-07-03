import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateBillForm extends StatefulWidget {
  const CreateBillForm({super.key});

  @override
  State<CreateBillForm> createState() => _CreateBillFormState();
}

class _CreateBillFormState extends State<CreateBillForm> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formkey,
        child: Column(
          children: [
            FormBuilderDateTimePicker(
              name: 'date',
              inputType: InputType.date,
              initialDatePickerMode: DatePickerMode.day,
              decoration: const InputDecoration(labelText: "Fecha"),
            ),
            FormBuilderTextField(
              name: 'billNumber',
              decoration: const InputDecoration(labelText: "Numero de factura"),
            ),
            FormBuilderTextField(
              name: 'exporterID',
              decoration: const InputDecoration(labelText: "Exportador"),
            ),
            FormBuilderTextField(
              name: 'consigneeID',
              decoration: const InputDecoration(labelText: "Consignatario"),
            ),
            FormBuilderTextField(
              name: 'containerNumber',
              decoration: const InputDecoration(labelText: "No. de contenedor"),
            ),
            FormBuilderTextField(
              name: 'bl',
              decoration: const InputDecoration(labelText: "No. BL"),
            ),
            FormBuilderTextField(
              name: 'termsAndConditions',
              decoration:
                  const InputDecoration(labelText: "Terminos y condiciones"),
            ),
          ],
        ));
  }
}
