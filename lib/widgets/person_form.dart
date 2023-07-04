import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';
import 'package:gen_pdf/widgets/inputs/textbox_form.dart';

List<Widget> personForm(Map<String, dynamic> values, BuildContext context) => [
      TextboxForm(
          value: values['name'] ?? "",
          name: 'name',
          label: 'Nombre',
          onInputChange: (value) {
            context.read<FormCubit>().setValue(value, 'name');
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ])),
      const SizedBox(height: 10),
      TextboxForm(
          value: values['address'] ?? "",
          name: 'address',
          label: 'Direccion',
          onInputChange: (value) {
            context.read<FormCubit>().setValue(value, 'address');
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ])),
    ];
