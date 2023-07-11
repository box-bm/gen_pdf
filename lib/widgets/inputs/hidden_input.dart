import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';

class HiddenInput extends StatelessWidget {
  final String name;
  final String? Function(String?)? validator;
  const HiddenInput({super.key, required this.name, this.validator});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        name: name,
        readOnly: true,
        decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            constraints: BoxConstraints(maxHeight: 0, minHeight: 0)),
        cursorHeight: 0,
        style: const TextStyle(color: Colors.transparent, fontSize: 0),
        validator: validator);
  }
}
