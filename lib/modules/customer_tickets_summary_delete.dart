import 'package:flutter/material.dart';

import '../models/customer_tickets_model.dart';
import '../models/locations_model.dart';
import '../models/shared_methods.dart';
import '../screen/payment_page.dart';

class CustomerTicketsDetailsControl extends StatefulWidget {
  final int staticCustomerId;
  final String locationLogo;
  final String locationName;
  final LocationParkingSpotModelOnServer ticketSpotInfo;
  final String resDate;
  final int period;
  const CustomerTicketsDetailsControl ({Key? key, required this.staticCustomerId,
    required this.locationLogo, required this.locationName, required this.ticketSpotInfo, required this.resDate, required this.period}) : super(key: key);

  @override
  State<CustomerTicketsDetailsControl> createState() => _CustomerTicketsDetailsControlState();
}

class _CustomerTicketsDetailsControlState extends State<CustomerTicketsDetailsControl> {
  String ticketId = '';


  late LocationParkingSpotModelOnServer ticketSpotInfo;
  double subTotal = 0;
  double taxAmount = 0;
  @override
  Widget build(BuildContext context) {
    ticketSpotInfo = widget.ticketSpotInfo;
    subTotal = ticketSpotInfo.spotCost*widget.period;
    taxAmount = subTotal * 0.15;
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
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
                      child: Image.asset(widget.locationLogo),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 180,
                        child: Text(
                          widget.locationName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.blueGrey
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Text('____________________________________________________________', style: TextStyle(fontWeight: FontWeight.w100),), ),
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
                      text: "Parking Spot",
                      style: TextStyle(color: Colors.blueGrey,),
                    ),
                    TextSpan(text: ' Number: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                    TextSpan(
                      text:ticketSpotInfo.parkingSpotDescription,
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
                      text: "Parking Spot ",
                      style: TextStyle(color: Colors.blueGrey,),
                    ),
                    TextSpan(text: 'Section: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                    TextSpan(
                      text:ticketSpotInfo.sectionName,
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
                      text: "Parking Spot ",
                      style: TextStyle(color: Colors.blueGrey,),
                    ),
                    TextSpan(text: 'Floor: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                    TextSpan(
                      text: ticketSpotInfo.floorName,
                      style: const TextStyle(color: Colors.orangeAccent),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Text('____________________________________________________________', style: TextStyle(fontWeight: FontWeight.w100),), ),

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
                      text: "Reservation Date and Time: ",
                      style: TextStyle(color: Colors.blueGrey,),
                    ),
                    TextSpan(
                      text: widget.resDate,
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
                      text: widget.period.toString(),
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
              child: Text('____________________________________________________________', style: TextStyle(fontWeight: FontWeight.w100),), ),
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
                      text: ticketSpotInfo.spotCost.toString(),
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
                      text: subTotal.toString(),
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
                      text: taxAmount.toString(),
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
                      text: '${subTotal+taxAmount}',
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
            Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                      PaymentPageEdited(staticCustomerId: widget.staticCustomerId, locationLogo: widget.locationLogo,
                        locationName: widget.locationName, ticketSpotInfo: ticketSpotInfo, resDate: widget.resDate,
                        period: widget.period, locationID: 1,
                      )
                         ));
                 }, child: Text("Confirm", style: TextStyle(color: Colors.white, fontSize: 20,),),
                    style: ElevatedButton.styleFrom(primary: const Color(0xffC4DFDF),))
            )],
        ),
      ),
    );
  }
}
