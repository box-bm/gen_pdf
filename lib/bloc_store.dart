import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/bloc/consigneer_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';

class BlocStore extends StatelessWidget {
  final Widget child;
  const BlocStore({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<BillsBloc>(create: (context) => BillsBloc()),
      BlocProvider<ExporterBloc>(create: (context) => ExporterBloc()),
      BlocProvider<ConsigneerBloc>(create: (context) => ConsigneerBloc()),
    ], child: child);
  }
}
