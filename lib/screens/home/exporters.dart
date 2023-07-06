import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';
import 'package:gen_pdf/screens/new_exporter.dart';
import 'package:gen_pdf/widgets/exporter/exporters_list.dart';

class Exporters extends StatefulWidget {
  const Exporters({super.key});

  @override
  State<Exporters> createState() => _ExportersState();
}

class _ExportersState extends State<Exporters> {
  List<String> selecteds = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExporterBloc, ExporterState>(
      listener: (context, state) {
        if (state is DeletingExporter) {
          displayInfoBar(
            context,
            builder: (context, close) => const InfoBar(
              title: Text("Eliminando exportadores"),
              severity: InfoBarSeverity.info,
            ),
          );
        } else if (state is DeletedExporter) {
          displayInfoBar(
            context,
            builder: (context, close) => const InfoBar(
              title: Text("Exportador/es eliminados"),
              severity: InfoBarSeverity.success,
            ),
          );
          return setState(() {
            selecteds = [];
          });
        }
      },
      child: ScaffoldPage(
          header: PageHeader(
              title: const Text("Exportadores"),
              commandBar: CommandBar(
                  mainAxisAlignment: MainAxisAlignment.end,
                  primaryItems: [
                    CommandBarButton(
                        onPressed: () {
                          context.read<FormCubit>().resetForm();
                          Navigator.pushNamed(context, NewExporter.route);
                        },
                        icon: const Icon(FluentIcons.add),
                        label: const Text("Crear")),
                    CommandBarButton(
                        onPressed: selecteds.isEmpty
                            ? null
                            : () {
                                context
                                    .read<ExporterBloc>()
                                    .add(DeleteExporters(selecteds));
                              },
                        icon: const Icon(FluentIcons.delete),
                        label: const Text("Eliminar")),
                  ])),
          resizeToAvoidBottomInset: true,
          content: SafeArea(
              child: ExporterList(
            selecteds: selecteds,
            onSelect: (id, selected) {
              if (selected) {
                setState(() {
                  selecteds.add(id);
                });
              } else {
                setState(() {
                  selecteds.remove(id);
                });
              }
            },
          ))),
    );
  }
}
