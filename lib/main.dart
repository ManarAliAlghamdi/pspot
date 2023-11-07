import 'package:flutter/material.dart';
import '/screen/homeScreen.dart';
import 'screen/login.dart';
import 'screen/reservedPage.dart';
import 'screen/saved_spot.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(staticCustomerId: 1),
    );
  }
}