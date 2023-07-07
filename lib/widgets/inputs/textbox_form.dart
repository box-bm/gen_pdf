import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';

class TextboxForm extends StatefulWidget {
  final String name;
  final String label;
  final String? placeholder;
  final String? value;
  final String? Function(Object?)? validator;
  final int? maxLines;
  final bool disabled;

  const TextboxForm({
    super.key,
    required this.name,
    required this.label,
    this.disabled = false,
    this.placeholder,
    this.validator,
    required this.value,
    this.maxLines = 1,
  });

  @override
  State<TextboxForm> createState() => _TextboxFormState();
}

class _TextboxFormState extends State<TextboxForm> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    editingController.value =
        editingController.value.copyWith(text: widget.value ?? "");
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TextboxForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget != widget) {
      if (editingController.text != (widget.value ?? "")) {
        Future.delayed(Duration.zero, () {
          editingController.text = widget.value ?? "";
        });
      }
    }
  }

  void onChangeHandler(Object? value) {
    context.read<FormCubit>().setValue(value, widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: widget.name,
        validator: widget.validator,
        onChanged: onChangeHandler,
        initialValue: editingController.text,
        builder: (field) => InfoLabel(
              label: widget.label,
              child: TextBox(
                maxLines: widget.maxLines,
                controller: editingController,
                placeholder: widget.placeholder,
                expands: false,
                enabled: !widget.disabled,
                onChanged: field.didChange,
                onSubmitted: (_) => field.save(),
                unfocusedColor: field.hasError ? Colors.red : null,
              ),
            ));
  }
}
