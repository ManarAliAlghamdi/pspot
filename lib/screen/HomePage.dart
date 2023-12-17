
import 'package:flutter/material.dart';
import '/screen/reservation_date_time.dart';
import '../models/locations_model.dart';
import '../models/shared_methods.dart';
import '../modules/loaction_control.dart';
import 'package:intl/intl.dart';
import 'reserveParkingSpot.dart';


class HomePage extends StatefulWidget {
  final int staticCustomerId;
  final int locationId;
  final String locationLogo;
  final String locationName;
  const HomePage({super.key,  required this.staticCustomerId, required this.locationLogo, required this.locationName, required this.locationId});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int locationId = 0;
  int staticCustomerId = 0;
  int counter = 1;
  TextEditingController searchTextField = TextEditingController();
  List<LocationModel> locationsList = [];
  List<LocationModel> filteredLocationsList = [];

  int currentLocationNo = -1;
  String currentLocation = "";

  bool showLocations = false;
  bool showProcessing = true;

  String locationLogo = '';





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
      });
      filteredLocationsList = locationsList;
    });
  }


  void filterLocationList() {
    setState(() {
      filteredLocationsList = locationsList.where((i) => i.locationName.toLowerCase().contains(searchTextField.text.toLowerCase())).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    staticCustomerId = widget.staticCustomerId;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {  }, icon: Icon(Icons.add, color: Color(0xffC4DFDF,)),),

        title:  const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            "The Locations", style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: const Color(0xffC4DFDF),

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
                      )
                  ),

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
                                        locationId = filteredLocationsList[index].locationId;
                                        currentLocation = filteredLocationsList[index].locationName;
                                        locationLogo = filteredLocationsList[index].locationLogo;
                                        Navigator.pushReplacement(
                                            context, MaterialPageRoute(
                                            builder: (context) =>
                                                ReservationDateTime(
                                                    staticCustomerId: staticCustomerId,
                                                    locationLogo: locationLogo,
                                                    locationName: currentLocation,
                                                    locationId: locationId)
                                        ));
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        LocationControl(
                                          locationInfo: filteredLocationsList[index], staticCustomerId: widget.staticCustomerId,
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
                ]),
          )),
    );
  }
}


