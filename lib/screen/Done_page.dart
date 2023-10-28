import 'package:flutter/material.dart';
import 'package:pspot/screen/homeScreen.dart';

class DonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/done.jpeg',
              width: 400,
              height: 400,
            ),
            SizedBox(height: 16),
            Text(
              'You have been booked your \n parking spots successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {

                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context)=> const HomeScreen()));

              },
              child: Text('Done',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Color(0xffc4dde0),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 80, right: 80, top: 20, bottom: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
