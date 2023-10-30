import 'package:flutter/material.dart';

import '../models/customer_tickets_model.dart';

class CustomerTicketsControl extends StatefulWidget {
  final CustomerTickets ticketsInfo;
  const CustomerTicketsControl({Key? key, required this.ticketsInfo}) : super(key: key);

  @override
  State<CustomerTicketsControl> createState() => _CustomerTicketsControlState();
}

class _CustomerTicketsControlState extends State<CustomerTicketsControl> {
  CustomerTickets? ticketsInfo;


  @override
  Widget build(BuildContext context) {
    ticketsInfo = widget.ticketsInfo;
    final String parkingSpotNo = ticketsInfo!.parkingSpotNumber;
    final String invoiceDate = ticketsInfo!.ticketDateTime;

    return GestureDetector(
        child: Container(
          child: Column(
              children: [
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 60,
                        width: 70,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset(
                              ticketsInfo!.locationLogo
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 180,
                            child: Text(ticketsInfo!.locationName,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                          // Container(height: 7),
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 180,
                            child: Text("invoice date: $invoiceDate",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),),
                          ),
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 180,
                            child: Text("parking spot number: $parkingSpotNo",
                              style: const TextStyle(
                                fontSize: 14, color: Colors.black,),),
                          ),
                          Container(height: 10,)
                        ],
                      ),
                    )
                  ],
                ),
              ]),
        )
    );
  }
}
