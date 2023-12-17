import 'package:flutter/material.dart';
import '/screen/reservation_date_time.dart';
import '/models/shared_methods.dart';
import '../models/customer_faves_models.dart';
import '../modules/fluid_nav_bar.dart';
import 'HomePage.dart';


class SavedSpot extends StatefulWidget {
  final int staticCustomerId;
  const SavedSpot ({Key? key, required this.staticCustomerId}) : super(key: key);
  @override
  _SavedSpotState createState() => _SavedSpotState();
}

class _SavedSpotState extends State<SavedSpot> {
  bool showFavesLocations = false;
  bool showProcessing = true;
  bool showEmpty = false;
  bool isFaves = true;
  List<CustomerFavesLocations> favesLocations = [];
  List<CustomerFavesLocations> filteredFavesLocations = [];
  TextEditingController searchTextField = TextEditingController();


  Future<void> customerRemoveFaves(int customerId, int locationId) async {
    await removeLocationFromFaves(customerId, locationId).then((value) {
      setState(() {
        _refreshFavesLocations();
      });
    });
  }

  void initFavesLocations(customerNo) async {
    favesLocations = [];
    await getCustomerFavesLocations(customerNo).then((value) {
      if(value.isEmpty){
        showFavesLocations = false;
        showProcessing = false;
        showEmpty = true;
      }else {
        setState(() {
          showFavesLocations = true;
          showProcessing = false;
          favesLocations = value;
        });
      }
      filteredFavesLocations = favesLocations;
    });
  }


  Future<void> _refreshFavesLocations() async {
    setState(() {
      showFavesLocations = false;
      showProcessing = true;
    });
    await getCustomerFavesLocations(widget.staticCustomerId).then((value) {
      setState(() {
        showFavesLocations = true;
        showProcessing = false;
        favesLocations = value;
      });
      filteredFavesLocations = favesLocations;
    });
  }

  // filled up the filtered list according to user search
  void filterCustomerLocations() {
    setState(() {
      filteredFavesLocations = favesLocations.where((i) =>
          i.locationName.toLowerCase().contains(
              searchTextField.text.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFavesLocations(widget.staticCustomerId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Padding(
          padding: EdgeInsets.only(left: 30),
          child: const Text(
            "Favorite Locations", style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: const Color(0xffC4DFDF),
        leading: IconButton(onPressed: () {},
          icon: Icon(Icons.add, size: 0, color: Color(0xffC4DFDF,)),),
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
                  Visibility(
                    visible: showFavesLocations,
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
                                filterCustomerLocations();
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
                              onRefresh: _refreshFavesLocations,
                              child: ListView.builder(
                                  itemCount: filteredFavesLocations.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) =>
                                                ReservationDateTime(
                                                  staticCustomerId: widget
                                                      .staticCustomerId,
                                                  locationId: filteredFavesLocations[index]
                                                      .locationId,
                                                  locationLogo: filteredFavesLocations[index]
                                                      .locationLogo,
                                                  locationName: filteredFavesLocations[index]
                                                      .locationName,)
                                        )
                                        );
                                      },
                                      child: Container(
                                          child: Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: SizedBox(
                                                        height: 50,
                                                        width: 56,
                                                        child: FittedBox(
                                                          fit: BoxFit.fill,
                                                          child: Image.asset(
                                                              filteredFavesLocations[index]
                                                                  .locationLogo),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(5.0),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width - 180,
                                                            child: Text(
                                                              filteredFavesLocations[index]
                                                                  .locationName,
                                                              textAlign: TextAlign
                                                                  .left,
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(),
                                                      child: IconButton(
                                                          onPressed: () async {
                                                            await customerRemoveFaves(
                                                                widget
                                                                    .staticCustomerId,
                                                                filteredFavesLocations[index]
                                                                    .locationId);
                                                          },
                                                          icon: Icon(
                                                            Icons.favorite,
                                                            color: Colors
                                                                .orange,)
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ])),
                                    );
                                  }),
                            ),
                          ),
                        ]
                    ),
                  ),
                ]),
          )
      ),
      // bottomNavigationBar: SizedBox(height: 70,
      //     child: FluidNavBar(staticCustomerId: widget.staticCustomerId,)),
    );
  }

}