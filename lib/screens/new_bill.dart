import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/common.dart';
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
            child: const SafeArea(
                minimum: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: CreateBillForm())));
  }
}
