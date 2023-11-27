import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pspot_test/modules/sections_list_control.dart';

import '../models/locations_model.dart';

class Floor_List_Control extends StatefulWidget {
  List<LocationParkingSpotModelOnServer> floorsList;
   Floor_List_Control({super.key, required this.floorsList});

  @override
  State<Floor_List_Control> createState() => _Floor_List_ControlState();

}

class _Floor_List_ControlState extends State<Floor_List_Control> {
  List<LocationParkingSpotModelOnServer> _floorsList = [];
  List<LocationParkingSpotModelOnServer> finalFloorsList = [];
  int rowsCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _floorsList = widget.floorsList;
    var seen = Set<String>();
    finalFloorsList = _floorsList.where((LocationParkingSpotModelOnServer) =>
        seen.add(LocationParkingSpotModelOnServer.floorId.toString())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: const BoxDecoration(color: Colors.indigo),
        height: rowsCount * 30,
        child:
        ListView.builder(
          itemCount: finalFloorsList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
                child: Row(
                  children: [
                    RichText(text: TextSpan(children: [
                      TextSpan(text: "_floorsList[index].floorName")
                    ]))
                  ],
                ));
            //   Column(
            //   children: [
            //     Text(finalFloorsList[index].floorName),
            //     Section_List_Control(sectionsList: _floorsList.where((i) => i.floorId == finalFloorsList[index].floorId).toList())
            //   ],
            // );
          },
        )
    );
  }
}
