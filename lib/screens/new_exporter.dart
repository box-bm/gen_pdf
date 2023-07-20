import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/base_form.dart';
import 'package:gen_pdf/widgets/exporter/form_inputs.dart';

import '../utils/appbar_utils.dart';

class NewExporter extends StatelessWidget {
  static String route = "newExporter";
  const NewExporter({super.key});

  @override
  Widget build(BuildContext context) {
    var initialValues =
        (ModalRoute.of(context)?.settings.arguments) as Map<String, dynamic>?;

    var isEditing = initialValues != null;

    return Scaffold(
        appBar: AppBar(
            leading: AppBarUtils.leadingWidget,
            title:
                Text(isEditing ? "Modificar Exportador" : "Crear exportador"),
            centerTitle: false,
            toolbarHeight: AppBarUtils.appbarHeight,
            flexibleSpace: AppBarUtils.platformAppBarFlexibleSpace),
        body: BlocListener<ExporterBloc, ExporterState>(
          listener: (context, state) {
            if (state is ExporterSaved) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  content: Text(isEditing
                      ? "Exportador modificado"
                      : "Exportador creado"),
                ),
              );
              Navigator.pop(context);
            }
          },
          child: SingleChildScrollView(
              child: SafeArea(
                  minimum: const EdgeInsets.fromLTRB(10, 12, 10, 20),
                  child: BaseForm(
                      initialValues: initialValues,
                      inputs: formInputs(),
                      onSubmit: (values) async {
                        if (isEditing) {
                          context.read<ExporterBloc>().add(EditExporter(
                              {...values, "id": initialValues['id']}));
                          return;
                        } else {
                          context
                              .read<ExporterBloc>()
                              .add(CreateExporter(values));
                        }
                      }))),
        ));
  }
}
