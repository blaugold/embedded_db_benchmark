import 'package:benchmark/benchmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app_io.dart' if (dart.library.html) 'app_web.dart';
import 'home_page.dart';
import 'run_controller.dart';
import 'settings_controller.dart';
import 'style.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _initialized = false;
  final settingsController = SettingsController();
  late final runController = RunController(plan: settingsController.plan);

  @override
  void initState() {
    super.initState();
    settingsController.addListener(_updateRunControllerPlan);

    _initialize().then((value) => setState(() => _initialized = true));
  }

  @override
  void dispose() {
    settingsController.removeListener(_updateRunControllerPlan);
    super.dispose();
  }

  void _updateRunControllerPlan() =>
      runController.plan = settingsController.plan;

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (!_initialized) {
      child = const Scaffold();
    } else {
      child = const HomePage();
    }

    final lightTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
    );

    var darkTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
    );
    darkTheme = darkTheme.copyWith(
      toggleableActiveColor: darkTheme.colorScheme.secondaryContainer,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingsController),
        ChangeNotifierProvider.value(value: runController),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DB Bench',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: child,
      ),
    );
  }
}

Future<void> _initialize() async {
  loadDocumentsJson = _loadDocumentsFromAssets;
  initDatabasePlugins();
}

Future<String> _loadDocumentsFromAssets() =>
    rootBundle.loadString('packages/benchmark/src/fixture/documents.json');
