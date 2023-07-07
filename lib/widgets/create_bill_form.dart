import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart' as form_cubit;
import 'package:gen_pdf/widgets/exporter/form_inputs.dart' as exporter_input;
import 'package:gen_pdf/widgets/consigne/form_inputs.dart' as consigner_inputs;
import 'package:gen_pdf/widgets/inputs/dropdown_form.dart';
import 'package:gen_pdf/widgets/inputs/input_params.dart';
import 'package:gen_pdf/widgets/inputs/submit_button_form.dart';
import 'package:gen_pdf/widgets/inputs/textbox_form.dart';

class CreateBillForm extends StatefulWidget {
  final Function(Map<String, dynamic> values) onSubmit;
  const CreateBillForm({super.key, required this.onSubmit});

  @override
  State<CreateBillForm> createState() => _CreateBillFormState();
}

class _CreateBillFormState extends State<CreateBillForm> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    context.read<ExporterBloc>().add(const GetAllExporters());
    context.read<ConsignerBloc>().add(const GetAllConsigners());
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
              TextboxForm(
                  name: 'billNumber',
                  label: "Numero de factura",
                  value: state.values['billNumber'],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ])),
              const SizedBox(height: 10),
              BlocBuilder<ExporterBloc, ExporterState>(
                  builder: (context, exporterState) {
                if (state is LoadingExporters) {
                  return const ProgressBar();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownForm(
                        label: "Exportador",
                        name: "exporterID",
                        value: state.values['exporterID'],
                        placeholder: "Busca y selecciona el exportador",
                        onInputChange: (value) {
                          if (value != null &&
                              value != "new" &&
                              value.toString().isNotEmpty) {
                            var exporter = exporterState.exporters
                                .firstWhere((element) => element.id == value);

                            changFormValue(exporter.name, 'exporterName');
                            changFormValue(exporter.name, 'exporterAddress');
                          } else {
                            changFormValue('', 'exporterName');
                            changFormValue('', 'exporterAddress');
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        items: [
                          AutoSuggestBoxItem(value: 'new', label: 'Nuevo'),
                          ...exporterState.exporters
                              .map((e) => AutoSuggestBoxItem(
                                  value: e.id, label: e.name))
                              .toList()
                        ]),
                    const SizedBox(height: 10),
                    ...exporter_input.formInputs(state.values,
                        disabled: (state.values['exporterID'] ?? "")
                                .toString()
                                .isEmpty ||
                            (state.values['exporterID'] ?? "") != "new",
                        nameParams: const InputParams(
                            name: 'exporterName',
                            label: 'Nombre de exportador'),
                        addressParams: const InputParams(
                            name: 'exporterAddress',
                            label: 'Direccion de exportador'))
                  ],
                );
              }),
              const SizedBox(height: 10),
              BlocBuilder<ConsignerBloc, ConsignerState>(
                builder: (context, consignerState) {
                  if (state is Loadingconsigners) {
                    return const ProgressBar();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownForm(
                          label: "Cliente",
                          name: "consignerID",
                          value: state.values['consignerID'],
                          placeholder: "Busca y selecciona el cliente",
                          onInputChange: (value) {
                            if (value != null &&
                                value != "new" &&
                                value.toString().isNotEmpty) {
                              var consigner = consignerState.consigners
                                  .firstWhere((element) => element.id == value);
                              changFormValue(consigner.name, 'consignerName');
                              changFormValue(
                                  consigner.address, 'consignerAddress');
                              changFormValue(consigner.nit, 'consignerNIT');
                            } else {
                              changFormValue('', 'consignerName');
                              changFormValue('', 'consignerAddress');
                              changFormValue('', 'consignerNIT');
                            }
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          items: [
                            AutoSuggestBoxItem(value: 'new', label: 'Nuevo'),
                            ...consignerState.consigners
                                .map((e) => AutoSuggestBoxItem(
                                    value: e.id, label: e.name))
                                .toList()
                          ]),
                      const SizedBox(height: 10),
                      ...consigner_inputs.formInputs(
                        state.values,
                        disabled: (state.values['consignerID'] ?? "")
                                .toString()
                                .isEmpty ||
                            (state.values['consignerID'] ?? "") != "new",
                        nameParams: const InputParams(
                          name: 'consignerName',
                          label: 'Nombre de cliente',
                        ),
                        addressParams: const InputParams(
                          name: 'consignerAddress',
                          label: 'Direccion de cliente',
                        ),
                        nitParams: const InputParams(
                          name: 'consignerNIT',
                          label: 'Nit de cliente',
                        ),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
              TextboxForm(
                  name: 'containerNumber',
                  label: "No. de contenedor",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  value: state.values['containerNumber']),
              const SizedBox(height: 10),
              TextboxForm(
                  name: 'bl',
                  label: "No. de BL",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  value: state.values['bl']),
              const SizedBox(height: 10),
              TextboxForm(
                  name: 'termsAndConditions',
                  label: "Terminos y condiciones",
                  maxLines: null,
                  value: state.values['termsAndConditions']),
              const SizedBox(height: 10),
              SubmitButtonForm(
                  formKey: _formkey,
                  onSubmit: () {
                    widget.onSubmit(state.values);
                  })
            ],
          )),
    );
  }

  void changFormValue(dynamic value, String key) {
    _formkey.currentState?.fields[key]?.didChange(value);
    context.read<form_cubit.FormCubit>().setValue(value, key);
  }
}
