import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/modules/spots_list_control.dart';

import '../models/locations_model.dart';

class Section_List_Control extends StatefulWidget {
  List<LocationParkingSpotModelOnServer> sectionsList;
  Section_List_Control({super.key, required this.sectionsList});

  @override
  State<Section_List_Control> createState() => _Section_List_ControlState();
}

class _Section_List_ControlState extends State<Section_List_Control> {
  late List<LocationParkingSpotModelOnServer> _sectionsList;
  late List<LocationParkingSpotModelOnServer> finalSectionsList;
  int rowsCount = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
    _sectionsList = widget.sectionsList;
    var seen = Set<String>();
    finalSectionsList = _sectionsList.where((LocationParkingSpotModel) => seen.add(LocationParkingSpotModel.sectionId.toString())).toList();
    List<LocationParkingSpotModelOnServer> totalSpotsCount = _sectionsList.where((LocationParkingSpotModelOnServer) => seen.add(LocationParkingSpotModelOnServer.parkingSpotId.toString())).toList();
rowsCount = finalSectionsList.length + totalSpotsCount.length;
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(color: Colors.blueGrey),
        height: rowsCount  * 30,
          child: ListView.builder(
            itemCount: finalSectionsList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(finalSectionsList[index].sectionName),
                  Spot_List_Control(spotsList: _sectionsList.where((i) => i.sectionId == finalSectionsList[index].sectionId).toList())
                ],
              );
            },
          )),
    );
  }
}
