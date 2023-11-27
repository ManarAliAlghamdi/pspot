import 'package:flutter/material.dart';
import 'package:pspot_test/screen/reserveParkingSpot.dart';

import 'homeScreen.dart';

class ProblemScreen extends StatefulWidget {
  final int locationId;
  final int staticCustomerId;
  final String dateRev;
  final int period;
  final String locationName;
  final String locationLogo;
  const ProblemScreen({super.key, required this.staticCustomerId, required this.dateRev, required this.locationId, required this.period, required this.locationName, required this.locationLogo});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Icon(Icons.report_problem_outlined, size: 250,color: const Color(0xffc4dde0),),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Sorry Your Spot Has Been Booked \nPlease Try Another Spot',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context)=>
                ReserveParkingSpot(staticCustomerId: widget.staticCustomerId, dateRev: widget.dateRev,
                    locationId: widget.locationId,
                    period: widget.period, locationName: widget.locationName, locationLogo: widget.locationLogo)
                ));},

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
              child: const Text('Book Again',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
