import 'package:gen_pdf/common.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FluentIcons.backlog_board,
          size: 60,
        ),
        Text(
          "Aun no tienes registros",
          style: TextStyle(fontSize: 30),
        )
      ],
    ));
  }
}
