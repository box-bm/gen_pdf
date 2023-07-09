import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';

class SubmitButtonForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String label;
  final Function() onSubmit;
  const SubmitButtonForm(
      {super.key,
      required this.formKey,
      required this.onSubmit,
      this.label = "Guardar"});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.saveAndValidate()) {
            onSubmit();
          }
        },
        child: Text(label));
  }
}
