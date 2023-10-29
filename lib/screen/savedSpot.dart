
import 'package:flutter/material.dart';

import '../modules/fluid_nav_bar.dart';
import 'bookYourSpot.dart';

class SavedSpot extends StatefulWidget {
  const SavedSpot({super.key});

  @override
  _SavedSpotState createState() => _SavedSpotState();
}

class _SavedSpotState extends State<SavedSpot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          const SizedBox(height: 20),
          ElevatedButton.icon(
            //child: (Text("You Have No Previous Places /n Reserve Your Spots ",
            //style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)),
            icon: const Icon(Icons.favorite),
            label: const Center(
              child: Text("click here to save favorite spot Now!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=> const BookYourSpot(title: 'Parking Spots | Locations List')));
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87, backgroundColor: Colors.white, padding: const EdgeInsets.all(20.0),
              elevation: 15,
              shadowColor: Colors.grey,
              alignment: Alignment.centerLeft,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "My Saved Spots",
            style: TextStyle(fontSize: 20, color: Colors.grey),
            textAlign: TextAlign.left,
          ),
          const Expanded(
              child: Center(
                child: Text(
                  "no saved spots yet..",
                  textAlign: TextAlign.center,
                ),
              ))
        ]),
        bottomNavigationBar: const SizedBox(height: 50, child: FluidNavBar()));
  }
}