import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'screens.dart';
import 'ui.dart';

void main() => runApp(const DrivoApp());

class DrivoApp extends StatelessWidget {
  const DrivoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Drivo SV',
    debugShowCheckedModeBanner: false,
        builder: (context, child) => kIsWeb
            ? ColoredBox(
                color: const Color(0xFFE6EAEF),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: child!,
                  ),
                ),
              )
            : child!,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Palette.green),
      scaffoldBackgroundColor: Palette.background,
      appBarTheme: const AppBarTheme(backgroundColor: Palette.background),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Palette.field,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Palette.border),
        ),
      ),
    ),
    home: const WelcomeScreen(),
  );
}
