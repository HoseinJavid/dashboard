import 'package:dashboard/commons/theme.dart';
import 'package:flutter/material.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
        Locale localeSystem = const Locale('fa', 'IR');
    // Locale localeSystem = const Locale('en', 'US');
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: localeSystem,
      title: 'Dashboard App',
      theme: MyTheme.getTheme(locale: localeSystem),
      localizationsDelegates: const [
        // Add your localization delegates here
      ],
      routerConfig: appRouter,
    );
  }
}