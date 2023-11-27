import 'package:flutter/material.dart';
import 'package:pspot_test/models/shared_methods.dart';
import '../modules/customer_invoice_details.dart';
import '../modules/customer_tickets_summary_delete.dart';
import '../modules/fluid_nav_bar.dart';
import '/modules/floor_list_control.dart';
import '../models/locations_model.dart';
import 'payment_page.dart';

class ReserveParkingSpot extends StatefulWidget {
  final int locationId;
  final int staticCustomerId;
  final String dateRev;
  final int period;
  final String locationName;
  final String locationLogo;
  const ReserveParkingSpot({super.key, required this.staticCustomerId, required this.dateRev, required this.locationId, required this.period, required this.locationName, required this.locationLogo});

  @override
  State<ReserveParkingSpot> createState() => _ReserveParkingSpot();
}

class _ReserveParkingSpot extends State<ReserveParkingSpot> {
  List<LocationParkingSpotModelOnServer> spotsList = [];
  bool showProcessing = true;
  bool showTable = false;
  bool showDetails = false;
  String ticketId = '';
  int ticketsIndex = 0;

  String spotDes = '';
  String sectionDes = '';
  String floorDes = '';

  void initParkingSpot(int locationId, int customerId, String requriredDateAndTime, int requiredPeriod) async {
    setState(() {
      showTable = false;
      showDetails = false;
      showProcessing = true;
    });
    spotsList = [];
    await getAvailableSpotsByLocation(
        locationId, customerId, requriredDateAndTime, requiredPeriod).then((value) {
      setState(() {
        spotsList = value;
        showProcessing = false;
        showTable = true;
      });
    });
  }
  int rowsCount = 0;

  @override
  void initState() {
    super.initState();
    initParkingSpot(widget.locationId, widget.staticCustomerId, widget.dateRev, widget.period);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Your Tickets To \n${widget.locationName}',
          style: const TextStyle(fontSize: 15),),
        backgroundColor: const Color(0xffC4DFDF),

      ),

      body: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
              child: Center(
                  child: SizedBox(
                      height: 400,
                      child: Column(
                          children: [
                            Visibility(
                                visible: showProcessing,
                                child: Center(
                                  child: Image.asset(
                                      'assets/images/processing.gif'),
                                )),
                            // Locations
                            Visibility(
                              visible: showTable,
                              child: Container(

                                  height: MediaQuery
                                      .sizeOf(context)
                                      .height - 208,
                                  child: ListView.builder(
                                    itemCount: spotsList.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (spotsList[index]
                                                .parkingSpotStatus == 'No') {
                                              AlertDialog alert = AlertDialog(
                                                title: const Text(
                                                    "Sorry, The Spot not Available"),
                                                content: const Text(
                                                    "Please choose Another Spot"),
                                                actions: [
                                                  Center(child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("OK"),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color(
                                                            0xffC4DFDF),
                                                      ))
                                                  )
                                                ],
                                              );
                                              showDialog(context: context,
                                                builder: (
                                                    BuildContext context) {
                                                  return alert;
                                                },);
                                              print('no');
                                            } else {
                                              setState(() {
                                                showDetails = true;
                                                showTable = false;
                                                ticketsIndex = index;
                                                spotDes = spotsList[index].parkingSpotDescription;
                                                sectionDes = spotsList[index].sectionName;
                                                floorDes = spotsList[index].floorName;
                                                ticketsIndex = index;
                                              });
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) =>
                                                      PaymentPageEdited(staticCustomerId: widget.staticCustomerId, locationLogo: widget.locationLogo,
                                                        locationName: widget.locationName, ticketSpotInfo: spotsList[index], resDate: widget.dateRev,
                                                        period: widget.period, locationID: widget.locationId,
                                                      )
                                              ));
                                              print('yes');
                                            }
                                          },
                                          child: Container(

                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(

                                                          width: (MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 2) - 10,
                                                          padding: const EdgeInsets
                                                              .all(8.0),
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xff9DB2B2),
                                                              border: Border
                                                                  .all(
                                                                  color: Colors
                                                                      .black)
                                                          ),
                                                          child: Text(
                                                              spotsList[index]
                                                                  .floorName,
                                                              textAlign: TextAlign
                                                                  .center)),
                                                      Container(
                                                          width: (MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 2) - 10,
                                                          padding: const EdgeInsets
                                                              .all(8.0),
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xff9DB2B2),

                                                              border: Border
                                                                  .all(
                                                                  color: Colors
                                                                      .black)
                                                          ),
                                                          child: Text(
                                                            spotsList[index]
                                                                .sectionName,
                                                            textAlign: TextAlign
                                                                .center,)),

                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width: 40,
                                                          height: 40,
                                                          padding: const EdgeInsets
                                                              .all(8.0),
                                                          decoration: BoxDecoration(
                                                              border: Border
                                                                  .all(
                                                                  color: Colors
                                                                      .black)),
                                                          child:
                                                          FittedBox(
                                                              fit: BoxFit.fill,
                                                              child: spotsList[index]
                                                                  .parkingSpotStatus ==
                                                                  'Yes'
                                                                  ? const Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .green,)
                                                                  : const Icon(
                                                                Icons
                                                                    .not_interested,
                                                                color: Colors
                                                                    .red,)
                                                          )),
                                                      Container(
                                                          width: 40,
                                                          height: 40,
                                                          padding: const EdgeInsets
                                                              .all(8.0),
                                                          decoration: BoxDecoration(
                                                              border: Border
                                                                  .all(
                                                                  color: Colors
                                                                      .black)
                                                          ),
                                                          child:
                                                          FittedBox(
                                                              fit: BoxFit.fill,
                                                              child: Icon(Icons
                                                                  .wheelchair_pickup_sharp,
                                                                color: spotsList[index]
                                                                    .isSNSpot ==
                                                                    'yes'
                                                                    ? Colors
                                                                    .black
                                                                    : Colors
                                                                    .white,)

                                                          )),
                                                      Container(
                                                          width: ((MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width - 80) / 3),
                                                          height: 40,
                                                          padding: const EdgeInsets
                                                              .all(8.0),
                                                          decoration: BoxDecoration(
                                                              border: Border
                                                                  .all(
                                                                  color: Colors
                                                                      .black)
                                                          ),
                                                          child: Text(
                                                            spotsList[index]
                                                                .parkingSpotDescription,
                                                            textAlign: TextAlign
                                                                .center,)),
                                                      Container(
                                                          width: ((MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width - 80) /
                                                              1.7) + 4,
                                                          height: 40,
                                                          padding: const EdgeInsets
                                                              .all(8.0),
                                                          decoration: BoxDecoration(
                                                              border: Border
                                                                  .all(
                                                                  color: Colors
                                                                      .black)
                                                          ),
                                                          child: Text(
                                                            "${spotsList[index]
                                                                .spotCost} SR",
                                                            textAlign: TextAlign
                                                                .center,)),
                                                    ],
                                                  )
                                                ],
                                              )

                                          ),
                                        ),

                                      );
                                    },
                                  )
                              ),
                            ),
                            // Visibility(
                            //     visible: showDetails,
                            //     child: Container(
                            //       height: 200,
                            //       child: SingleChildScrollView(
                            //         child: Column(
                            //           children: [
                            //             PaymentPageEdited(staticCustomerId: widget.staticCustomerId,
                            //               locationLogo: widget.locationLogo, locationName: widget.locationName, ticketSpotInfo: spotsList[ticketsIndex], resDate: widget.dateRev, period: widget.period,
                            //             )
                            //           ],
                            //         ),
                            //
                            //       ),
                            //     )
                            // )
                          ]
                      )
                  )
              )
          )
      ),
      bottomNavigationBar: SizedBox(height: 70,
          child: FluidNavBar(staticCustomerId: widget.staticCustomerId,)),

    );
  }
}
