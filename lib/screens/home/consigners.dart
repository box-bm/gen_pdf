import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';
import 'package:gen_pdf/screens/new_consigner.dart';
import 'package:gen_pdf/widgets/consigne/consigner_list.dart';

class Consigners extends StatefulWidget {
  const Consigners({super.key});

  @override
  State<Consigners> createState() => _ConsignersState();
}

class _ConsignersState extends State<Consigners> {
  List<String> selecteds = [];

  @override
  void initState() {
    context.read<ConsignerBloc>().add(const GetAllConsigners());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConsignerBloc, ConsignerState>(
      listener: (context, state) {
        if (state is DeletingConsigner) {
          displayInfoBar(
            context,
            builder: (context, close) => const InfoBar(
              title: Text("Eliminando exportadores"),
              severity: InfoBarSeverity.info,
            ),
          );
        } else if (state is DeletedConsigner) {
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
              title: const Text("Clientes"),
              commandBar: CommandBar(
                  mainAxisAlignment: MainAxisAlignment.end,
                  primaryItems: [
                    CommandBarButton(
                        onPressed: () {
                          context.read<FormCubit>().resetForm();
                          Navigator.pushNamed(context, NewConsigner.route);
                        },
                        icon: const Icon(FluentIcons.add),
                        label: const Text("Crear")),
                    CommandBarButton(
                        onPressed: selecteds.isEmpty
                            ? null
                            : () {
                                context
                                    .read<ConsignerBloc>()
                                    .add(DeleteConsigners(selecteds));
                              },
                        icon: const Icon(FluentIcons.delete),
                        label: const Text("Eliminar")),
                  ])),
          resizeToAvoidBottomInset: true,
          content: SafeArea(
              child: ConsignerList(
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
