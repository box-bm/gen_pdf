import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

List<Widget> personForm = [
  FormBuilderTextField(
    name: 'name',
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(),
    ]),
    decoration: const InputDecoration(
        labelText: "Nombre", border: OutlineInputBorder()),
  ),
  FormBuilderTextField(
    name: 'address',
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(),
    ]),
    decoration: const InputDecoration(
        labelText: "Dirección", border: OutlineInputBorder()),
  ),
];
