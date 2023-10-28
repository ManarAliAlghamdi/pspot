import 'package:flutter/material.dart';

import '../modules/fluid_nav_bar.dart';
import 'bookYourSpot.dart';

class ReservedPage extends StatefulWidget {
  @override
  _ReservedPageState createState() => _ReservedPageState();
}

class _ReservedPageState extends State<ReservedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          const SizedBox(height: 20),
          ElevatedButton.icon(
            //child: (Text("You Have No Previous Places /n Reserve Your Spots ",
            //style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)),
            icon: const Icon(Icons.access_alarm),
            label: const Text("click here to Reserve your first spot!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=> const BookYourSpot(title: 'Parking Spots | Locations List')));
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(20.0),
              primary: Colors.white,
              onPrimary: Colors.black87,
              elevation: 15,
              shadowColor: Colors.grey,
              alignment: Alignment.centerLeft,
            ),
          ),
          SizedBox(height: 20),
          const Text(
            "My ParKing TicKet",
            style: TextStyle(fontSize: 20, color: Colors.grey),
            textAlign: TextAlign.left,
          ),
          const Expanded(
              child: Center(
                child: Text(
                  "no reserved spots yet..",
                  textAlign: TextAlign.center,
                ),
              ))
        ]),
        bottomNavigationBar: Container(height: 50, child: FluidNavBar()));
  }
}