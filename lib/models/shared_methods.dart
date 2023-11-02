import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer_faves_models.dart';
import '../models/customer_tickets_model.dart';
import 'locations_model.dart';


// whenever i need to use async and await i need to use Future
Future<List<LocationModel>> getLocations() async {
  List<LocationModel> locationList = [];
  try
  {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetLocations&conncectionStringInWebConfig=pSpotconnection";
    // create a list to decode the json file to a list
    List userData = [];
    // convert the uri from string to Uri
    Uri finalUri = Uri.parse(uri);
    //  start a connection to the web server
    await http.post(finalUri, body:{/*write here the procedure parameter */}
    ).then((value) async {
      //  decoding the json file into a list
      userData = jsonDecode(value.body);
      // list check
      if(userData.isNotEmpty)
      {
        // for loop inside userData to create a list from LocationModel
        // with the information from the json file
        // the json file suppose to contain all data from pSpotDB_tbl_Locations table
        for(int i = 0;i<userData.length;i++) {
          locationList.add(
              LocationModel(
                // assign data
                // R1 shortcut for row 1
                  locationId: int.parse(userData[i]["R1"]),
                  locationName:  userData[i]["R2"],
                  locationOnMap:  userData[i]["R3"],
                  locationLogo:  'assets/images/${userData[i]["R4"]}',
                  locationCapacity: double.parse( userData[i]["R5"]),
                  locationAvailableSpots: double.parse( userData[i]["R6"])
              )
          );
        }
      }
    });
    // finally return the list of LocationModel
    return locationList;
  }
  // handle any Exception that may occurs
  catch(ex)
  {
    return locationList;
  }
}

Future<List<CustomerFavesTickets>> getCustomerFavesTickets(int customerId)async {
  List<CustomerFavesTickets> customerFavesTickets = [];
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetCustomerFavesTickets&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@customerId',
      'PV1': customerId.toString(),
    }).then((value) {
      userData = jsonDecode(value.body);
      if (userData.isNotEmpty) {
        for (int i = 0; i < userData.length; i++) {
          customerFavesTickets.add(
              CustomerFavesTickets(
                  locationLogo: 'assets/images/${userData[i]["R1"]}',
                  locationName: userData[i]["R2"],
                  parkingSpotNumber: userData[i]["R3"],
                  parkingSectionDescription: userData[i]["R4"],
                  parkingFloorDescriptions: userData[i]["R5"],
                  customerId: customerId));
        }
      }
    });
    return customerFavesTickets;
  } catch (ex) {
    return customerFavesTickets;
  }
}

Future<List<CustomerTicketDetails>> getCustomerTicketDetails(int invoiceNo) async {
  List<CustomerTicketDetails> ticketsDetailsList = [];
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetCustomerTicketDetails&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@invoiceNo',
      'PV1': invoiceNo.toString(),
    }).then((value) async {
      userData = jsonDecode(value.body);
      if (userData.isNotEmpty) {
        for (int i = 0; i < userData.length; i++) {
          ticketsDetailsList.add(
            CustomerTicketDetails(
                locationLogo: 'assets/images/${userData[i]["R1"]}',
                locationName: userData[i]["R2"],
                invoiceId: int.parse(userData[i]["R3"]),
                parkingSpotNumber: userData[i]["R4"],
                parkingSectionDescription: userData[i]["R5"],
                parkingFloorDescriptions: userData[i]["R6"],
                invoiceDateTime: userData[i]["R7"],
                ticketPeriod: double.parse(userData[i]["R8"]),
                parkingSpotCostPerHour: double.parse(userData[i]["R9"]),
                subTotal: double.parse(userData[i]["R10"]),
                taxAmount: double.parse(userData[i]["R11"]),
                totalCost: double.parse(userData[i]["R12"]),
                invoicePaymentStatus: userData[i]["R13"],
                invoiceNo: invoiceNo)
          );
        }
      }
    });
    return ticketsDetailsList;
  }
  catch (ex) {
    return ticketsDetailsList;
  }
}
Future<List<CustomerTickets>> getCustomerTickets(int customerNo)async{
  List<CustomerTickets> ticketsList = [];
  try{
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetCustomerTickets&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@customerId',
      'PV1': customerNo.toString(),
    }).then((value)async {
      userData = jsonDecode(value.body);
      if (userData.isNotEmpty) {
        for (int i = 0; i < userData.length; i++) {
          ticketsList.add(
              CustomerTickets(
              locationLogo: 'assets/images/${userData[i]["R1"]}',
              locationName: userData[i]["R2"],
              parkingSpotNumber: userData[i]["R3"],
              ticketDateTime: userData[i]["R4"],
                invoiceNo: int.parse(userData[i]["R5"]),
              customerNo: customerNo,
          ));
        }
      }
    });
    return ticketsList;
  }catch(ex){
    return ticketsList;
  }
}

Future<List<FloorModel>> getLocationFloors(int locationNo)
async {
  List<FloorModel> floorsList = [];
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetLocationsFloor&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      // the procedure's parameter
      'P1': '@locationId',
      // the value that will be assign into the parameter
      'PV1': locationNo.toString(),
      //   PV1 shortcut for Parameter Value
    }).then((value) async {
      userData = jsonDecode(value.body);
      if (userData.isNotEmpty) {
        for (int i = 0; i < userData.length; i++) {
          floorsList.add(
              FloorModel(
                  floorId: int.parse(userData[i]["R1"]),
                  floorDescription: userData[i]["R2"],
                  floorCapacity: int.parse(userData[i]["R3"]),
                  floorAvailableSpots: int.parse(userData[i]["R4"]),
                  floorLocationNo: locationNo));
        }
      }
    });
    return floorsList;
  }
  catch (ex) {
    return floorsList;
  }
}

Future<List<SectionModel>> getFloorSections(int floorNo)
async {
  List<SectionModel> sectionsList = [];
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetFloorSections&conncectionStringInWebConfig=pSpotconnection";

    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@floorId',
      'PV1': floorNo.toString(),
    }
    ).then((value) async {
      userData = jsonDecode(value.body);
      if (userData.isNotEmpty) {
        for (int i = 0; i < userData.length; i++) {
          sectionsList.add(
              SectionModel(
                  sectionId: int.parse(userData[i]["R1"]),
                  sectionDescription: userData[i]["R2"],
                  sectionCapacity: int.parse(userData[i]["R3"]),
                  sectionAvailableSpots: int.parse(userData[i]["R4"]),
                  sectionFloorNo: floorNo
              ));
        }
      }
    }
    );

    return sectionsList;
  }
  catch (ex) {
    return sectionsList;
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

