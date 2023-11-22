import 'package:flutter/material.dart';
import '/screen/homeScreen.dart';
// import '/screen/bookYourSpot2.dart';
import 'screen/Profile.dart';
import 'screen/bookYourSpot2.dart';
import 'test.dart';
// import '/screen/bookYourSpot.dart';
// import '/screen/signup.dart';
// import '/screen/homeScreen.dart';
// import 'screen/login.dart';
// import 'screen/reservedPage.dart';
// import 'screen/saved_spot.dart';
// import 'screen/time_picker.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:

      //saved_places()
      BookYourSpot2(title: 'title', staticCustomerId: 1),
      // MyDateTimePicker(),
    );
  }
}