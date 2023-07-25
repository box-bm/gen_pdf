import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/selecteds_cubit.dart';
import 'package:gen_pdf/screens/preview_pdf.dart';
import 'package:gen_pdf/widgets/base_home_screen.dart';
import 'package:gen_pdf/widgets/bill/bill_card.dart';

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

          if (state is ErrorGeneratingDocuments) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }

          if (state is EndGenerateDocument) {
            context.read<SelectedsCubit>().clearSelection();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Documentos generados")));
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
                              context
                                  .read<BillsBloc>()
                                  .add(GenerateAllBillsDocuments(ids));
                            },
                      icon: const Icon(Icons.document_scanner),
                      label: const Text("Generar PDFs")),
                ],
            onInit: () => context.read<BillsBloc>().add(const GetAllBills()),
            itemCount: state.bills.length,
            itemBuilder: (index, selecteds, select) => BillCard(
                bill: state.bills.elementAt(index),
                select: select,
                selecteds: selecteds),
            onChangedFilter: (searchValue) =>
                context.read<BillsBloc>().add(Filter(searchValue)),
            isLoading: state is LoadingBills));
  }
}

class PrintOption {
  final IconData icon;
  final String title;
  final Function onTap;

  PrintOption(this.icon, this.title, this.onTap);

  PopupMenuItem get menuItem => PopupMenuItem<String>(
      onTap: () => onTap(),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        title: Text(title),
      ));
}
