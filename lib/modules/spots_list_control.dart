import 'package:flutter/cupertino.dart';
import '../models/locations_model.dart';

class Spot_List_Control extends StatefulWidget {
  List<LocationParkingSpotModelOnServer> spotsList;
  Spot_List_Control({super.key, required this.spotsList});

  @override
  State<Spot_List_Control> createState() => _Spot_List_ControlState();
}

class _Spot_List_ControlState extends State<Spot_List_Control> {
  late List<LocationParkingSpotModelOnServer> _spotsList;

  @override
  Widget build(BuildContext context) {
    _spotsList = widget.spotsList;
    return Container(
        height: _spotsList.length * 30,
        child: ListView.builder(
          itemCount: _spotsList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                    color: CupertinoColors.white,
                    height: 20,
                    child: Text(_spotsList[index].parkingSpotDescription)),
                SizedBox(
                  height: 5,
                )
              ],
            );
          },
        ));
  }
}
