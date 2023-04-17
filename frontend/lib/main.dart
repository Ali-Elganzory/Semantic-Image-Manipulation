import 'package:flutter/material.dart';

import 'util/util.dart';
import 'third_party/third_party.dart';
import 'pages/routes.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: ScrollConfiguration(
      behavior: const ScrollBehaviorModified(),
      child: MaterialApp.router(
        title: 'Imaginto',
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          scaffoldBackgroundColor: Colors.grey.shade200,
          inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            titleMedium: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            labelLarge: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          buttonTheme: const ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
        routerConfig: GoRouter(
            routes: $appRoutes,
            initialLocation: '/workbench',
            debugLogDiagnostics: true),
        debugShowCheckedModeBanner: false,
      ),
    ));
  }
}
