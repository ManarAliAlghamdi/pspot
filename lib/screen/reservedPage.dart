import 'package:flutter/material.dart';
import 'package:pspot_test/models/shared_methods.dart';

import '../models/customer_tickets_model.dart';
import '../modules/fluid_nav_bar.dart';
import 'bookYourSpot.dart';

class ReservedPage extends StatefulWidget {
  const ReservedPage({super.key});

  @override
  _ReservedPageState createState() => _ReservedPageState();
}

class _ReservedPageState extends State<ReservedPage> {

  List<CustomerTickets> customerTickets = [];

  void initTickets(customerNo) async {
    customerTickets = [];
    await getCustomerTickets(customerNo).then((value) {
      setState(() {
        customerTickets = value;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initTickets(1);
    if(customerTickets.isEmpty){
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
                foregroundColor: Colors.black87, backgroundColor: Colors.white, padding: const EdgeInsets.all(20.0),
                elevation: 15,
                shadowColor: Colors.grey,
                alignment: Alignment.centerLeft,
              ),
            ),
            const SizedBox(height: 20),
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
          ]
          ),
          bottomNavigationBar: const SizedBox(height: 50, child: FluidNavBar())
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: const Text("My Parking Tickets"),
        ),

      );
    }
  }
}