
import 'package:flutter/material.dart';
import '../models/locations_model.dart';
import '../models/shared_methods.dart';
import '../modules/fluid_nav_bar.dart';
import '../modules/loaction_control.dart';
import 'package:intl/intl.dart';

import 'reserveParkingSpot.dart';


class BookYourSpot2 extends StatefulWidget {
  final int staticCustomerId;
  const BookYourSpot2({super.key, required this.title,  required this.staticCustomerId});


  final String title;

  @override
  State<BookYourSpot2> createState() => _BookYourSpot2State();
}

class _BookYourSpot2State extends State<BookYourSpot2> {
  int locationId = 0;
  int staticCustomerId = 0;
  TextEditingController searchTextField = TextEditingController();
  List<LocationModel> locationsList = [];
  List<LocationModel> filteredLocationsList = [];


  int currentLocationNo = -1;
  String currentLocation = "";
  String currentFlor = "";
  bool showLocations = false;
  bool showTimeDatePicker = false;
  bool showProcessing = true;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String formattedDate = '';
  final f = new DateFormat('yyyy-MM-dd hh:mm');


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(selectedDate);
      });
    }
  }


  void initLocations(int customerId) async {
    locationsList = [];
    await getLocations(customerId).then((value) {
      setState(() {
        locationsList = value;
        showProcessing = false;
        showLocations = true;
      });
      filteredLocationsList = locationsList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initLocations(widget.staticCustomerId);
  }

  Future<void> _refreshLocations() async {
    setState(() {
      showLocations = false;
      showProcessing = true;
    });
    await getLocations(widget.staticCustomerId).then((value) {
      setState(() {
        locationsList = value;
        showProcessing = false;
        showLocations = true;
        showTimeDatePicker = false;

      });
      filteredLocationsList = locationsList;
    });
  }

  void _incrementCounter() {
    setState(() {});
  }

  // List<ParkingSpotModel> getSectionSpots(int sectionNo) {
  //   filteredParkingSpots =
  //       parkingSpots.where((i) => i.parkingSpotSectionNo == sectionNo).toList();
  //   return filteredParkingSpots;
  // }

  void filterLocationList() {
    setState(() {
      filteredLocationsList = locationsList
          .where((i) =>
          i.locationName
              .toLowerCase()
              .contains(searchTextField.text.toLowerCase()))
          .toList();
    });
  }

  // void showLocationFloors(int locationNo) async {
  //   setState(() {
  //     showLocations = false;
  //     showFloors = false;
  //     showProcessing = true;
  //   });
  //   filteredLocationFloors = [];
  //   await getLocationFloors(locationNo).then((value) {
  //     setState(() {
  //       filteredLocationFloors = value;
  //       showLocations = false;
  //       showTimeDatePicker = false;
  //       showSections = false;
  //       showProcessing = false;
  //       showFloors = true;
  //     });
  //   });
  // }

  // void filterFloorsList(int locationNo) {
  //   setState(() {
  //     filteredLocationFloors =
  //         locationFloors.where((i) => i.floorLocationNo == locationNo).toList();
  //   });
  // }

  void _onItemTapped(int index) {
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    staticCustomerId = widget.staticCustomerId;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "The Locations", style: TextStyle(color: Colors.black),),
        backgroundColor: Color(0xffC4DFDF),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery
                .sizeOf(context)
                .height,
            child: Column(
                children: [
                  Visibility(
                      visible: showProcessing,
                      child: Center(
                        child: Image.asset('assets/images/processing.gif'),
                      )),
                  // Locations
                  Visibility(
                    visible: showLocations,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                              hintText: 'Search for parking',
                            ),
                            controller: searchTextField,
                            onChanged: (text) {
                              filterLocationList();
                            }),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height - 195,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 50,
                          child: RefreshIndicator(
                            onRefresh: _refreshLocations,
                            child: ListView.builder(
                                itemCount: filteredLocationsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showLocations = false;
                                        showTimeDatePicker = true;
                                        locationId = filteredLocationsList[index].locationId;
                                      });

                                    },
                                    child: Row(
                                      children: [
                                        LocationControl(
                                          locationInfo: filteredLocationsList[index],
                                          staticCustomerId: widget.staticCustomerId,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Floors
                  Visibility(
                    visible: showTimeDatePicker,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(58, 57, 57, 1)),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showLocations = true;
                              });
                            },
                            child: const Text(
                              ' |Back to locations',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            color: const Color(0xffC4DFDF),
                            child: Text(
                              currentLocation,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: SizedBox(
                                height: MediaQuery
                                    .sizeOf(context)
                                    .height - 250,
                                    child: GestureDetector(
                                      child: SizedBox(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Selected Date: ${DateFormat.yMd().format(selectedDate)}',
                                                style: const TextStyle(fontSize: 18),
                                              ),
                                              const SizedBox(height: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xffC4DFDF),

                                                  foregroundColor: Colors.white, // foreground (text) color
                                                ),
                                                onPressed: () => _selectDate(context),
                                                child: const Text('Select Date'),
                                              ),
                                              Container(
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      const TextSpan(
                                                        text: "Parking Spot Section: ",
                                                        style: TextStyle(color: Colors.blueGrey,),
                                                      ),
                                                      const TextSpan(
                                                        text: 'Selected Time:',
                                                        style: TextStyle(fontSize: 18),
                                                      ),
                                                      TextSpan(
                                                        text: selectedTime.format(context),
                                                        style: const TextStyle(fontSize: 18, color: Colors.orange),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xffC4DFDF),
                                                  // background (button) color
                                                  foregroundColor: Colors.white, // foreground (text) color
                                                ),
                                                onPressed: () => _selectTime(context),
                                                child: const Text('Select Time'),
                                              ),

                                              ElevatedButton(onPressed: (){
                                                print(formattedDate);
                                              }, child: Icon(Icons.add)),


                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(
                                                      0xffC4DFDF),
                                                  // background (button) color
                                                  foregroundColor: Colors
                                                      .white, // foreground (text) color
                                                ),
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context)=>
                                                      ReserveParkingSpot(
                                                        staticCustomerId: widget.staticCustomerId,
                                                        locationId: locationId, dateRev: '2023-11-21 10:50', period: 2,)));
                                                },
                                                child: const Text('Submit Date and Time'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                )),
                          ),
                        // Visibility(
                        //     visible: showFloors,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Container(
                        //           width: double.infinity,
                        //           height: 50,
                        //           alignment: Alignment.centerLeft,
                        //           decoration: const BoxDecoration(
                        //               color: Color.fromRGBO(58, 57, 57, 1)),
                        //           child: GestureDetector(
                        //             onTap: () {
                        //               setState(() {
                        //                 showFloors = false;
                        //                 showSections = false;
                        //                 showLocations = true;
                        //               });
                        //             },
                        //             child: const Text(
                        //               ' |Back to locations',
                        //               style: TextStyle(
                        //                   fontSize: 30,
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.bold),
                        //               textAlign: TextAlign.right,
                        //             ),
                        //           ),
                        //         ),
                        //         Container(
                        //             alignment: Alignment.center,
                        //             color: const Color(0xffC4DFDF),
                        //             height: 50,
                        //             child: Text(
                        //               currentLocation,
                        //               style: const TextStyle(
                        //                   fontSize: 20, fontWeight: FontWeight.bold),
                        //             )),
                        //         Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: SingleChildScrollView(
                        //             child: SizedBox(
                        //               height: MediaQuery.sizeOf(context).height - 350,
                        //               child: filteredLocationFloors.isEmpty
                        //                   ? const Text('No Data')
                        //                   : SizedBox(
                        //                 height: MediaQuery.of(context).size.height - 300,
                        //                 width: MediaQuery.of(context).size.width - 50,
                        //                 child: RefreshIndicator(
                        //                     onRefresh: _refreshLocationFloors,
                        //                     child: ListView.builder(
                        //                         itemCount:
                        //                         filteredLocationFloors.length,
                        //                         itemBuilder: (BuildContext context,
                        //                             int index) {
                        //                           return GestureDetector(
                        //                             onTap: () async {
                        //                               setState(() {
                        //                                 showFloors = false;
                        //                                 showSections = false;
                        //                                 showLocations = false;
                        //                                 showProcessing = true;
                        //                               });
                        //                               currentFlor = filteredLocationFloors[index].floorDescription;
                        //                               filteredFloorSections = [];
                        //                               await getFloorSections(filteredLocationFloors[index].floorId).then((sections) async {
                        //                                 filteredFloorSections = sections;
                        //                                 parkingSpots = [];
                        //
                        //                                 for (int i = 0; i < filteredFloorSections.length; i++) {
                        //                                   await getSectionParkingSpots(
                        //                                       filteredFloorSections[i].sectionId).then((value) {
                        //                                     setState(() {
                        //                                       parkingSpots.addAll(value);
                        //
                        //                                     });
                        //                                   });
                        //                                 }
                        //                                 setState(() {
                        //                                   showProcessing = false;
                        //                                   showSections = true;
                        //                                   showFloors = false;
                        //                                   showLocations = false;
                        //                                 });
                        //                               });
                        //                             },
                        //                             child: Row(
                        //                               children: [
                        //                                 FloorControl(
                        //                                   floorInfo:
                        //                                   locationFloors[index],
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                           );
                        //                         })),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     )),
                        // Visibility(
                        //   visible: showSections,
                        //   child: Container(
                        //     color: const Color(0xffC4DFDF),
                        //     height: MediaQuery
                        //         .sizeOf(context)
                        //         .height - 100,
                        //     child: Column(
                        //
                        //       mainAxisSize: MainAxisSize.max,
                        //       children: [
                        //         Container(
                        //           width: double.infinity,
                        //           height: 50,
                        //           alignment: Alignment.centerLeft,
                        //           decoration: const BoxDecoration(
                        //               color: Color.fromRGBO(58, 57, 57, 1)),
                        //           child: GestureDetector(
                        //             onTap: () {
                        //               setState(() {
                        //                 showFloors = true;
                        //                 showSections = false;
                        //                 showLocations = false;
                        //               });
                        //             },
                        //             child: const Text(
                        //               ' |Back to Floors',
                        //               style: TextStyle(
                        //                   fontSize: 30,
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.bold),
                        //               textAlign: TextAlign.right,
                        //             ),
                        //           ),
                        //         ),
                        //         Container(
                        //             alignment: Alignment.center,
                        //             color: Colors.white,
                        //             height: 50,
                        //             child: Text(
                        //               currentFlor,
                        //               style: const TextStyle(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.bold),
                        //             )),
                        //         Container(
                        //           color: Colors.white,
                        //           width: MediaQuery
                        //               .sizeOf(context)
                        //               .width,
                        //           height: MediaQuery
                        //               .sizeOf(context)
                        //               .height - 310,
                        //           child: RefreshIndicator(
                        //             onRefresh: _refreshLocations,
                        //             child: ListView.builder(
                        //                 itemCount: filteredFloorSections.length,
                        //                 scrollDirection: Axis.vertical,
                        //                 itemBuilder: (BuildContext context,
                        //                     int index) {
                        //                   return GestureDetector(
                        //                     child: SectionControl(
                        //                       staticCustomerId: staticCustomerId,
                        //                       sectionInfo: filteredFloorSections[index],
                        //                       filteredParkingSpots: getSectionSpots(
                        //                           filteredFloorSections[index]
                        //                               .sectionId),
                        //                     ),
                        //                   );
                        //                 }),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // )


                      ],
                    ),
                  ),
                ]),
          )),
      bottomNavigationBar: SizedBox(height: 100,
          child: FluidNavBar(staticCustomerId: widget.staticCustomerId,)),
    );
  }
}


