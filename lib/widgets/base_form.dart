import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/inputs/submit_button_form.dart';

class BaseForm extends StatefulWidget {
  final GlobalKey<FormBuilderState>? formKey;
  final Map<String, dynamic>? initialValues;
  final List<Widget> inputs;
  final Function(Map<String, dynamic> values) onSubmit;

  const BaseForm(
      {super.key,
      required this.onSubmit,
      required this.inputs,
      this.initialValues,
      this.formKey});

  @override
  State<BaseForm> createState() => _BaseFormFormState();
}

class _BaseFormFormState extends State<BaseForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    initForm();
    super.initState();
  }

  GlobalKey<FormBuilderState> get formKey => widget.formKey ?? _formKey;

  void initForm() {
    formKey.currentState?.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  void submit() {
    widget.onSubmit(formKey.currentState!.value);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: widget.formKey ?? formKey,
        initialValue: widget.initialValues ?? {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...widget.inputs,
            const SizedBox(height: 10),
            SubmitButtonForm(formKey: formKey, onSubmit: submit),
          ],
        ));
  }
}
