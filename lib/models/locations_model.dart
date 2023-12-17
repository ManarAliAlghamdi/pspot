
class LocationModel {
  final int locationId;
  final String locationName;
  final String locationOnMap;
  final String locationLogo;
  // final double locationCapacity;
  // final double locationAvailableSpots;
  final int favesLocation;

  LocationModel(
      {
        required this.locationId,
        required this.locationName,
        required this.locationOnMap,
        required this.locationLogo,
        // required this.locationCapacity,
        // required this.locationAvailableSpots,
        required this.favesLocation
      });
}



class LocationParkingSpotModel{
  final int floorId;
  final String floorName;
  final int sectionId ;
  final String sectionName;
  final int parkingSpotId;
  final String parkingSpotDescription;
  final String isSNSpot;
  final String parkingSpotStatus;
  final double spotCost;

  LocationParkingSpotModel(
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