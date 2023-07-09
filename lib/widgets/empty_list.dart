import 'package:gen_pdf/common.dart';

class EmptyList extends StatelessWidget {
  final String message;
  const EmptyList({super.key, this.message = "Aun no tienes registros"});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.inbox, size: 60),
        Text(message, style: const TextStyle(fontSize: 30))
      ],
    );
  }
}
