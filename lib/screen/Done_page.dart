import 'package:flutter/material.dart';

import 'homeScreen.dart';

class DonePage extends StatefulWidget {
  final int staticCustomerId;

  const DonePage ({Key? key, required this.staticCustomerId}) : super(key: key);

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
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
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 16),
            const Text(
              'You Reservation have been booked successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {

                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context)=> HomeScreen(staticCustomerId: widget.staticCustomerId,)));

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffc4dde0),
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                padding:
                    const EdgeInsets.only(left: 80, right: 80, top: 20, bottom: 20),
              ),
              child: const Text('Done',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
