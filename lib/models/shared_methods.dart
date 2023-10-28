import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'locations_model.dart';




Future<List<LocationModel>> getLocations()
async {
  List<LocationModel> locationList = [];
  try
  {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetLocations&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body:{}
    ).then((value) async {
      userData = jsonDecode(value.body);
      if(userData.isNotEmpty)
        {
for(int i = 0;i<userData.length;i++) {
  locationList.add( LocationModel(locationId: int.parse(userData[i]["R1"]), locationName:  userData[i]["R2"], locationOnMap:  userData[i]["R3"], locationLogo:  'assets/images/${userData[i]["R4"]}', locationCapacity: double.parse( userData[i]["R5"]), locationAvailableSpots: double.parse( userData[i]["R6"])));
}
        }


    });
    return locationList;
  }
  catch(ex)
  {
    return locationList;
  }
}

  Future<List<FloorModel>> getLocationFloors(int locationNo)
  async {
    List<FloorModel> floorsList = [];
    try
    {

       String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetLocationsFloor&conncectionStringInWebConfig=pSpotconnection";

      List userData = [];
      Uri finalUri = Uri.parse(uri);
      await http.post(finalUri, body: {
        'P1': '@locationId',
        'PV1': locationNo.toString(),

      }
      ).then((value) async {
        userData = jsonDecode(value.body);
        if(userData.isNotEmpty)
          {
            for(int i = 0;i < userData.length;i++)
              {
                floorsList.add(FloorModel(floorId: int.parse(userData[i]["R1"]), floorDescription:  userData[i]["R2"], floorCapacity: int.parse(userData[i]["R3"]),
                    floorAvailableSpots:   int.parse(userData[i]["R4"]), floorLocationNo:  locationNo));
              }
          }
      });

      return floorsList;
    }
    catch(ex)
    {
      return floorsList;
    }
  }

  Future<List<SectionModel>> getFloorSections(int floorNo)
  async {
    List<SectionModel> sectionsList = [];
    try
    {

       String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetFloorSections&conncectionStringInWebConfig=pSpotconnection";

      List userData = [];
      Uri finalUri = Uri.parse(uri);
      await http.post(finalUri, body: {
        'P1': '@floorId',
        'PV1': floorNo.toString(),

      }
      ).then((value) async {
        userData = jsonDecode(value.body);
        if(userData.isNotEmpty)
          {
            for(int i = 0;i < userData.length;i++)
              {
                sectionsList.add(SectionModel(sectionId: int.parse(userData[i]["R1"]), sectionDescription:  userData[i]["R2"], sectionCapacity: int.parse(userData[i]["R3"]),
                    sectionAvailableSpots:   int.parse(userData[i]["R4"]), sectionFloorNo:  floorNo));

              }
          }
      });

      return sectionsList;
    }
    catch(ex)
    {
      return sectionsList;
    }
  }


Future<Null> updated(StateSetter updateState) async {
  updateState(() {});
}


Future<List<ParkingSpotModel>> reserveParkingSlot(int parkingSpotId)
async {
  List<ParkingSpotModel> parkingSpotsList = [];
  try
  {

    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpot_sp_ReservParkingSpot&conncectionStringInWebConfig=pSpotconnection";

    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@parkingSpotId',
      'PV1': parkingSpotId.toString(),

    }
    ).then((value) async {
      userData = jsonDecode(value.body);
      if(userData.isNotEmpty)
      {
        for(int i = 0;i < userData.length;i++)
        {
          parkingSpotsList.add(ParkingSpotModel(parkingSpotId: int.parse(userData[i]["R1"]), parkingSpotDescription:  userData[i]["R2"],
              parkingSpotStatus: userData[i]["R3"].toString() == 'yes'? true:false, parkingSpotDirection:   userData[i]["R4"],isSNSpot: userData[i]["R5"],
              parkingSpotSectionNo:  parkingSpotId,isSelected: false));
        }
      }
    });

    return parkingSpotsList;
  }
  catch(ex)
  {
    return parkingSpotsList;
  }
}


  Future<List<ParkingSpotModel>> getSectionParkingSpots(int sectionNo)
  async {
    List<ParkingSpotModel> parkingSpotsList = [];
    try
    {

       String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetSectionParkingSpots&conncectionStringInWebConfig=pSpotconnection";

      List userData = [];
      Uri finalUri = Uri.parse(uri);
      await http.post(finalUri, body: {
        'P1': '@sectionId',
        'PV1': sectionNo.toString(),

      }
      ).then((value) async {
        userData = jsonDecode(value.body);
        if(userData.isNotEmpty)
          {
            for(int i = 0;i < userData.length;i++)
              {
                parkingSpotsList.add(ParkingSpotModel(parkingSpotId: int.parse(userData[i]["R1"]), parkingSpotDescription:  userData[i]["R2"],
                    parkingSpotStatus: userData[i]["R3"].toString() == 'yes'? true:false, parkingSpotDirection:   userData[i]["R4"],isSNSpot: userData[i]["R5"],
                    parkingSpotSectionNo:  sectionNo,isSelected: false));
              }
          }
      });

      return parkingSpotsList;
    }
    catch(ex)
    {
      return parkingSpotsList;
    }
  }


