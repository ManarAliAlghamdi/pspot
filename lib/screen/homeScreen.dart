import 'package:flutter/material.dart';
import '/modules/location_logo_control.dart';
import '../models/locations_model.dart';
import '../models/shared_methods.dart';
import '../modules/fluid_nav_bar.dart';
import '../modules/loaction_control.dart';

class HomeScreen extends StatefulWidget {
  final int staticCustomerId;
  const HomeScreen({Key? key, required this.staticCustomerId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LocationParkingSpotModelOnServer> floorsList = [
  //   LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 1,sectionName: 'section_1',parkingSpotId: 1,parkingSpotDescription: 'spot_1',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
  //   LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 1,sectionName: 'section_1',parkingSpotId: 2,parkingSpotDescription: 'spot_2',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
  //   LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 2,sectionName: 'section_1',parkingSpotId: 3,parkingSpotDescription: 'spot_3',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
  //   LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 2,sectionName: 'section_1',parkingSpotId: 4,parkingSpotDescription: 'spot_4',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
  //   LocationParkingSpotModelOnServer(floorId: 2,floorName: 'floor2',sectionId: 3,sectionName: 'section_3',parkingSpotId: 5,parkingSpotDescription: 'spot_5',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
  //   LocationParkingSpotModelOnServer(floorId: 2,floorName: 'floor2',sectionId: 3,sectionName: 'section_3',parkingSpotId: 6,parkingSpotDescription: 'spot_6',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
   ];

  List<LocationModel> locationsList = [];
  bool showProcessing = true;
  bool showHome = false;
  List<String> test= ['assets/images/blvd.png','assets/images/blvd.png','assets/images/blvd.png'];
  // List<LocationModel> filteredLocationsList = [];
  void initLocations(int customerId) async {
    locationsList = [];
    setState(() {
      showProcessing = true;
      showHome = false;
    });
    await getLocations(customerId).then((value) {

      setState(() {
        locationsList = value;
        showProcessing = false;
        showHome = true;
      });
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
      showHome = false;
      showProcessing = true;
    });
    await getLocations(widget.staticCustomerId).then((value) {
      setState(() {
        locationsList = value;
        showProcessing = false;
        showHome = true;
      });
    });
  }

  // List<String> getLocationsLogo(){
  //   List<String> locationsLogo= [];
  //   for (int x = 1; x > locationsList.length; x++){
  //
  //   }
  //   return locationsLogo;
  //
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffdfa),
      body: SingleChildScrollView(
          child: SizedBox(
              height: MediaQuery
                  .sizeOf(context)
                  .height + 230,
              child: Column(
                  children: [
                    Visibility(
                        visible: showProcessing,
                        child: Center(
                          child: Image.asset('assets/images/processing.gif'),
                        )),
                    // Locations
                    Visibility(
                      visible: showHome,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 236, 235, 235),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.black87,),
                                          hintText: "Search your saved place",
                                          hintStyle: TextStyle(
                                              color: Colors.grey, fontSize: 15)
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 25,
                                  child:
                                  Text('Famous Places',
                                    style: TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.bold),),
                                ),
                                Container(
                                  height: 150,
                                  child: ListView.builder(
                                    itemCount: locationsList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Locatioin_Logo_Control(location: locationsList[index]
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                  child: Text('My Saved Places',
                                    style: TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.bold),),
                                ),
                                Center(
                                  child:
                                  Container(
                                    height: 250,
                                    child: ListView.builder(
                                      itemCount: locationsList.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Locatioin_Logo_Control(location: locationsList[index]
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                  child: Text('Spots List',
                                    style: TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.bold),),
                                ),
                                Center(
                                  child:
                                  SingleChildScrollView(
                                    child: SizedBox(
                                      height: 250,
                                      child:
                                     SingleChildScrollView(
                                          // child: Floor_List_Control(floorsList: floorsList,)
                                     ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]))),
      bottomNavigationBar: SizedBox(height: 60,
          child: FluidNavBar(staticCustomerId: widget.staticCustomerId,)),

    );
  }


  Widget famousPlaces(Image, {required int ImageSize}) {
    return AspectRatio(aspectRatio: 2.55 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(Image)
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                stops: const [0.1, 0.9],
                colors: [
                  Colors.black.withOpacity(.0),
                  Colors.black.withOpacity(.0)
                ]
            ),
          ),
        ),
      ),
    );
  }
}