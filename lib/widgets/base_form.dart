import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart' as form_cubit;
import 'package:gen_pdf/widgets/inputs/submit_button_form.dart';

class BaseForm extends StatefulWidget {
  final List<Widget> Function(Map<String, dynamic> values) inputs;
  final Function(Map<String, dynamic> values) onSubmit;
  const BaseForm({super.key, required this.onSubmit, required this.inputs});

  @override
  State<BaseForm> createState() => _BaseFormFormState();
}

class _BaseFormFormState extends State<BaseForm> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...widget.inputs(state.values),
                const SizedBox(height: 10),
                SubmitButtonForm(
                    formKey: _formkey,
                    onSubmit: () => widget.onSubmit(state.values)),
              ],
            )));
  }
}
