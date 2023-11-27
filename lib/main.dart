import 'package:flutter/material.dart';
import 'package:pspot_test/screen/invoices.dart';
import 'package:pspot_test/screen/login.dart';
import 'package:pspot_test/screen/signup.dart';
import '/screen/homeScreen.dart';
// import '/screen/bookYourSpot.dart';
import 'screen/Profile.dart';

import 'screen/bookYourSpot.dart';
import 'screen/problem_screen.dart';
import 'test.dart';
// import '/screen/bookYourSpot.dart';
// import '/screen/signup.dart';
// import '/screen/homeScreen.dart';
// import 'screen/login.dart';
// import 'screen/invoices.dart';
// import 'screen/customer_faves_locations.dart';
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
      // SignUp(),
          HomeScreen(staticCustomerId: 1,),
      //saved_places()
      // MyDateTimePicker(),
      theme: ThemeData(
        primaryColor: Color(0xffC4DFDF), // Set the primary color for the app
      ),
    );
  }
}