import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/inputs/input_params.dart';

import '../exporter/form_inputs.dart' as expoter_form;
import '../consigne/form_inputs.dart' as consigner_inputs;

class HeaderBillForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const HeaderBillForm({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        FormBuilderTextField(
            name: 'billNumber',
            decoration: const InputDecoration(labelText: "Numero de factura"),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ])),
        const SizedBox(height: 10),
        BlocBuilder<ExporterBloc, ExporterState>(builder: (context, state) {
          if (state is LoadingExporters) {
            return const CircularProgressIndicator.adaptive();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBuilderDropdown(
                  decoration: const InputDecoration(
                    labelText: "Exportador",
                    hintText: "Busca y selecciona el exportador",
                  ),
                  name: "exporterID",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) {
                    if (value != null &&
                        value != "new" &&
                        value.toString().isNotEmpty) {
                      var selectedExporter = state.exporters
                          .firstWhere((element) => element.id == value);
                      changFormValue(selectedExporter.name, 'exporterName');
                      changFormValue(
                          selectedExporter.address, 'exporterAddress');
                    } else {
                      changFormValue('', 'exporterName');
                      changFormValue('', 'exporterAddress');
                    }
                  },
                  items: [
                    const DropdownMenuItem(value: 'new', child: Text("Nuevo")),
                    ...state.exporters
                        .map((e) =>
                            DropdownMenuItem(value: e.id, child: Text(e.name)))
                        .toList()
                  ]),
              const SizedBox(height: 10),
              ...expoter_form.formInputs(
                  nameParams: const InputParams(
                      name: 'exporterName',
                      label: 'Nombre de Exportador',
                      placeholder: "Ingresa el nombre del exportador"),
                  addressParams: const InputParams(
                      name: 'exporterAddress',
                      label: 'Direccion de Exportador',
                      placeholder: "Ingresa la direccion del exportador"))
            ],
          );
        }),
        const SizedBox(height: 10),
        BlocBuilder<ConsignerBloc, ConsignerState>(
          builder: (context, state) {
            if (state is Loadingconsigners) {
              return const CircularProgressIndicator.adaptive();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilderDropdown<String>(
                    decoration: const InputDecoration(
                      labelText: "Cliente",
                      hintText: "Busca y selecciona el cliente",
                    ),
                    name: "consignerID",
                    onChanged: (value) {
                      if (value != null &&
                          value != "new" &&
                          value.toString().isNotEmpty) {
                        var consigner = state.consigners
                            .firstWhere((element) => element.id == value);
                        changFormValue(consigner.name, 'consignerName');
                        changFormValue(consigner.address, 'consignerAddress');
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
                      const DropdownMenuItem(
                          value: 'new', child: Text('Nuevo')),
                      ...state.consigners
                          .map((e) => DropdownMenuItem(
                              value: e.id, child: Text(e.name)))
                          .toList()
                    ]),
                const SizedBox(height: 10),
                ...consigner_inputs.formInputs(
                    nameParams: const InputParams(
                        name: 'consignerName',
                        label: 'Nombre de Cliente',
                        placeholder: "Ingresa el nombre del cliente"),
                    addressParams: const InputParams(
                        name: 'consignerAddress',
                        label: 'Direccion de Cliente',
                        placeholder: "Ingresa la direccion del cliente"),
                    nitParams: const InputParams(
                        name: 'consignerNit',
                        label: 'NIT de cliente',
                        placeholder: "Ingresa el NIT del cliente"))
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        FormBuilderTextField(
          name: 'containerNumber',
          decoration: const InputDecoration(
              hintText: "Ingrese el numero de contenedor",
              labelText: "No. de contenedor"),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        const SizedBox(height: 10),
        FormBuilderTextField(
          name: 'bl',
          decoration: const InputDecoration(
              hintText: "Ingrese el BL", labelText: "No. de BL"),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
      ],
    );
  }

  void changFormValue(dynamic value, String key) {
    formKey.currentState?.fields[key]?.didChange(value);
  }
}