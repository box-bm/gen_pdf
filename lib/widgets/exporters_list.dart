import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';

class ExporterList extends StatelessWidget {
  const ExporterList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExporterBloc, ExporterState>(
        builder: (context, state) => ListView.builder(
              itemCount: state.exporters.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(state.exporters[index].name),
              ),
            ));
  }
}
