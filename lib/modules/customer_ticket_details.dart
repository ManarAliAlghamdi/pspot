import 'package:flutter/material.dart';

import '../models/customer_tickets_model.dart';

class CustomerTicketsDetailsControl extends StatefulWidget {
  final CustomerTicketDetails ticketsDetailsInfo;
  const CustomerTicketsDetailsControl({
    Key? key,
    required this.ticketsDetailsInfo,
    required int staticCustomerId,
  }) : super(key: key);

  @override
  State<CustomerTicketsDetailsControl> createState() =>
      _CustomerTicketsDetailsControlState();
}

class _CustomerTicketsDetailsControlState
    extends State<CustomerTicketsDetailsControl> {
  CustomerTicketDetails? ticketsDetailsInfo;

  @override
  Widget build(BuildContext context) {
    ticketsDetailsInfo = widget.ticketsDetailsInfo;
    return GestureDetector(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  width: 70,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(ticketsDetailsInfo!.locationLogo),
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
                      child: Text(
                        ticketsDetailsInfo!.locationName,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 180,
                      child: RichText(
                        text: TextSpan(
                          text: 'Invoice Number: ',
                          style: DefaultTextStyle
                              .of(context)
                              .style,
                          children: <TextSpan>[
                            TextSpan(
                              text: ticketsDetailsInfo!.invoiceNo.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
           Container(
            child: Text('______________________________________________________________', style: TextStyle(fontWeight: FontWeight.w100),), ),

          Container(
            height: 30,
            alignment: Alignment.centerLeft, // Align the RichText to the left
            child: const Row(
                children: [
                  Icon(
                      Icons.time_to_leave, color: Colors.blueGrey, size: 25),
                  SizedBox(width: 10,),
                  Text('Parking Spot Details',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "Parking Spot Number: ",
                    style: TextStyle(color: Colors.blueGrey,),
                  ),
                  TextSpan(
                    text: ticketsDetailsInfo!.parkingSpotNumber,
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "Parking Spot Section: ",
                    style: TextStyle(color: Colors.blueGrey,),
                  ),
                  TextSpan(
                    text: ticketsDetailsInfo!.parkingSectionDescription,
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "Parking Spot Floor: ",
                    style: TextStyle(color: Colors.blueGrey,),
                  ),
                  TextSpan(
                    text: ticketsDetailsInfo!.parkingFloorDescriptions,
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
           Container(
            child: Text('______________________________________________________________', style: TextStyle(fontWeight: FontWeight.w100),), ),

          Container(
            height: 30,
            alignment: Alignment.centerLeft, // Align the RichText to the left
            child: const Row(
                children: [
                  Icon(
                      Icons.watch_later_outlined, color: Colors.blueGrey, size: 25),
                  SizedBox(width: 10,),
                  Text('Period And Date',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "Invoice Date: ",
                    style: TextStyle(color: Colors.blueGrey,),
                  ),
                  TextSpan(
                    text: ticketsDetailsInfo!.invoiceDateTime,
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "Ticket Period: ",
                    style: TextStyle(color: Colors.blueGrey,),
                  ),
                  TextSpan(
                    text: ticketsDetailsInfo!.ticketPeriod.toString(),
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                  const TextSpan(
                    text: " Hours",
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Text('______________________________________________________________', style: TextStyle(fontWeight: FontWeight.w100),), ),
          Container(
            height: 30,
            alignment: Alignment.centerLeft, // Align the RichText to the left
            child: const Row(
                children: [
                  Icon(
                      Icons.monetization_on_outlined, color: Colors.blueGrey, size: 25),
                  SizedBox(width: 10,),
                  Text('Invoice Details',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]
            ),
          ),

          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "Parking Spot Cost Per Hour: ",
                    style: TextStyle(color: Colors.blueGrey,),
                  ),
                  TextSpan(
                    text: ticketsDetailsInfo!.parkingSpotCostPerHour.toString(),
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                  const TextSpan(
                    text: " SR",
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "Sub Total: ",
                    style: TextStyle(color: Colors.blueGrey,),
                  ),
                  TextSpan(
                    text: ticketsDetailsInfo!.subTotal.toString(),
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                  const TextSpan(
                    text: " SR",
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "Tax Amount 15%: ",
                    style: TextStyle(color: Colors.blueGrey,),
                  ),
                  TextSpan(
                    text: ticketsDetailsInfo!.taxAmount.toString(),
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                  const TextSpan(
                    text: " SR",
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Discount: ",
                    style: TextStyle(color: Colors.blueGrey,),
                  ),
                  TextSpan(
                    text: "No Discount",
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: "Total: ",

                    style: TextStyle(color: Colors.blueGrey, fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ticketsDetailsInfo!.totalCost.toString(),
                    style: const TextStyle(color: Colors.orangeAccent,fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: " SR",
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 20,fontWeight: FontWeight.bold),
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
