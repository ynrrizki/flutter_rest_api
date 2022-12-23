import 'package:flutter/material.dart';
// import 'package:flutter_laravel_rest_api/ui/pages/article/test_page.dart';
import 'package:flutter_laravel_rest_api/ui/pages/menu_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MenuPage(),
    );
  }
}
