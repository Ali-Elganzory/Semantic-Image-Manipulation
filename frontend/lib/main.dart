import 'package:flutter/material.dart';

import 'util/util.dart';
import 'pages/routes.dart';
import 'third_party/third_party.dart';

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
          title: 'PaintX',
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            scaffoldBackgroundColor: Colors.white,
            inputDecorationTheme: const InputDecorationTheme(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey[300] ?? Colors.grey,
                side: BorderSide(
                  color: Colors.grey[500] ?? Colors.grey,
                  width: 0.5,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                minimumSize: const Size(
                  double.maxFinite,
                  46,
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  right: 24,
                ),
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
            tooltipTheme: const TooltipThemeData(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          routerConfig: GoRouter(
            routes: $appRoutes,
            initialLocation: '/workbench',
            debugLogDiagnostics: true,
          ),
          builder: (context, child) {
            return Toasted(
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
