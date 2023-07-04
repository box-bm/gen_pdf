import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';

class TextboxForm extends StatelessWidget {
  final String name;
  final String label;
  final String? placeholder;
  final String? Function(Object?)? validator;

  const TextboxForm(
      {super.key,
      required this.name,
      required this.label,
      this.placeholder,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: name,
        validator: validator,
        builder: (field) => InfoLabel(
              label: label,
              child: TextBox(
                placeholder: placeholder,
                expands: false,
                onChanged: field.didChange,
                unfocusedColor: field.hasError ? Colors.red : null,
              ),
            ));
  }
}
