import 'package:flutter/material.dart';
import 'ui/home_page.dart';

void main() {
  runApp(const TryOnApp());
}

class TryOnApp extends StatelessWidget {
  const TryOnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TryOn AI',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}