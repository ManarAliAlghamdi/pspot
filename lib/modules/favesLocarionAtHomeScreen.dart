import 'package:flutter/material.dart';
import '/models/locations_model.dart';
import '../models/customer_faves_models.dart';
import '../models/shared_methods.dart';
import '../screen/bookYourSpot.dart';

class FavesLocationAtHomeScreen extends StatefulWidget {
  final int staticCustomerId;
  final CustomerFavesLocations favesLocations ;
  const FavesLocationAtHomeScreen({super.key,  required this.staticCustomerId, required this.favesLocations});

  @override
  State<FavesLocationAtHomeScreen> createState() => _FavesLocationAtHomeScreenState();
}

class _FavesLocationAtHomeScreenState extends State<FavesLocationAtHomeScreen> {
  LocationLogo? _location;


  CustomerFavesLocations? favesLocations;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favesLocations = widget.favesLocations;
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
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                BookYourSpot(
                                  title: 'Parking Spots | Locations List',
                                  staticCustomerId: widget.staticCustomerId,
                                  dateOrLocation: 'date',
                                  locationIdFromFaves: favesLocations!.locationId,
                                  locationLogo: favesLocations!.locationLogo,
                                  locationName: favesLocations!.locationName,)
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
                                            favesLocations!.locationLogo),
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
                                            favesLocations!.locationName,
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
                                                  favesLocations!.locationId);
                                            } else if (isFaves == false) {
                                              await customerAddFaves(
                                                  widget.staticCustomerId,
                                                  favesLocations!.locationId);
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
