import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/locations_model.dart';

class FloorControl extends StatefulWidget {
  final FloorModel floorInfo;
  const FloorControl({Key? key, required this.floorInfo}) : super(key: key);


  @override
  State<FloorControl> createState() => _FloorControl();
}

class _FloorControl  extends State<FloorControl> {
  // floor info is not null?
  FloorModel? floorInfo;
  late AnimationController controller;
  @override
  Widget build(BuildContext context) {
    floorInfo = widget.floorInfo;

    return GestureDetector(

      child: Container(child: Column(
        children: [
          const SizedBox(height: 10,),
          Row(children: [
           
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                          width:MediaQuery.of(context).size.width - 180,
                          child: Text(floorInfo!.floorDescription,textAlign: TextAlign.left,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                      SizedBox(
                        width:MediaQuery.of(context).size.width - 180,
                        child: Text("${floorInfo!.floorAvailableSpots > 0? floorInfo!.floorAvailableSpots: 'No spots available'}",textAlign: TextAlign.right,style: TextStyle(color: floorInfo!.floorAvailableSpots == 0? Colors.red:Colors.black,),),),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 150,
                        lineHeight: 14.0,
                        percent: floorInfo!.floorAvailableSpots == 0? 0 :(floorInfo!.floorAvailableSpots/floorInfo!.floorCapacity) ,
                        backgroundColor: Colors.grey,
                        progressColor:floorInfo!.floorAvailableSpots == 0? Colors.grey : (floorInfo!.floorAvailableSpots/floorInfo!.floorCapacity) * 100 >= 50? Colors.lime : (floorInfo!.floorAvailableSpots/floorInfo!.floorCapacity) * 100 >= 25? Colors.orange:Colors.red,
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
