import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/inputs/input_params.dart';
import 'package:gen_pdf/widgets/person_form.dart';
import 'package:nit_validator/nit_validator.dart';

List<Widget> formInputs({
  bool disabled = false,
  InputParams nameParams = const InputParams(
      name: 'name',
      label: 'Nombre',
      placeholder: "Ingresa el nombre del cliente"),
  InputParams addressParams = const InputParams(
      name: "address",
      label: "Direccion",
      placeholder: "Ingresa el nombre de la direccion"),
  InputParams nitParams = const InputParams(
      name: "nit", label: "NIT", placeholder: "Ingresa el NIT del cliente"),
}) =>
    [
      ...personForm(
        disabled: disabled,
        nameParams: nameParams,
        addressParams: addressParams,
      ),
      const SizedBox(height: 10),
      FormBuilderTextField(
          name: nitParams.name,
          enabled: !disabled,
          validator: FormBuilderValidators.compose([
            (value) {
              if (value != null) {
                if (!validateNIT(value) && value.isNotEmpty) {
                  return "Debe ser un nit valido";
                }
              }
              return null;
            }
          ]),
          decoration: InputDecoration(
            hintText: nitParams.placeholder,
            labelText: nitParams.label,
            enabled: !disabled,
          ))
    ];
