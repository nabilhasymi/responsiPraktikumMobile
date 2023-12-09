import 'package:flutter/material.dart';
import 'package:responsi_prak_mobile/Screen/HalamanUtama.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HalamanUtama());
  }
}
