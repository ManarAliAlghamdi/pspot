import 'package:flutter/material.dart';
import '/screen/invoices.dart';
import '/screen/login.dart';
import '/screen/signup.dart';
import '/screen/homeScreen.dart';




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
      home: const HomeScreen(staticCustomerId: 1,),
      //LoginScreen(),
      theme: ThemeData(
        primaryColor: const Color(0xffC4DFDF),
      ),
    );
  }
}