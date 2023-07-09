import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/inputs/input_params.dart';
import 'package:gen_pdf/widgets/person_form.dart';

List<Widget> formInputs({
  bool disabled = false,
  InputParams nameParams = const InputParams(
      name: "name",
      label: "Nombre",
      placeholder: "Ingresa el nombre del exportador"),
  InputParams addressParams = const InputParams(
      name: "address", label: "Direccion", placeholder: "Ingresa la direccion"),
}) =>
    personForm(
      disabled: disabled,
      nameParams: nameParams,
      addressParams: addressParams,
    );
