import 'package:flutter/material.dart';
import '/models/shared_methods.dart';
import '/modules/customerTicketDetails.dart';
import '../models/customer_tickets_model.dart';
import '../modules/customerTickets_control.dart';
import '../modules/fluid_nav_bar.dart';


class ReservedPage extends StatefulWidget {
  const ReservedPage({super.key});

  @override
  _ReservedPageState createState() => _ReservedPageState();
}

class _ReservedPageState extends State<ReservedPage> {

  List<CustomerTickets> customerTickets = [];
  List<CustomerTicketDetails> customerTicketsDetails = [];
  List<CustomerTickets> filteredCustomerTickets = [];
  TextEditingController searchTextField = TextEditingController();
  int invoiceNo = 0;
  String x = '';
  bool showTicket = false;
  bool showTicketDetails = false;
  bool showProcessing = true;

  //  create the The customer tickets List from the database
  void initTickets(customerNo) async {
    customerTickets = [];
    showProcessing = true;
    showTicket = false;
    showTicketDetails = false;
    await getCustomerTickets(customerNo).then((value) {
      setState(() {
        customerTickets = value;
        showProcessing = false;
        showTicket = true;
      });
      filteredCustomerTickets = customerTickets;
    });
  }

  // when user refresh the page the it will refilled the list from the database
  Future<void> _refreshTickets() async {
    setState(() {
      showTicket = false;
      showProcessing = true;
    });
    await getCustomerTickets(1).then((value) {
      setState(() {
        customerTickets = value;
        showProcessing = false;
        showTicket = true;
      });
      filteredCustomerTickets = customerTickets;
    });
  }
  // after clicked the one of the list item this function will grab the tickets details according
  // to the item index
  void showTicketsDetails(invoiceNo) async {
    setState(() {
      showTicketDetails = false;
      showProcessing = true;
      showTicket = false;
    });
    customerTicketsDetails = [];
    await getCustomerTicketDetails(invoiceNo).then((value) {
      setState(() {
        showTicketDetails = true;
        showProcessing = false;
        showTicket = false;
        customerTicketsDetails = value;
      });
    });
  }
  // filled up the filtered list according to user search
  void filterCustomerTickets() {
    setState(() {
      filteredCustomerTickets =
          customerTickets.where((i) =>
              i.locationName.toLowerCase()
                  .contains(searchTextField.text.toLowerCase()))
              .toList();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTickets(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Parking Tickets", style: TextStyle(color: Colors.black),),
          backgroundColor: Color(0xffC4DFDF),
        ),
        body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery
                  .sizeOf(context)
                  .height,
              child: Column(
                  children: [
                    Visibility(
                        visible: showProcessing,
                        child: Center(
                          child: Image.asset('assets/images/processing.gif'),
                        )),
                    // Locations
                    Visibility(
                        visible: showTicket,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextField(
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(),
                                    hintText: 'Search for parking',
                                  ),
                                  controller: searchTextField,
                                  onChanged: (text) {
                                    filterCustomerTickets();
                                  }),
                              SizedBox(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height - 195,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 50,
                                child: RefreshIndicator(
                                  onRefresh: _refreshTickets,
                                  child: ListView.builder(
                                      itemCount: filteredCustomerTickets.length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return GestureDetector(
                                          onTap: ()  {
                                            showTicket = false;
                                            showTicketDetails = true;
                                            showTicketsDetails(filteredCustomerTickets[index].invoiceNo);
                                            invoiceNo = filteredCustomerTickets[index].invoiceNo;
                                            x = invoiceNo.toString();
                                            },

                                          child: Row(
                                            children: [
                                              CustomerTicketsControl(
                                                ticketsInfo: filteredCustomerTickets[index],
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ),
                            ]
                        )
                    ),
                    Visibility(
                        visible: showTicketDetails,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 50,
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(58, 57, 57, 1)),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showTicketDetails = false;
                                      showProcessing = false;
                                      showTicket = true;
                                    });
                                  },
                                  child: const Text(
                                    ' |Back to your Tickets',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,

                                  ),
                                ),
                              ),

                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: SizedBox(
                                        height: MediaQuery
                                            .sizeOf(context)
                                            .height - 350,
                                        child: customerTicketsDetails.isEmpty
                                            ?  Text("$x")
                                            :
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height - 300,
                                          width: MediaQuery.of(context).size.width - 50,
                                          child: ListView.builder(
                                              itemCount: customerTicketsDetails.length,
                                              itemBuilder: (BuildContext context, int index){
                                                return Column(
                                                  children: [
                                                    CustomerTicketsDetailsControl(ticketsDetailsInfo: customerTicketsDetails[0])
                                                  ],
                                                );

                                              }),
                                        )
                                    ),

                                  )
                              ),
                            ])
                    )
                  ]
              ),
            )
        ),
        bottomNavigationBar: const SizedBox(height: 50, child: FluidNavBar())

    );
  }
}


//
// if (customerTickets.isEmpty) {
// return Scaffold(
// body: Column(children: [
// const SizedBox(height: 20),
// ElevatedButton.icon(
// icon: const Icon(Icons.access_alarm),
// label: const Text("click here to Reserve your first spot!",
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// onPressed: () {
// Navigator.pushReplacement(context, MaterialPageRoute(
// builder: (context) =>
// const BookYourSpot(title: 'Parking Spots | Locations List')
// ));
// },
// style: ElevatedButton.styleFrom(
// foregroundColor: Colors.black87,
// backgroundColor: Colors.white,
// padding: const EdgeInsets.all(20.0),
// elevation: 15,
// shadowColor: Colors.grey,
// alignment: Alignment.centerLeft,
// ),
// ),
// const SizedBox(height: 20),
// const Text(
// "My ParKing TicKet",
// style: TextStyle(fontSize: 20, color: Colors.grey),
// textAlign: TextAlign.left,
// ),
// const Expanded(
// child: Center(
// child: Text(
// "no reserved spots yet..",
// textAlign: TextAlign.center,
// ),
// ))
// ]
// ),
// bottomNavigationBar: const SizedBox(height: 50, child: FluidNavBar())
// );
// }