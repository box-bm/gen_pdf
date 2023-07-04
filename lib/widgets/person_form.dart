import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/inputs/textbox_form.dart';

List<Widget> personForm = [
  TextboxForm(
      name: 'name',
      label: 'Nombre',
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ])),
  TextboxForm(
      name: 'address',
      label: 'Direccion',
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ])),
];
