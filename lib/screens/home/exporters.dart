import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/widgets/exporters_list.dart';

class Exporters extends StatelessWidget {
  const Exporters({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: ExporterList());
  }
}
