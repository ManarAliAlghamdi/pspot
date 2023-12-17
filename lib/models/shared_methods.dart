import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import '/models/customer_faves_models.dart';
import '/models/customer_invoice_model.dart';
import '/models/customers_information.dart';
import 'locations_model.dart';

Future<Null> updated(StateSetter updateState) async {
  updateState(() {});
}


Future<List<LocationParkingSpotModel>> getAvailableSpotsByLocation(int locationId, int customerId, String requriredDateAndTime, int  requiredPeriod)async{
  List<LocationParkingSpotModel> locationsList = [];
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
              LocationParkingSpotModel(
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
                  favesLocation: int.parse(userData[i]["R5"])
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
      'PV1': customerID.toString(),

    }
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





Future<List<CustomerFavesLocations>> getCustomerFavesLocations(int customerId)async {
  List<CustomerFavesLocations> customerFavesLocations = [];
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetCustomerFavesLocations&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];

    Uri finalUri = Uri.parse(uri);

    await http.post(finalUri, body: {

      'P1': '@customerId',
      'PV1': customerId.toString(),

    }).then((value) {

      userData = jsonDecode(value.body);

      if (userData.isNotEmpty) {
        for (int i = 0; i < userData.length; i++) {
          customerFavesLocations.add(
              CustomerFavesLocations(
                locationLogo: 'assets/images/${userData[i]["R1"]}',
                locationName: userData[i]["R2"],
                locationId: int.parse(userData[i]["R3"]),


              ));
        }
      }
    });
    return customerFavesLocations;
  } catch (ex) {
    print("something went wrong! in getting the faves Locations");
    return customerFavesLocations;
  }
}



Future<List<CustomerInvoiceDetails>> getCustomerInvoiceDetails(int invoiceNo) async {
  List<CustomerInvoiceDetails> invoiceDetailsList = [];
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetCustomerInvoiceDetails&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@invoiceNo',
      'PV1': invoiceNo.toString(),
    }).then((value) async {
      userData = jsonDecode(value.body);
      if (userData.isNotEmpty) {
        for (int i = 0; i < userData.length; i++) {
          invoiceDetailsList.add(
              CustomerInvoiceDetails(
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
                  invoiceNo: invoiceNo,
                  status: userData[i]["R14"]
              )
          );
        }
      }
    });
    return invoiceDetailsList;
  }
  catch (ex) {
    return invoiceDetailsList;
  }
}
Future<int> getCustomerId(String customerPhoneNumber, String password)async{
  int customerId = 0;
  try{
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_customerLogin&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      "P1": "@phoneNumber",
      "PV1": customerPhoneNumber.toString(),

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
        else if(userData[0]["R1"] == "wrong input"){
          customerId = int.parse(userData[0]["R2"]);
          print(userData[0]["R2"]);
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
        else if(userData[0]["R1"] == "exists") {
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
Future<List<CustomerInvoices>> getCustomerInvoices(int customerNo)async{

  List<CustomerInvoices> invoicesList = [];
  try{
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetCustomerInvoices&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];
    Uri finalUri = Uri.parse(uri);
    await http.post(finalUri, body: {
      'P1': '@customerId',
      'PV1': customerNo.toString(),
    }).then((value)async {
      userData = jsonDecode(value.body);
      if (userData.isNotEmpty) {
        for (int i = 0; i < userData.length; i++) {
          invoicesList.add(
              CustomerInvoices(
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
    return invoicesList;
  }catch(ex){
    return invoicesList;
  }
}

Future<void> addLocationIntoFaves(int customerId, int locationId)async{

  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_insertLocationIntoFaves&conncectionStringInWebConfig=pSpotconnection";

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
Future<void> removeLocationFromFaves(int customerId, int locationId)async{
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_deleteLocationFromFaves&conncectionStringInWebConfig=pSpotconnection";
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
          print("deleting all done");


        }}});
  }
  catch(ex){print("somthing went wrong! in deleting");
  }

}



Future<String> reserveParkingSpot(int spotId, int customerId, String ticketsDateAndTime, int requiredPeriod, double totalCost)async {
  String reserveState = '';
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_ReservParkingSpotByLocations&conncectionStringInWebConfig=pSpotconnection";
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
      'PV4': requiredPeriod.toString(),

      'P5': '@totalCost',
      'PV5': totalCost.toString()
    }).then((value) {
      userData = jsonDecode(value.body);
      if (userData.isNotEmpty) {
       reserveState = userData[0]["R1"] ;
      }
    });
    return reserveState;
  } catch (ex) {
    print("object");
    return reserveState;
  }
}

Future<List<LocationLogo>> getLocationLogo ()async{
  List<LocationLogo> locationsLogo = [];

  try{
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_GetLocationLogo&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];

    Uri finalUri = Uri.parse(uri);

    await http.post(finalUri, body: { }).then((value){

      userData = jsonDecode(value.body);

      if (userData.isNotEmpty) {

        for(int i = 0; i< userData.length; i++){
          locationsLogo.add(
              LocationLogo(
                locationId: int.parse(userData[i]["R1"]),
                locationLogo: 'assets/images/${userData[i]["R2"]}',
                locationName: userData[i]["R3"],
          )
          );
        }
      }
    });
    print('getting locations logo were success! d:');

    return locationsLogo;
  }catch(ex){

print('there is problem in getting locations logo :(');
    return locationsLogo;
  }

}

Future<String> cancelReservation(int invoiceNo)async {
  String status = '';
  try {
    String uri = "https://nga.myquotas.com/NGA/GDN?storedProcedureName=dbo.pSpotDb_sp_cancelReservation&conncectionStringInWebConfig=pSpotconnection";
    List userData = [];

    Uri finalUri = Uri.parse(uri);

    await http.post(finalUri, body: {
      'P1': '@invoiceNo',
      'PV1': invoiceNo.toString(),

    }).then((value) {
      userData = jsonDecode(value.body);
      if (userData.isNotEmpty) {
        status  = userData[0]["R1"];
      }
    });
    return status;
  } catch (ex) {
    return status;
  }
}