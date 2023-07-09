import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PreviewBill extends StatelessWidget {
  final pw.Document document;
  final String id;

  const PreviewBill({
    super.key,
    required this.document,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vista previa de pdf")),
      body: SafeArea(
        child: PdfPreview(
          allowPrinting: true,
          canChangeOrientation: false,
          canChangePageFormat: false,
          canDebug: false,
          actions: [
            IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  context.read<BillsBloc>().add(PrintBill(id));
                })
          ],
          build: (format) => document.save(),
        ),
      ),
    );
  }
}
