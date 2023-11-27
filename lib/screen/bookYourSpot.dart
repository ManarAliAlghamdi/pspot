
import 'package:flutter/material.dart';
import '../models/locations_model.dart';
import '../models/shared_methods.dart';
import '../modules/floor_control.dart';
import '../modules/fluid_nav_bar.dart';
import '../modules/loaction_control.dart';
import '../modules/sectionsControl.dart';
import 'package:intl/intl.dart';
import 'reserveParkingSpot.dart';


class BookYourSpot extends StatefulWidget {
  final int staticCustomerId;
  final String dateOrLocation;
  final int locationIdFromFaves;
  final String locationLogo;
  final String locationName;
  const BookYourSpot({super.key, required this.title,  required this.staticCustomerId, required this.dateOrLocation, required this.locationIdFromFaves, required this.locationLogo, required this.locationName});


  final String title;

  @override
  State<BookYourSpot> createState() => _BookYourSpotState();
}

class _BookYourSpotState extends State<BookYourSpot> {
  int locationId = 0;
  int staticCustomerId = 0;
  int counter = 1;
  TextEditingController searchTextField = TextEditingController();
  List<LocationModel> locationsList = [];
  List<LocationModel> filteredLocationsList = [];
  int ticketIndex = 0;

  int currentLocationNo = -1;
  String currentLocation = "";
  bool showLocations = false;
  bool showTimeDatePicker = false;
  bool showProcessing = true;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String formattedDate = '';
  String locationLogo = '';

  DateTime selectedDateTime = DateTime.now();
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xffC4DFDF), // Set the picker color
            colorScheme: const ColorScheme.light(primary: Color(0xffC4DFDF)),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDateTime) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color(0xffC4DFDF),
              colorScheme: const ColorScheme.light(primary: Color(0xffC4DFDF)),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }


  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd  HH:mm').format(dateTime);  }

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
    if (widget.dateOrLocation == 'date'){
      setState(() {
        locationId = widget.locationIdFromFaves;
        locationLogo = widget.locationLogo;
        currentLocation = widget.locationName;
        showProcessing = false;
        showLocations = false;
        showTimeDatePicker = true;
      });
    }else{
      initLocations(widget.staticCustomerId);
    }
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


  @override
  Widget build(BuildContext context) {


    staticCustomerId = widget.staticCustomerId;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "The Locations", style: TextStyle(color: Colors.white),),
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
                                        showLocations = false;
                                        showTimeDatePicker = true;
                                        locationId = filteredLocationsList[index].locationId;
                                        currentLocation = filteredLocationsList[index].locationName;
                                        locationLogo = filteredLocationsList[index].locationLogo;
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
                  //Floors
                  Center(
                    child: Visibility(
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
                                  color: Colors.white,
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SingleChildScrollView(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'Selected Date And Time:',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '${_formatDateTime(selectedDateTime)}',
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),

                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xffC4DFDF),

                                          ),
                                          onPressed: () => _selectDateTime(context),
                                          child: const Text('Select Date And Time', style: TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          const Padding(
                                              padding: EdgeInsets.only(top: 20, ),
                                              child: Text("How Long Do Need Your Spot?", style: TextStyle(
                                                fontSize: 20
                                              ),)),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 42),
                                                child: IconButton(onPressed: (){
                                                  setState(() {
                                                    counter++;
                                                  });
                                                }, icon: const Icon(Icons.add)),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.only(left: 50, right: 10),
                                              child: Text("$counter Hours", style: const TextStyle(fontSize: 30),)),

                                              Padding(
                                                padding: const EdgeInsets.only(left: 45, bottom: 10),
                                                child: IconButton(onPressed: (){
                                                  setState(() {
                                                    counter--;
                                                  });
                                                }, icon: const Icon(Icons.minimize)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xffC4DFDF),
                                          // background (button) color
                                          foregroundColor: Colors
                                              .white, // foreground (text) color
                                        ),
                                        onPressed: () {
                                          print(_formatDateTime(selectedDateTime));
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) =>
                                                  ReserveParkingSpot(
                                                    staticCustomerId: widget.staticCustomerId,
                                                    locationId: locationId,
                                                    dateRev: _formatDateTime(selectedDateTime) ,
                                                    period: counter, locationName: currentLocation,
                                                    locationLogo: locationLogo,)));
                                        },
                                        child: const Text('Choose Your Spot'),
                                      ),
                                    ],
                                  ),
                                ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          )),
      bottomNavigationBar: SizedBox(height: 70,
          child: FluidNavBar(staticCustomerId: widget.staticCustomerId,)),
    );
  }
}


