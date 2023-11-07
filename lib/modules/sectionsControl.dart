import 'package:flutter/material.dart';

import '../models/locations_model.dart';
import '../screen/payment_page.dart';

class SectionControl extends StatefulWidget {
  final SectionModel sectionInfo;
  final List<ParkingSpotModel> filteredParkingSpots ;
  final int staticCustomerId;
  const SectionControl({Key? key, required this.sectionInfo, required this.filteredParkingSpots,  required this.staticCustomerId}) : super(key: key);


  @override
  State<SectionControl> createState() => _SectionControl();
}

class _SectionControl  extends State<SectionControl> {
  int staticCustomerId = 0;
  SectionModel? sectionInfo;
  List<ParkingSpotModel> parkingSpots = [];
  late AnimationController controller;
  List<ParkingSpotModel> rightParkings = [];
  List<ParkingSpotModel> leftParkings = [];

  Future<void> _refreshLocations() async {}

  @override
  Widget build(BuildContext context) {
    staticCustomerId = widget.staticCustomerId;
    sectionInfo = widget.sectionInfo;
    parkingSpots = widget.filteredParkingSpots;
    rightParkings = parkingSpots
        .where((i) =>
    i.parkingSpotDirection
        .toLowerCase() == 'right')
        .toList();
    leftParkings = parkingSpots
        .where((i) =>
    i.parkingSpotDirection
        .toLowerCase() == 'left')
        .toList();

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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 180,
                          child: Text('Section: ${sectionInfo!
                              .sectionDescription}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        SizedBox( // East and West parkings
                          height: MediaQuery
                              .of(context)
                              .size
                              .height - 300,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 50,
                          child: Row(children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(width: 150, color: Colors.white,
                                child: RefreshIndicator(
                                  onRefresh: _refreshLocations,
                                  child: ListView.builder(
                                      itemCount: leftParkings.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return GestureDetector(
                                          child: Transform(
                                            alignment: FractionalOffset.center,
                                            transform: Matrix4.rotationZ(
                                              3.1415926535897932 / 4,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  10.0),
                                              child: Stack(
                                                  children: [
                                                    SizedBox(
                                                        height: 100,
                                                        child: FittedBox(
                                                            fit: BoxFit.fill,
                                                            child: leftParkings[index]
                                                                .parkingSpotStatus ==
                                                                true
                                                                ? Image.asset(
                                                                'assets/images/reservedParking.png')
                                                                :
                                                            Image.asset(
                                                                'assets/images/emptyParking.png'))
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(20.0),
                                                      child: Text(
                                                        leftParkings[index]
                                                            .parkingSpotDescription,
                                                        style: const TextStyle(
                                                            fontSize: 30),),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container(
                              color: const Color.fromRGBO(75, 75, 75, 1),)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(width: 150, color: Colors.white,
                                child: RefreshIndicator(
                                  onRefresh: _refreshLocations,
                                  child: ListView.builder(
                                      itemCount: rightParkings.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return GestureDetector(
                                          child: Transform(
                                            alignment: FractionalOffset.center,
                                            transform: Matrix4.rotationZ(
                                              -3.1415926535897932 / 4,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  10.0),
                                              child: Stack(
                                                  children: [
                                                    SizedBox(
                                                        height: 100,
                                                        child: FittedBox(
                                                            fit: BoxFit.fill,
                                                            child: rightParkings[index].parkingSpotStatus == true ? GestureDetector(
                                                                onTap: () {
                                                                  Navigator
                                                                      .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                               PaymentPage(staticCustomerId: staticCustomerId,)));},
                                                                child: Image.asset('assets/images/reservedParking.png'))
                                                                :
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pushReplacement(context,
                                                                      MaterialPageRoute(builder: (context) => PaymentPage(staticCustomerId: staticCustomerId ,)));
                                                                },
                                                                child: Image.asset('assets/images/emptyParking.png'))
                                                        )
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(20.0),
                                                      child: Text(
                                                        rightParkings[index]
                                                            .parkingSpotDescription,
                                                        style: const TextStyle(
                                                            fontSize: 30),),
                                                    ),

                                                  ]
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ),
                            ),
                          ],),
                        ),

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

      ),);
  }

}