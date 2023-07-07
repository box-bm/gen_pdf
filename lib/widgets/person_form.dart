import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/inputs/input_params.dart';
import 'package:gen_pdf/widgets/inputs/textbox_form.dart';

List<Widget> personForm(
  Map<String, dynamic> values, {
  bool disabled = false,
  InputParams nameParams = const InputParams(
    name: 'name',
    label: 'Nombre',
  ),
  InputParams addressParams = const InputParams(
    name: "Direccion",
    label: "address",
  ),
}) =>
    [
      TextboxForm(
          disabled: disabled,
          value: values[nameParams.name],
          name: nameParams.name,
          label: nameParams.label,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ])),
      const SizedBox(height: 10),
      TextboxForm(
          disabled: disabled,
          value: values[addressParams.name],
          name: addressParams.name,
          label: addressParams.label,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ])),
    ];
