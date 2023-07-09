import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';
import 'package:gen_pdf/widgets/bill/create_bill_form.dart';

class NewBill extends StatelessWidget {
  static String route = "newBill";
  const NewBill({super.key});

  @override
  Widget build(BuildContext context) {
    var isEditing =
        (ModalRoute.of(context)?.settings.arguments) as bool? ?? false;

    return Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? "Modificar Factura" : "Creando Factura"),
        ),
        body: BlocListener<BillsBloc, BillsState>(
            listener: (context, state) {
              if (state is BillSaved) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        isEditing ? "Factura modificada" : "Factura creada"),
                  ),
                );
              }
            },
            child: SafeArea(
                child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton.icon(
                    onPressed: () {
                      var data = context.read<FormCubit>().state.values;
                      for (var item in [
                        'billNumber',
                        'exporterName',
                        'exporterAddress',
                        'consignerName',
                        'consignerAddress',
                        'containerNumber',
                        'bl'
                      ]) {
                        if (!data.keys.contains(item)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Debe completar el formulario")));
                          return;
                        }
                      }
                      if ((data['items'] as List? ?? []).isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Agregue al menos un elemento")));
                        return;
                      }
                      context.read<BillsBloc>().add(CreateBill(data));
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Guardar Factura"))
              ]),
              const Expanded(child: CreateBillForm()),
            ]))));
  }
}
