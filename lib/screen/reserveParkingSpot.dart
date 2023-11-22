import 'package:flutter/material.dart';
import '/models/shared_methods.dart';
import '../modules/fluid_nav_bar.dart';
import '../models/locations_model.dart';

class ReserveParkingSpot extends StatefulWidget {
  final int locationId;
  final int staticCustomerId;
  final String dateRev;
  final int period;
  const ReserveParkingSpot({super.key, required this.staticCustomerId, required this.dateRev, required this.locationId, required this.period});

  @override
  State<ReserveParkingSpot> createState() => _ReserveParkingSpot();
}

class _ReserveParkingSpot extends State<ReserveParkingSpot> {

  List<LocationParkingSpotModelOnServer> floorsList = [];
  bool showProcessing = true;
  bool showTable = false;

  void initParkingSpot(int locationId, int customerId,
      String requriredDateAndTime, int requiredPeriod) async {
    floorsList = [];
    await getAvailableSpotsByLocation(
        locationId, customerId, requriredDateAndTime, requiredPeriod).then((
        value) {
      setState(() {
        floorsList = value;
        showProcessing = false;
        showTable = true;
      });
    });
  }

  int rowsCount = 0;

  @override
  void initState() {
    super.initState();
    initParkingSpot(widget.locationId, widget.staticCustomerId, widget.dateRev,
        widget.period);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Book Your Tickets'),
        backgroundColor: const Color(0xffC4DFDF),),

      body: Container(
          margin: const EdgeInsets.only(top: 10.0),
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
                                      .height - 200,
                                  child: ListView.builder(
                                    itemCount: floorsList.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (floorsList[index]
                                                .parkingSpotStatus == 'No') {
                                              AlertDialog alert = AlertDialog(
                                                title: const Text("Sorry, The Spot not Available"),
                                                content: const Text(
                                                    "Please choose Another Spot"),
                                                actions: [
                                                  Center(child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();},
                                                      child: const Text("OK"),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color(
                                                            0xffC4DFDF),
                                                      ))
                                                  )
                                                ],
                                              );
                                              showDialog(context: context, builder: (BuildContext context){return alert;},);
                                              print('no');
                                            } else {


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
                                                              floorsList[index]
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
                                                            floorsList[index]
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
                                                                      .black)
                                                          ),
                                                          child:
                                                          FittedBox(
                                                              fit: BoxFit.fill,
                                                              child: floorsList[index]
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
                                                                color: floorsList[index]
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
                                                            floorsList[index]
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
                                                            "${floorsList[index]
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
                            )
                          ]
                      )
                  )
              )
          )
      ),
      bottomNavigationBar: SizedBox(height: 100,
          child: FluidNavBar(staticCustomerId: widget.staticCustomerId,)),

    );
  }
}
