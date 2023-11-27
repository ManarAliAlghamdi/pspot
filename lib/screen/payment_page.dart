import 'package:flutter/material.dart';
import '/screen/problem_screen.dart';

import '../models/locations_model.dart';
import '../models/shared_methods.dart';
import 'Done_page.dart';
import 'reserveParkingSpot.dart';



class PaymentPageEdited extends StatefulWidget {
  final int staticCustomerId;
  final String locationLogo;
  final String locationName;
  final LocationParkingSpotModelOnServer ticketSpotInfo;
  final String resDate;
  final int period;
  final int locationID;
  const PaymentPageEdited({Key? key, required this.staticCustomerId,
    required this.locationLogo, required this.locationName, required this.ticketSpotInfo, required this.resDate, required this.period, required this.locationID}) : super(key: key);


  @override
  _PaymentPageEditedState createState() => _PaymentPageEditedState();
}

class _PaymentPageEditedState extends State<PaymentPageEdited> {
  var cards;
  int staticCustomerId = 0;
  late LocationParkingSpotModelOnServer ticketSpotInfo;
  double subTotal = 0;
  double taxAmount = 0;
  double totalCost = 0;
String resState = '';

  Future<String> reserveSpot(int spotId, int customerId, String ticketsDateAndTime, int requiredPeriod,double totalCost) async {
    resState = '';

    await reserveParkingSpot( spotId, customerId, ticketsDateAndTime, requiredPeriod, totalCost).then((value) {
      setState(() {
        resState = value;

      });
    });
    return resState;
  }
  @override
  Widget build(BuildContext context) {
    ticketSpotInfo = widget.ticketSpotInfo;

    subTotal = ticketSpotInfo.spotCost*widget.period;

    taxAmount = subTotal * 0.15;

    totalCost = subTotal+totalCost;

    staticCustomerId = widget.staticCustomerId;
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          "Tickets Summary",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: const Color(0xffC4DFDF),
      leading:
      IconButton(
          onPressed:  (){  Navigator.push(context, MaterialPageRoute(
              builder: (context) => ReserveParkingSpot(
                staticCustomerId: widget.staticCustomerId,
                locationId: widget.locationID,
                dateRev: widget.resDate ,
                period: widget.period,
                locationName: widget.locationName,
                locationLogo: widget.locationLogo,)));},
          icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20,left: 20,bottom:5),
                      child: Text(widget.locationName, style: const TextStyle(color: Colors.blueGrey,fontSize: 30, fontWeight: FontWeight.bold),)),

                 const Padding(
                     padding: EdgeInsets.only(left: 20,),
                     child: Text("Reserved Spot Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Container(

                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Spot Number:",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  ticketSpotInfo.parkingSpotDescription,
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                        Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Spot Section:",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  ticketSpotInfo.sectionName,
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Spot Floor:",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  ticketSpotInfo.floorName,
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                        ],
                      ),
                    ),
                  ),

                  const Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text("Date And Time Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                widget.resDate.substring(0,10),
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Start Time:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                widget.resDate.substring(10),
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Period:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                               "${widget.period} Hours",
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 20,),
                      child: Text("Invoice Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Spot Cost Per Hour:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(ticketSpotInfo.spotCost.toString(),
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Sub Total:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                               subTotal.toString(),
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tax Amount 15%:",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "${taxAmount}",
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          const Divider(
                            color: Colors.black,
                          ),
                           Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                 '${subTotal+taxAmount} SR',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 20,),
                      child: Text("Payment Method", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          RadioListTile(
                            title: const Text("Debit/credit card"),
                            value: "card",
                            groupValue: cards,
                            onChanged: (val) {
                              setState(() {
                                cards = val;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text("Apple Pay"),
                            value: "apple_pay",
                            groupValue: cards,
                            onChanged: (val) {
                              setState(() {
                                cards = val;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text("Split in 4, interest-free"),
                            value: "split",
                            groupValue: cards,
                            onChanged: (val) {
                              setState(() {
                                cards = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffc4dde0),
                            padding: const EdgeInsets.only(left: 80, right: 80, top: 20, bottom: 20),
                          ),
                          onPressed: () async{
                         await   reserveSpot(
                               ticketSpotInfo.parkingSpotId,
                             widget.staticCustomerId,
                             widget.resDate,
                             widget.period,
                             totalCost
                           ).then((value){
                           if(value == 'done') {
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context) => DonePage(staticCustomerId: widget.staticCustomerId,),
                             ));
                           }else{
                             Navigator.push(context, MaterialPageRoute(
                               builder: (context) => ProblemScreen(staticCustomerId: staticCustomerId,
                                   dateRev: widget.resDate, locationId: widget.locationID,
                                   period: widget.period, locationName: widget.locationName, locationLogo: widget.locationLogo),
                             ));
                           }
                         });

                          },
                          child: const Text("Pay Now",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
