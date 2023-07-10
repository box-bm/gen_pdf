import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/screens/new_bill.dart';
import 'package:gen_pdf/screens/preview_pdf.dart';
import 'package:gen_pdf/widgets/base_home_screen.dart';

class Bills extends StatelessWidget {
  const Bills({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BillsBloc, BillsState>(
        listener: (context, state) {
          if (state is PrintReady) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PreviewBill(document: state.document, id: state.id),
                ));
          }
        },
        builder: (context, state) => BaseHomeScreen(
            title: "Facturas",
            actions: (ids) => [
                  TextButton.icon(
                      onPressed: ids.isEmpty
                          ? null
                          : () {
                              context.read<BillsBloc>().add(DeleteBills(ids));
                            },
                      icon: const Icon(Icons.delete),
                      label: const Text("Eliminar")),
                  TextButton.icon(
                      onPressed: ids.isEmpty
                          ? null
                          : () {
                              context.read<BillsBloc>().add(PrintBills(ids));
                            },
                      icon: const Icon(Icons.document_scanner),
                      label: const Text("Generar PDFs")),
                ],
            onInit: () => context.read<BillsBloc>().add(const GetAllBills()),
            itemCount: state.bills.length,
            itemBuilder: (index, selecteds, select) => Card(
                borderOnForeground: true,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: selecteds
                              .contains(state.bills.elementAt(index).id),
                          onChanged: (value) {
                            select(state.bills.elementAt(index).id);
                          }),
                      Expanded(child: Text(state.bills.elementAt(index).bl)),
                      IconButton(
                          onPressed: () {
                            context.read<BillsBloc>().add(
                                DeleteBill(state.bills.elementAt(index).id));
                          },
                          icon: const Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            context.read<BillsBloc>().add(
                                PreviewPDF(state.bills.elementAt(index).id));
                          },
                          icon: const Icon(Icons.print)),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, NewBill.route,
                                arguments:
                                    state.bills.elementAt(index).toListAsMap());
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                )),
            onChangedFilter: (searchValue) =>
                context.read<BillsBloc>().add(Filter(searchValue)),
            isLoading: state is LoadingBills));
  }
}
