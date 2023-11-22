//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '/modules/floor_list_control.dart';
//
// import 'models/locations_model.dart';
//
// class saved_places extends StatefulWidget {
//
//   @override
//   State<saved_places> createState() => _saved_placesState();
// }
//
// class _saved_placesState extends State<saved_places> {
//
//   List<LocationParkingSpotModelOnServer> floorsList = [
//  //    LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 1,sectionName: 'section_1',parkingSpotId: 1,parkingSpotDescription: 'spot_1',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 1,sectionName: 'section_1',parkingSpotId: 2,parkingSpotDescription: 'spot_2',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 2,sectionName: 'section_2',parkingSpotId: 3,parkingSpotDescription: 'spot_3',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 2,sectionName: 'section_2',parkingSpotId: 4,parkingSpotDescription: 'spot_4',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 2,floorName: 'floor2',sectionId: 3,sectionName: 'section_3',parkingSpotId: 5,parkingSpotDescription: 'spot_5',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 2,floorName: 'floor2',sectionId: 3,sectionName: 'section_3',parkingSpotId: 6,parkingSpotDescription: 'spot_6',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 2,sectionName: 'section_2',parkingSpotId: 7,parkingSpotDescription: 'spot_7',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 2,sectionName: 'section_2',parkingSpotId: 8,parkingSpotDescription: 'spot_8',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 1,sectionName: 'section_1',parkingSpotId: 9,parkingSpotDescription: 'spot_9',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 1,sectionName: 'section_1',parkingSpotId: 10,parkingSpotDescription: 'spot_10',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  // LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 2,sectionName: 'section_2',parkingSpotId: 11,parkingSpotDescription: 'spot_7',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 2,sectionName: 'section_2',parkingSpotId: 12,parkingSpotDescription: 'spot_8',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //       LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 1,sectionName: 'section_1',parkingSpotId: 13,parkingSpotDescription: 'spot_9',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 1,floorName: 'floor1',sectionId: 1,sectionName: 'section_1',parkingSpotId: 14,parkingSpotDescription: 'spot_10',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //       LocationParkingSpotModelOnServer(floorId: 2,floorName: 'floor1',sectionId: 3,sectionName: 'section_1',parkingSpotId: 15,parkingSpotDescription: 'spot_9',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//  //    LocationParkingSpotModelOnServer(floorId: 2,floorName: 'floor1',sectionId: 3,sectionName: 'section_1',parkingSpotId: 16,parkingSpotDescription: 'spot_10',parkingSpotStatus: true,parkingSpotSectionNo: 1,parkingSpotDirection: 'right',isSNSpot: 'yes',isSelected: false),
//
//   ];
//   int rowsCount= 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//
//
//     return  Scaffold(
//       body: SingleChildScrollView(child:
//       Container(
//           decoration: const BoxDecoration(color: Colors.yellow),
//           height: MediaQuery.of(context).size.height ,
//           child: Floor_List_Control(floorsList: floorsList,))),
//     );
//   }
//
//
//
// }