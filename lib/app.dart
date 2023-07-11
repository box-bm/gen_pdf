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
        child: MaterialApp(
      theme: ThemeData.from(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 89, 168, 199),
                  background: const Color.fromARGB(255, 250, 250, 250)))
          .copyWith(
              inputDecorationTheme:
                  const InputDecorationTheme(border: OutlineInputBorder())),
      darkTheme: ThemeData.from(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: const Color.fromARGB(255, 89, 144, 166)))
          .copyWith(
              inputDecorationTheme:
                  const InputDecorationTheme(border: OutlineInputBorder())),
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.supportedLocales,
      routes: routes,
      initialRoute: Home.route,
    ));
  }
}
