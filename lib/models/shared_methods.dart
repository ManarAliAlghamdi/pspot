import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import '/models/customer_faves_models.dart';
import '/models/customer_tickets_model.dart';
import '/models/customers_information.dart';
import 'locations_model.dart';

Future<Null> updated(StateSetter updateState) async {
  updateState(() {});
}


Future<List<LocationParkingSpotModelOnServer>> getAvailableSpotsByLocation(int locationId, int customerId, String requriredDateAndTime, int  requiredPeriod)async{
  List<LocationParkingSpotModelOnServer> locationsList = [];
  try{
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetAvaliableSpotsByLocation&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@locationId',
      'PV1': locationId.toString(),

      'P2': '@customerId',
      'PV2': customerId.toString(),

      'P3': '@requriredDateAndTime',
      'PV3': requriredDateAndTime.toString(),

      'P4': '@requiredPeriod',
      'PV4': requiredPeriod.toString()
    }).then((value)async{

      userData = jsonDecode(value.body);
      if(userData.isNotEmpty)
      {
        for(int i = 0;i < userData.length;i++)
        {
          locationsList.add(
              LocationParkingSpotModelOnServer(
                  floorId: int.parse(userData[i]["R1"]),
              floorName: userData[i]["R2"],
              sectionId: int.parse(userData[i]["R3"]),
              sectionName: userData[i]["R4"],
              parkingSpotId: int.parse(userData[i]["R5"]),
              parkingSpotDescription: userData[i]["R6"],
              isSNSpot: userData[i]["R7"],
              parkingSpotStatus: userData[i]["R8"],
                  spotCost:  double.parse(userData[i]["R9"])
              ));
        }}
    });
    return locationsList;
  }catch(ex){
print("hello there's an error ;)");
    return locationsList;
  }

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

// whenever i need to use async and await i need to use Future
Future<List<LocationModel>> getLocations(int customerId) async {
  List<LocationModel> locationList = [];
  try
  {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetLocations&conncectionStringInWebConfig=pSpotconnection";
    // create a list to decode the json file to a list
    List userData = [];
    // convert the uri from string to Uri
    Uri finalUri = Uri.parse(uri);
    //  start a connection to the web server
    await http.post(finalUri, body:{/*write here the procedure parameter */
    'P1': '@customerId',
    'PV1': customerId.toString()

    }
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
                  locationAvailableSpots: double.parse( userData[i]["R6"]),
                  favesLocation: int.parse(userData[i]["R7"])
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



Future<List<CustomerInformation>> getCustomerInfo(int customerID) async{
  List<CustomerInformation> customerInfo = [];
  try{
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_getCustomersInformation&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@customerId',
      'PV1': customerID.toString(),}
    ).then((value) {
      userData = jsonDecode(value.body);

      if (userData.isNotEmpty) {
       customerInfo.add(
           CustomerInformation(
          customerFirstName: userData[0]["R1"],
           customerLastName: userData[0]["R2"],
           customerEmail: userData[0]["R3"],
           customerPhoneNumber:userData[0]["R4"],
           customerPassword: userData[0]["R5"],
           customerId: customerID
           ));
        }
    });
    return customerInfo;
  }catch(ex){
    return customerInfo;
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
                locationId: int.parse(userData[i]["R3"]),


              ));
        }
      }
    });
    return customerFavesTickets;
  } catch (ex) {
    print("something went wrong! in getting the tickets");
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
                  ticketPeriod: int.parse(userData[i]["R8"]),
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
Future<int> getCustomerId(String customerFirstName, String password)async{
  int customerId = 0;
  try{
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_customerLogin&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      "P1": "@customerFirstName",
      "PV1": customerFirstName.toString(),

      "P2": "@password",
      "PV2": password.toString(),
    }

    ).then((value)async {
      userData = jsonDecode(value.body);
      if(userData.isNotEmpty)
      {
        if(userData[0]["R1"] == "ok") {
          customerId = int.parse(userData[0]["R2"]);
        }
      }
    });
    return customerId;
  }catch(ex){
    print(ex.toString());
    return customerId;
  }
}
Future<int> customerSignUp(String firstName, String lastName, String email, String phoneNumber, String password)async{
  int customerId = 0;
  try{
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=pSpotDb_sp_customerSignUp&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      "P1": "@firstName",
      "PV1": firstName.toString(),

      "P2": "@lastName",
      "PV2": lastName.toString(),

      "P3": "@email",
      "PV3": email.toString(),

      "P4": "@phoneNumber",
      "PV4": phoneNumber.toString(),

      "P5": "@password",
      "PV5": password.toString()

    }

    ).then((value)async {
      userData = jsonDecode(value.body);
      if(userData.isNotEmpty){
        if(userData[0]["R1"] == "ok") {
          customerId = int.parse(userData[0]["R2"]);
        }
      }

    });
    return customerId;
  }catch(ex){
    return customerId;
  }
}
Future<List<CustomerInformation>> getCustomerInformation(int customerId)async{
  print('Reading $customerId');
  List<CustomerInformation> customerInformation = [];
  try{
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_getCustomersInformation&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@customerId',
      'PV1': customerId.toString(),
    }
    ).then((value)async{
      userData = jsonDecode(value.body);
      if(userData.isNotEmpty){
        for (int i = 0; i < userData.length; i++) {
          customerInformation.add(
              CustomerInformation(
                customerFirstName: userData[i]["R1"],
                customerLastName: userData[i]["R2"],
                customerEmail: userData[i]["R3"],
                customerPhoneNumber: userData[i]["R4"],
                customerPassword: userData[i]["R5"],
                customerId: customerId,
              )
          );
        }
      }
    });

    return customerInformation;
  }catch(ex){
    return customerInformation;

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
Future<void> addFaves(int customerId, int locationId)async{
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_insertIntoCustomersFavesTbl&conncectionStringInWebConfig=pSpotconnection";

    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@customerId',
      'PV1': customerId.toString(),
      'P2': '@locationId',
      'PV2': locationId.toString(),

    }).then((value){
      userData = jsonDecode(value.body);
      if(userData.isNotEmpty)
      {
        if(userData[0]["R1"] == "ok") {
        print("inserting all done");
        }
      }
    });
  }catch(ex){print("somthing went wrong! in inserting");
  }


}
Future<void> removeFaves(int customerId, int locationId)async{
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_removeFromFavesTickets&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {

      'P1': '@customerId',
      'PV1': customerId.toString(),

      'P2': '@locationId',
      'PV2': locationId.toString(),

    }).then((value){
      userData = jsonDecode(value.body);
      if(userData.isNotEmpty)
      {
        if(userData[0]["R1"] == "ok") {
          print("deleting all done");}}});
  }
  catch(ex){print("somthing went wrong! in deleting");
  }

}



Future<void> reserveParkingSpot(int spotId, int customerId, String ticketsDateAndTime, int requiredPeriod)async{
try{
  String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_ReservParkingSpots&conncectionStringInWebConfig=pSpotconnection";
  List userData = [];
  Uri finalUri = Uri.parse(uri);
  await http.post(finalUri, body: {
    'P1': '@spotId',
    'PV1': spotId.toString(),

    'P2': '@customerId',
    'PV2': customerId.toString(),

    'P3': '@requriredDateAndTime',
    'PV3': ticketsDateAndTime.toString(),

    'P4': '@requiredPeriod',
    'PV4': requiredPeriod.toString()
  }).then((value){
    userData = jsonDecode(value.body);
    if(userData.isNotEmpty){
      if(userData[0]["R1"] == "done") {
        print("deleting all done");}
      else if(userData[0]["R1"] == "exists") {
        print("there is already a reservation ");}
    }
  });
  }catch(ex){
  print("object");
}
}