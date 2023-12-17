import 'package:flutter/material.dart';
import '/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashscreen(),
      theme: ThemeData(
        primaryColor: const Color(0xffC4DFDF),
      ),
    );
  }
}
