import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/locations_model.dart';

class LocationControl extends StatefulWidget {
 final LocationModel locationInfo;
  const LocationControl({Key? key, required this.locationInfo}) : super(key: key);


  @override
  State<LocationControl> createState() => _LocationControl();
}

class _LocationControl  extends State<LocationControl> {

  LocationModel? locationInfo;
  late AnimationController controller;
  var formatter = NumberFormat('#######');
  @override
  Widget build(BuildContext context) {
    locationInfo = widget.locationInfo;

    return GestureDetector(

      child: Container(child: Column(
        children: [
          const SizedBox(height: 10,),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                width: 70,

                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(

                    locationInfo!.locationLogo,

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                          width:MediaQuery.of(context).size.width - 180,
                          child: Text(locationInfo!.locationName,textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                      Container(
                        width:MediaQuery.of(context).size.width - 180,
                        child: Text(locationInfo!.locationAvailableSpots > 0? formatter.format(locationInfo!.locationAvailableSpots): 'No spots available',textAlign: TextAlign.right,style: TextStyle(color: locationInfo!.locationAvailableSpots == 0? Colors.red:Colors.black,),),),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 150,
                        lineHeight: 14.0,
                        percent: locationInfo!.locationAvailableSpots == 0? 0: (locationInfo!.locationAvailableSpots/locationInfo!.locationCapacity) ,
                        backgroundColor: Colors.grey,
                        progressColor:  (locationInfo!.locationAvailableSpots == 0 || locationInfo!.locationCapacity == 0)? Colors.grey : (locationInfo!.locationAvailableSpots/locationInfo!.locationCapacity) * 100 >= 50? Colors.lime : (locationInfo!.locationAvailableSpots/locationInfo!.locationCapacity) * 100 >= 25? Colors.orange:Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],),
          const SizedBox(height: 10,),
        ],
      ),

    ) ,);
  }

}