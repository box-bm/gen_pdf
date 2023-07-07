import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/inputs/input_params.dart';
import 'package:gen_pdf/widgets/person_form.dart';

List<Widget> formInputs(
  Map<String, dynamic> values, {
  bool disabled = false,
  InputParams nameParams = const InputParams(name: "name", label: "Nombre"),
  InputParams addressParams =
      const InputParams(name: "address", label: "Direccion"),
}) =>
    [
      ...personForm(
        values,
        disabled: disabled,
        nameParams: nameParams,
        addressParams: addressParams,
      )
    ];
