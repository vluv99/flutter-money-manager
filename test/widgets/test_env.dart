import 'package:flutter/material.dart';

class TestEnvironment extends StatelessWidget {
  TestEnvironment({Key? key, required this.child}) : super(key: key);

  Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(body: child),
    );
  }
}
