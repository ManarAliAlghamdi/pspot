
class LocationModel {
  final int locationId;
  final String locationName;
  final String locationOnMap;
  final String locationLogo;
  final double locationCapacity;
  final double locationAvailableSpots;
  final int favesLocation ;

  LocationModel(
      {
        required this.locationId,
        required this.locationName,
        required this.locationOnMap,
        required this.locationLogo,
        required this.locationCapacity,
        required this.locationAvailableSpots,
        required this.favesLocation
      });
}


class FloorModel {
  final int floorId;
  final String floorDescription;
  final int floorCapacity;
  final int floorAvailableSpots;
  final int floorLocationNo;

  FloorModel(
      {
        required this.floorId,
        required this.floorDescription,
        required this.floorCapacity,
        required this.floorAvailableSpots,
        required this.floorLocationNo,
      });
}

class SectionModel {
  final int sectionId;
  final String sectionDescription;
  final int sectionCapacity;
  final int sectionAvailableSpots;
  final int sectionFloorNo;

  SectionModel(
      {
        required this.sectionId,
        required this.sectionDescription,
        required this.sectionCapacity,
        required this.sectionAvailableSpots,
        required this.sectionFloorNo,
      });
}

class ParkingSpotModel {
  final int parkingSpotId;
  final String parkingSpotDescription;
  final bool parkingSpotStatus;
  final int parkingSpotSectionNo;
  final String parkingSpotDirection;
  final String isSNSpot;
  late bool isSelected;
  ParkingSpotModel(
      {
        required this.parkingSpotId,
        required this.parkingSpotDescription,
        required this.parkingSpotStatus,
        required this.parkingSpotSectionNo,
        required this.parkingSpotDirection,
        required this.isSNSpot,
        required this.isSelected,
      });
}


class LocationParkingSpotModelOnServer{
  final int floorId;
  final String floorName;
  final int sectionId ;
  final String sectionName;
  final int parkingSpotId;
  final String parkingSpotDescription;
  final String isSNSpot;
  final String parkingSpotStatus;
  final double spotCost;

  // late bool isSelected;
  LocationParkingSpotModelOnServer(
      {
        required this.floorId,
        required this.floorName,
        required this.sectionId,
        required this.sectionName,
        required this.parkingSpotId,
        required this.parkingSpotDescription,
        required this.isSNSpot,
        required this.parkingSpotStatus,
        required this.spotCost


        // required this.isSelected,
      });
}

class LocationParkingSpotModel {
  final int floorId;
  final String floorName;

  final int sectionId;
  final String sectionName;

  final int parkingSpotId;
  final String parkingSpotDirection;

  final String isAvailable;


  LocationParkingSpotModel({
    required this.floorId,
    required this.floorName,
    required this.sectionId,
    required this.sectionName,
    required this.parkingSpotId,

    required this.parkingSpotDirection,
    required this.isAvailable
  });
}

class LocationLogo{
  final int locationId;
  final String locationLogo;
  final String locationName;


  LocationLogo({
    required this.locationId,
    required this.locationLogo,
    required this.locationName

});
}