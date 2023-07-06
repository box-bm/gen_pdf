import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/inputs/input_params.dart';
import 'package:gen_pdf/widgets/inputs/textbox_form.dart';
import 'package:gen_pdf/widgets/person_form.dart';
import 'package:nit_validator/nit_validator.dart';

List<Widget> formInputs(
  Map<String, dynamic> values, {
  InputParams nameParams = const InputParams(name: 'name', label: 'Nombre'),
  InputParams addressParams =
      const InputParams(name: "address", label: "Direccion"),
  InputParams nitParams = const InputParams(name: "nit", label: "NIT"),
}) =>
    [
      ...personForm(
        values,
        nameParams: nameParams,
        addressParams: addressParams,
      ),
      const SizedBox(height: 10),
      TextboxForm(
          value: values[nitParams.name],
          name: nitParams.name,
          label: nitParams.label,
          validator: FormBuilderValidators.compose([
            (value) {
              if (!validateNIT(value) && value.toString().isNotEmpty) {
                return "Debe ser un nit valido";
              }
              return null;
            }
          ]))
    ];
