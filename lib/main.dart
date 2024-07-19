import 'package:flutter/material.dart';
import 'package:flutter_bmi_app/home/home_page.dart';
import 'package:flutter_bmi_app/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: darkTheme, // lightTheme,
      home: const HomePage(),
    );
  }
}
