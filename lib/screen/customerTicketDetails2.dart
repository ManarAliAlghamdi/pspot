import 'package:flutter/material.dart';

import '../models/customer_tickets_model.dart';

class CustomerTicketsDetailsControl2 extends StatefulWidget {
  final CustomerTicketDetails ticketsDetailsInfo;
  const CustomerTicketsDetailsControl2({Key? key, required this.ticketsDetailsInfo}) : super(key: key);

  @override
  State<CustomerTicketsDetailsControl2> createState() => _CustomerTicketsDetailsControl2State();
}

class _CustomerTicketsDetailsControl2State extends State<CustomerTicketsDetailsControl2> {
  CustomerTicketDetails? ticketsDetailsInfo;


  @override
  Widget build(BuildContext context) {
    ticketsDetailsInfo = widget.ticketsDetailsInfo;
    String invoiceNo = ticketsDetailsInfo!.invoiceNo.toString();

    String parkingSpotNo = ticketsDetailsInfo!.parkingSpotNumber;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Ticket'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(100)),
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('the park mall'),
                            Text('inviose no:2222'),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            // Parking information

            const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.car_rental,
                            size: 50,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "parking spot details",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Text('parking spot no:'),
                      Row(
                        children: [
                          Text(
                            "parking spot section:",
                          ),
                          Spacer(),
                          Text(
                            "parking spot floor:",
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 50,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "period and time",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Text(
                        "Date : ",
                      ),
                      Text(
                        "period :",
                      ),
                    ],
                  ),
                )),
            Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 50,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Invoice details",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Container(
                        height: 170,
                        padding: const EdgeInsets.only(left: 4),
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border.all()),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'parking spot cast per hour:',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "sub total:",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "tax amount 15%:",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "discount: ",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "total cast:",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 50,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Payment Details",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            // Time period information
            // Parking cost information
          ],
        ),
      ),
    );
  }
}
