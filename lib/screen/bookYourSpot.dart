
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/locations_model.dart';
import '../models/shared_methods.dart';
import '../modules/floor_control.dart';
import '../modules/fluid_nav_bar.dart';
import '../modules/loaction_control.dart';
import '../modules/sectionsControl.dart';

class BookYourSpot extends StatefulWidget {
  const BookYourSpot({super.key, required this.title});

  final String title;

  @override
  State<BookYourSpot> createState() => _BookYourSpotState();
}

class _BookYourSpotState extends State<BookYourSpot> {
  int _counter = 0;
  TextEditingController searchTextField = TextEditingController();
  List<LocationModel> locationsList = [];
  List<LocationModel> filteredLocationsList = [];
  List<FloorModel> locationFloors = [];
  List<FloorModel> filteredLocationFloors = [];
  List<SectionModel> floorSections = [];
  List<SectionModel> filteredFloorSections = [];
  List<ParkingSpotModel> parkingSpots = [];
  List<ParkingSpotModel> filteredParkingSpots = [];
  int currentLocationNo = -1;
  String currentLocation = "";
  String currentFlor = "";
  bool showLocations = false;
  bool showFloors = false;
  bool showSections = false;
  bool showProcessing = true;
  void initLocations() async {
    locationsList = [];
    await getLocations().then((value) {
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

    initLocations();
  }

  Future<void> _refreshLocationFloors() async {
    showLocationFloors(currentLocationNo);
  }

  Future<void> _refreshLocations() async {
    setState(() {
      showLocations = false;
      showFloors = false;
      showSections = false;
      showProcessing = true;
    });
    await getLocations().then((value) {
      setState(() {
        locationsList = value;
        showProcessing = false;
        showLocations = true;
      });
      filteredLocationsList = locationsList;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<ParkingSpotModel> getSectionSpots(int sectionNo) {
    filteredParkingSpots =
        parkingSpots.where((i) => i.parkingSpotSectionNo == sectionNo).toList();
    return filteredParkingSpots;
  }

  void filterLocationList() {
    setState(() {
      filteredLocationsList = locationsList
          .where((i) => i.locationName
          .toLowerCase()
          .contains(searchTextField.text.toLowerCase()))
          .toList();
    });
  }

  void showLocationFloors(int locationNo) async {
    setState(() {
      showLocations = false;
      showFloors = false;
      showProcessing = true;
    });
    filteredLocationFloors = [];
    await getLocationFloors(locationNo).then((value) {
      setState(() {
        filteredLocationFloors = value;
        showLocations = false;
        showSections = false;
        showProcessing = false;
        showFloors = true;
      });
    });
  }

  void filterFloorsList(int locationNo) {
    setState(() {
      filteredLocationFloors =
          locationFloors.where((i) => i.floorLocationNo == locationNo).toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
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
                      height: MediaQuery.of(context).size.height - 300,
                      width: MediaQuery.of(context).size.width - 50,
                      child: RefreshIndicator(
                          onRefresh: _refreshLocations,
                          child: ListView.builder(
                              itemCount: filteredLocationsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    currentLocation =
                                        filteredLocationsList[index]
                                            .locationName;
                                    currentLocationNo =
                                        filteredLocationsList[index].locationId;
                                    showLocationFloors(
                                        filteredLocationsList[index]
                                            .locationId);
                                  },
                                  child: Row(
                                    children: [
                                      LocationControl(
                                        locationInfo:
                                        filteredLocationsList[index],
                                      ),
                                    ],
                                  ),
                                );
                              })),
                    ),
                  ],
                ),
              ),
              //Floors
              Visibility(
                  visible: showFloors,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                              showFloors = false;
                              showSections = false;
                              showLocations = true;
                            });
                          },
                          child: Text(
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
                          color: Color(0xffC4DFDF),
                          height: 50,
                          child: Text(
                            currentLocation,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.sizeOf(context).height - 350,
                            child: filteredLocationFloors.length == 0
                                ? Text('No Data')
                                : Container(
                              height: MediaQuery.of(context).size.height -
                                  300,
                              width:
                              MediaQuery.of(context).size.width - 50,
                              child: RefreshIndicator(
                                  onRefresh: _refreshLocationFloors,
                                  child: ListView.builder(
                                      itemCount:
                                      filteredLocationFloors.length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              showFloors = false;
                                              showSections = false;
                                              showLocations = false;
                                              showProcessing = true;
                                            });
                                            currentFlor =
                                                filteredLocationFloors[
                                                index]
                                                    .floorDescription;
                                            filteredFloorSections = [];
                                            await getFloorSections(
                                                filteredLocationFloors[
                                                index]
                                                    .floorId)
                                                .then((sections) async {
                                              filteredFloorSections =
                                                  sections;
                                              parkingSpots = [];
                                              for (int i = 0;
                                              i <
                                                  filteredFloorSections
                                                      .length;
                                              i++) {
                                                await getSectionParkingSpots(
                                                    filteredFloorSections[
                                                    i]
                                                        .sectionId)
                                                    .then((value) {
                                                  setState(() {
                                                    parkingSpots
                                                        .addAll(value);
                                                  });
                                                });
                                              }
                                              setState(() {
                                                showProcessing = false;
                                                showSections = true;
                                                showFloors = false;
                                                showLocations = false;
                                              });
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              FloorControl(
                                                floorInfo:
                                                filteredLocationFloors[
                                                index],
                                              ),
                                            ],
                                          ),
                                        );
                                      })),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Visibility(
                visible: showSections,
                child: Container(
                  color: Color(0xffC4DFDF),
                  height: MediaQuery.sizeOf(context).height-100,
                  child: Column(

                    mainAxisSize: MainAxisSize.max ,
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
                              showFloors = true;
                              showSections = false;
                              showLocations = false;
                            });
                          },
                          child: const Text(
                            ' |Back to Floors',
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
                          color: Colors.white,
                          height: 50,
                          child: Text(
                            currentFlor,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height - 310,
                        child: RefreshIndicator(
                          onRefresh: _refreshLocations,
                          child: ListView.builder(
                              itemCount: filteredFloorSections.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  child: SectionControl(
                                    sectionInfo: filteredFloorSections[index],
                                    filteredParkingSpots: getSectionSpots(
                                        filteredFloorSections[index].sectionId),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(height: 100, child: FluidNavBar()),
    );
  }
}
