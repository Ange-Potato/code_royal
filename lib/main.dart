import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const CodeRoyalApp());
}

class CodeRoyalApp extends StatelessWidget {
  const CodeRoyalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Royal',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const Scaffold(
        body: Center(
          child: Text('Code Royal'),
        ),
      ),
    );
  }
}