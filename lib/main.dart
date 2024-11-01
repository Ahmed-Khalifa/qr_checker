import 'package:flutter/material.dart';
import 'package:qr_checker/pages/my_home_page.dart';
import 'package:qr_checker/pages/results_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QrChecker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const MyHomePage(title: 'QrChecker'),
        ResultsPage.id: (_) => const ResultsPage()
      },
    );
  }
}
