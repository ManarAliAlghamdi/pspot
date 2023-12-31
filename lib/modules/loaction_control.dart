import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/locations_model.dart';
import '../models/shared_methods.dart';

class LocationControl extends StatefulWidget {
 final LocationModel locationInfo;
 final int staticCustomerId;
  const LocationControl({Key? key, required this.locationInfo, required this.staticCustomerId}) : super(key: key);


  @override
  State<LocationControl> createState() => _LocationControl();
}

class _LocationControl  extends State<LocationControl> {

  LocationModel? locationInfo;
  // late AnimationController controller;
  var formatter = NumberFormat('#######');
  bool isFaves = false;
  int staticCustomerId = 0;
  int locationId = 0;
  Future<void> customerAddFaves(int customerId, int locationId)async{
    await addLocationIntoFaves(customerId, locationId).then((value){
      setState(() {
        isFaves = true;
      });
    });
  }

  Future<void> customerRemoveFaves(int customerId, int locationId)async{
    await removeLocationFromFaves(customerId, locationId).then((value){
      setState(() {
        isFaves = false;
      });
    });
  }


  Widget build(BuildContext context) {
    locationInfo = widget.locationInfo;
    staticCustomerId = widget.staticCustomerId;
    locationId = locationInfo!.locationId;
    if (locationInfo!.favesLocation != 0){
      setState(() {
        isFaves = true;
      });
    }
    return GestureDetector(
      child:  Container(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: 56,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(locationInfo!.locationLogo,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 180,
                        child: Text(
                          locationInfo!.locationName,
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
                      if (isFaves){
                        print(" faves = true $staticCustomerId $locationId");
                        await customerRemoveFaves(widget.staticCustomerId, locationId);
                      }else if (isFaves == false){
                        print(" faves = false $staticCustomerId $locationId");
                        await customerAddFaves(widget.staticCustomerId, locationId);
                      }
                    },
                    icon: isFaves? const Icon(Icons.favorite, color: Colors.orange,):
                    const Icon(Icons.favorite_border)),
              ),
          ],),
          const SizedBox(height: 10,),
        ],
      ),

    ) ,);
  }

}