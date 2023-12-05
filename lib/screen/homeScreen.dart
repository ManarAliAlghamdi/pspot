import 'package:flutter/material.dart';
import '/modules/favesLocarionAtHomeScreen.dart';
import '/screen/bookYourSpot.dart';
import '../models/customer_faves_models.dart';
import '../models/locations_model.dart';
import '../models/shared_methods.dart';
import '../modules/fluid_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  final int staticCustomerId;
  const HomeScreen({Key? key, required this.staticCustomerId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<LocationLogo> locationLogoList = [];
  List<CustomerFavesLocations> favesLocations = [];

  List<LocationModel> locationsList = [];
  bool showProcessing = true;
  bool showHome = false;

  bool showLoading = true;
  bool stopLoading = false;
  List<String> test= ['assets/images/blvd.png','assets/images/blvd.png','assets/images/blvd.png'];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initFavesLocations(widget.staticCustomerId);
    getLocationSLogo();
  }


  Future<void> initFavesLocations() async {
    favesLocations = [];

    await getCustomerFavesLocations(widget.staticCustomerId ).then((value) {
      setState(() {
        favesLocations = value;
      });
    });
  }


  void getLocationSLogo() async {
    await getLocationLogo().then((value) async {
      locationLogoList = value;
      await initFavesLocations().then((value)  {
        setState(() {

          showProcessing = false;
          showHome = true;
        });
      });

    });
  }

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
                                    itemCount: locationLogoList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context, MaterialPageRoute(
                                              builder: (context) =>
                                                  BookYourSpot(title: 'title',
                                                      staticCustomerId: widget.staticCustomerId,
                                                      dateOrLocation: 'date',
                                                      locationIdFromFaves: locationLogoList[index].locationId,
                                                      locationLogo: locationLogoList[index].locationLogo,
                                                      locationName: locationLogoList[index].locationName
                                                  ),
                                            )
                                            );
                                          },
                                          child:Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: 100,
                                              child: Image.asset(locationLogoList[index].locationLogo),

                                            ),
                                          ));
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                  child: Text('My Favorite Locations',
                                    style: TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.bold),),
                                ),
                                Container(
                                  height: 250,
                                  child: Stack(
                                    children: [
                                      Visibility(child: Container(


                                      )),
                                      Visibility(
                                        child: ListView.builder(
                                        itemCount: favesLocations.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return FavesLocationAtHomeScreen(staticCustomerId: widget.staticCustomerId, favesLocations: favesLocations[index], );
                                        },
                                                                            ),
                                      )],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]))),
      bottomNavigationBar: SizedBox(height: 70,
          child: FluidNavBar(staticCustomerId: widget.staticCustomerId,)),

    );
  }
}