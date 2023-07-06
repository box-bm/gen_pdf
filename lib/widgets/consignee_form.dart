import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart' as form_cubit;
import 'package:gen_pdf/widgets/inputs/textbox_form.dart';
import 'package:gen_pdf/widgets/person_form.dart';
import 'package:nit_validator/nit_validator.dart';

class ConsigneeForm extends StatefulWidget {
  final Function(Map<String, dynamic> values) onSubmit;
  const ConsigneeForm({super.key, required this.onSubmit});

  @override
  State<ConsigneeForm> createState() => _CreateBillFormState();
}

class _CreateBillFormState extends State<ConsigneeForm> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _formkey.currentState?.initState();
    super.initState();
  }

  @override
  void dispose() {
    _formkey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<form_cubit.FormCubit, form_cubit.FormState>(
      builder: (context, state) => FormBuilder(
          key: _formkey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ...personForm(state.values, context),
            const SizedBox(height: 10),
            TextboxForm(
                value: state.values['nit'] ?? "",
                name: 'nit',
                label: 'NIT',
                onInputChange: (value) {
                  context.read<form_cubit.FormCubit>().setValue(value, 'nit');
                },
                validator: FormBuilderValidators.compose([
                  (value) {
                    if (!validateNIT(value) && value.toString().isNotEmpty) {
                      return "Debe ser un nit valido";
                    }
                    return null;
                  }
                ])),
            const SizedBox(height: 10),
            Button(
                onPressed: () {
                  if (_formkey.currentState!.saveAndValidate()) {
                    context.read<form_cubit.FormCubit>().submit();
                    widget.onSubmit(state.values);
                  }
                },
                child: const Text("Guardar")),
          ])),
    );
  }
}
