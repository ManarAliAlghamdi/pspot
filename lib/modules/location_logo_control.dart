import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pspot_test/models/locations_model.dart';

import '../models/customer_faves_models.dart';
import '../models/shared_methods.dart';
import '../screen/bookYourSpot.dart';

class LocationsLogoControl extends StatefulWidget {
  final int theIndex;
  final int staticCustomerId;
  final bool showLoading;
  final bool stopLoading;
   LocationsLogoControl({super.key,  required this.staticCustomerId, required this.theIndex, required this.showLoading, required this.stopLoading});

  @override
  State<LocationsLogoControl> createState() => _LocationsLogoControlState();
}

class _LocationsLogoControlState extends State<LocationsLogoControl> {
  LocationLogo? _location; //=  LocationModel(locationId: 0, locationName: '', locationOnMap: '', locationLogo: '', locationCapacity: 0, locationAvailableSpots: 0, favesLocation: 0);


  List<CustomerFavesLocations> favesLocations = [];
  List<CustomerFavesLocations> filteredFavesLocations = [];
  bool isFaves = true;
  bool showFavesLocations = false;
  bool showProcessing = true;
  TextEditingController searchTextField = TextEditingController();

  Future<void> customerAddFaves(int customerId, int parkingSpotId) async {
    await addLocationIntoFaves(customerId, parkingSpotId).then((value) {
      setState(() {
        isFaves = true;
      });
    });
  }


  Future<void> customerRemoveFaves(int customerId, int parkingSpotId) async {
    await removeLocationFromFaves(customerId, parkingSpotId).then((value) {
      setState(() {
        isFaves = false;
      });
    });
  }

  void initFavesLocations(customerNo) async {
    favesLocations = [];

    await getCustomerFavesLocations(customerNo).then((value) {
      setState(() {
        favesLocations = value;

      });

      filteredFavesLocations = favesLocations;
    });
  }



  // filled up the filtered list according to user search
  void filterCustomerLocations() {
    setState(() {
      filteredFavesLocations = favesLocations.where(
              (i) =>
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
    return
      // Column(
      //   children: [
      //     Visibility(
      //         visible: widget.showLoading,
      //         child: Center(
      //           child: Image.asset('assets/images/processing.gif'),
      //         )),
      //     Visibility(
      //       visible: widget.stopLoading,
      //       child:
            GestureDetector(
              onTap: () {

              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                BookYourSpot(
                                  title: 'Parking Spots | Locations List',
                                  staticCustomerId: widget.staticCustomerId,
                                  dateOrLocation: 'date',
                                  locationIdFromFaves: filteredFavesLocations[widget
                                      .theIndex].locationId,
                                  locationLogo: filteredFavesLocations[widget
                                      .theIndex].locationLogo,
                                  locationName: filteredFavesLocations[widget
                                      .theIndex].locationName,)
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 50,
                                      width: 56,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Image.asset(
                                            filteredFavesLocations[widget
                                                .theIndex]
                                                .locationLogo),
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
                                            filteredFavesLocations[widget.theIndex].locationName,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: IconButton(
                                          onPressed: () async {
                                            if (isFaves) {
                                              await customerRemoveFaves(
                                                  widget.staticCustomerId,
                                                  filteredFavesLocations[widget
                                                      .theIndex].locationId);
                                            } else if (isFaves == false) {
                                              await customerAddFaves(
                                                  widget.staticCustomerId,
                                                  filteredFavesLocations[widget
                                                      .theIndex].locationId);
                                            }
                                          },
                                          icon: isFaves ? const Icon(
                                            Icons.favorite,
                                            color: Colors.orange,) :
                                          const Icon(Icons.favorite_border)),
                                    ),
                                  ],
                                ),
                              ])),

                    ),
                  ]
              ),
        //   ),
        // ]
    );
  }
}
