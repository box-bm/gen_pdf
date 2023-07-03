import 'package:flutter/material.dart';
import 'package:gen_pdf/widgets/consignee_form.dart';

class NewConsigneer extends StatelessWidget {
  static String route = "newConsigneer";
  const NewConsigneer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Consignatario"),
        ),
        body: const SingleChildScrollView(
            child: SafeArea(
                minimum: EdgeInsets.fromLTRB(10, 12, 10, 20),
                child: Column(
                  children: [ConsigneeForm()],
                ))));
  }
}
