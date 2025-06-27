import 'package:flutter/material.dart';
import 'water_tracker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WaterTracker(), debugShowCheckedModeBanner: true);
  }
}
