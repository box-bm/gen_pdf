import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/form_cubit.dart';

class BlocStore extends StatelessWidget {
  final Widget child;
  const BlocStore({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<FormCubit>(create: (context) => FormCubit()),
      BlocProvider<BillsBloc>(create: (context) => BillsBloc()),
      BlocProvider<ExporterBloc>(create: (context) => ExporterBloc()),
      BlocProvider<ConsignerBloc>(create: (context) => ConsignerBloc()),
    ], child: child);
  }
}
