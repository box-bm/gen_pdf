import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/inputs/submit_button_form.dart';

class NewItemForm extends StatefulWidget {
  final Function(Map<String, dynamic> values) onSubmit;

  const NewItemForm({super.key, required this.onSubmit});

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formkey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Nuevo elemento",
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 15),
              FormBuilderTextField(
                name: "numeration",
                decoration: const InputDecoration(labelText: "Numeracion"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric()
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: "description",
                decoration: const InputDecoration(labelText: "Descripcion"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: "quantity",
                decoration: const InputDecoration(labelText: "Cantidad"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.integer(),
                  FormBuilderValidators.min(1),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: "prs",
                decoration: const InputDecoration(labelText: "PRS"),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: "unitPrice",
                decoration: const InputDecoration(labelText: "Precio Unitario"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.integer(),
                  FormBuilderValidators.min(1),
                ]),
              ),
              const SizedBox(height: 10),
              SubmitButtonForm(
                formKey: formkey,
                onSubmit: () {
                  var values = {...formkey.currentState?.value ?? {}};

                  values.addAll({
                    "total": double.parse(values["unitPrice"]) *
                        double.parse(values["quantity"])
                  });
                  widget.onSubmit(values);
                },
              )
            ]));
  }
}
