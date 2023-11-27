import 'package:flutter/material.dart';

import '../models/customer_tickets_model.dart';

class CustomerTicketsCoeentrol extends StatefulWidget {
  final CustomerInvoices ticketsInfo;
  const CustomerTicketsCoeentrol({Key? key, required this.ticketsInfo}) : super(key: key);



  @override
  State<CustomerTicketsCoeentrol> createState() => _CustomerTicketsControlState();
}

class _CustomerTicketsControlState extends State<CustomerTicketsCoeentrol> {
  CustomerInvoices? ticketsInfo;

  @override
  Widget build(BuildContext context) {
    ticketsInfo = widget.ticketsInfo;
    return GestureDetector(
        onTap: (){},
        child: Container(
          child: Column(
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added this
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),

                      child: SizedBox(
                        height: 50,
                        width: 56,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset(ticketsInfo!.locationLogo),
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
                                  fontWeight: FontWeight.bold, fontSize: 15),),
                          ),
                          // Container(height: 7),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 180,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Invoice Date: : ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: ticketsInfo!.ticketDateTime,
                                    style: const TextStyle(color: Color(0xff93A7A7)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 180,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "ParkingSpot Number: : ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: ticketsInfo!.parkingSpotNumber,
                                    style: const TextStyle(color: Color(0xff93A7A7)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(),
                    //   child: IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
                    // ),
                  ],
                ),
              ]),
        )
    );
  }
}
