import 'package:gen_pdf/bloc_store.dart';
import 'package:gen_pdf/common.dart';
import 'package:gen_pdf/routes.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gen_pdf/screens/home/home.dart';
import 'package:window_manager/window_manager.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocStore(
        child: FluentApp(
      theme: FluentThemeData(
        brightness: Brightness.light,
        accentColor: Colors.green,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
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
