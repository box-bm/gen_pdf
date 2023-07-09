import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/inputs/input_params.dart';

List<Widget> personForm({
  bool disabled = false,
  required InputParams nameParams,
  required InputParams addressParams,
}) =>
    [
      FormBuilderTextField(
          name: nameParams.name,
          enabled: !disabled,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
          decoration: InputDecoration(
            hintText: nameParams.placeholder,
            labelText: nameParams.label,
            enabled: !disabled,
          )),
      const SizedBox(height: 10),
      FormBuilderTextField(
          name: addressParams.name,
          enabled: !disabled,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
          decoration: InputDecoration(
            hintText: addressParams.placeholder,
            labelText: addressParams.label,
            enabled: !disabled,
          )),
    ];
