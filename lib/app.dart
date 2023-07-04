import 'package:gen_pdf/bloc_store.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/routes.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/screens/home/home.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocStore(
        child: FluentApp(
      theme: FluentThemeData(
        accentColor: Colors.green,
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.green,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        FluentLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.supportedLocales,
      routes: routes,
      initialRoute: Home.route,
    ));
  }
}
