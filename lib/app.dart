import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/routes.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/screens/home/home.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 109, 189, 154)),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.supportedLocales,
      routes: routes,
      initialRoute: Home.route,
    );
  }
}
