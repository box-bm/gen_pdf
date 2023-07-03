import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

List<Widget> personForm = [
  FormBuilderTextField(
    name: 'name',
    decoration: const InputDecoration(
        labelText: "Nombre", border: OutlineInputBorder()),
  ),
  FormBuilderTextField(
    name: 'address',
    decoration: const InputDecoration(
        labelText: "Dirección", border: OutlineInputBorder()),
  ),
];
