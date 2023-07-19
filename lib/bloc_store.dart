import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_pdf/bloc/bills_bloc.dart';
import 'package:gen_pdf/bloc/consigner_bloc.dart';
import 'package:gen_pdf/bloc/exporter_bloc.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/cubit/selecteds_cubit.dart';

class BlocStore extends StatelessWidget {
  final Widget child;
  const BlocStore({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SelectedsCubit>(create: (context) => SelectedsCubit()),
      BlocProvider<BillsBloc>(create: (context) => BillsBloc()),
      BlocProvider<ExporterBloc>(create: (context) => ExporterBloc()),
      BlocProvider<ConsignerBloc>(create: (context) => ConsignerBloc()),
    ], child: child);
  }
}
