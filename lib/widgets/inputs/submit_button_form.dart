import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';

class SubmitButtonForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final Function() onSubmit;
  const SubmitButtonForm(
      {super.key, required this.formKey, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Button(
        onPressed: () {
          if (formKey.currentState!.saveAndValidate()) {
            context.read<FormCubit>().submit();
            onSubmit();
          }
        },
        child: const Text("Guardar"));
  }
}
