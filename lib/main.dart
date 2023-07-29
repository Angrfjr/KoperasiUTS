import 'package:flutter/material.dart';
import 'package:koperasi/menu.dart';
import 'package:koperasi/page.dart';

void main() {
  runApp(const MyKoperasi());
}

class MyKoperasi extends StatelessWidget {
  const MyKoperasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
