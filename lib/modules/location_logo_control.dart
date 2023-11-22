import 'package:flutter/cupertino.dart';
import '/models/locations_model.dart';

class Locatioin_Logo_Control extends StatefulWidget {
  final LocationModel location;
  const Locatioin_Logo_Control({super.key, required this.location});

  @override
  State<Locatioin_Logo_Control> createState() => _Locatioin_Logo_ControlState();
}

class _Locatioin_Logo_ControlState extends State<Locatioin_Logo_Control> {
  LocationModel? _location ;//=  LocationModel(locationId: 0, locationName: '', locationOnMap: '', locationLogo: '', locationCapacity: 0, locationAvailableSpots: 0, favesLocation: 0);
  @override
  Widget build(BuildContext context) {
    _location = widget.location;

    return GestureDetector(
      onTap: (){print(_location!.locationName);},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 100,
            child: Image.asset(_location!.locationLogo),

          ),
        ));
  }
}
