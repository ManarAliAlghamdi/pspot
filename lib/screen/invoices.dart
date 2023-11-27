import 'package:flutter/material.dart';
import '/models/shared_methods.dart';
import '/modules/customer_invoice_details.dart';
import '../models/customer_tickets_model.dart';
import '../modules/customer_invoice_control_delete.dart';
import '../modules/fluid_nav_bar.dart';


class CustomerInvoice extends StatefulWidget {
  final int staticCustomerId;
  const CustomerInvoice ({Key? key, required this.staticCustomerId}) : super(key: key);

  @override
  _CustomerInvoiceState createState() => _CustomerInvoiceState();
}

class _CustomerInvoiceState extends State<CustomerInvoice> {
  int staticCustomerId = 0;
  List<CustomerInvoices> customerInvoice = [];
  List<CustomerInvoiceDetails> customerTicketsDetails = [];
  List<CustomerInvoices> filteredCustomerTickets = [];
  TextEditingController searchTextField = TextEditingController();
  int invoiceNo = 0;
  String x = '';
  bool showInvoice = false;
  bool showInvoiceDetails = false;
  bool showProcessing = true;


  //  create the The customer tickets List from the database
  void initTickets(customerNo) async {
    customerInvoice = [];
    showProcessing = true;
    showInvoice = false;
    showInvoiceDetails = false;
    await getCustomerInvoices(customerNo).then((value) {
      setState(() {
        customerInvoice = value;
        showProcessing = false;
        showInvoice = true;
      });
      filteredCustomerTickets = customerInvoice;
    });
  }

  // when user refresh the page the it will refilled the list from the database
  Future<void> _refreshTickets() async {
    setState(() {
      showInvoice = false;
      showProcessing = true;
    });
    await getCustomerInvoices(widget.staticCustomerId).then((value) {
      setState(() {
        customerInvoice = value;
        showProcessing = false;
        showInvoice = true;
      });
      filteredCustomerTickets = customerInvoice;
    });
  }
  // after clicked the one of the list item this function will grab the tickets details according
  // to the item index
  void showTicketsDetails(invoiceNo) async {
    setState(() {
      showInvoiceDetails = false;
      showProcessing = true;
      showInvoice = false;
    });
    customerTicketsDetails = [];
    await getCustomerInvoiceDetails(invoiceNo).then((value) {
      setState(() {
        showInvoiceDetails = true;
        showProcessing = false;
        showInvoice = false;
        customerTicketsDetails = value;
      });
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => CustomerInvoicesDetailsControl(invoiceDetailsInfo: customerTicketsDetails[0], staticCustomerId: widget.staticCustomerId,)));

    });
  }

  // filled up the filtered list according to user search
  void filterCustomerTickets() {
    setState(() {
      filteredCustomerTickets =
          customerInvoice.where((i) =>
              i.locationName.toLowerCase()
                  .contains(searchTextField.text.toLowerCase()))
              .toList();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTickets(widget.staticCustomerId);
  }

  @override
  Widget build(BuildContext context) {
    staticCustomerId = widget.staticCustomerId;
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
                        visible: showInvoice,
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
                                height: MediaQuery.of(context).size.height - 195,
                                width:  MediaQuery.of(context).size.width - 50,
                                child: RefreshIndicator(
                                  onRefresh: _refreshTickets,
                                  child: ListView.builder(
                                      itemCount: filteredCustomerTickets.length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return GestureDetector(
                                            onTap: (){
                                              // showInvoice = false;
                                              // showInvoiceDetails = true;
                                              showTicketsDetails(filteredCustomerTickets[index].invoiceNo);
                                              invoiceNo = filteredCustomerTickets[index].invoiceNo;
                                              x = invoiceNo.toString();
                                               },
                                            child: Container(
                                              child: Column(
                                                  children: [
                                                    const SizedBox(height: 10,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added this
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),

                                                          child: SizedBox(
                                                            height: 50,
                                                            width: 56,
                                                            child: FittedBox(
                                                              fit: BoxFit.fill,
                                                              child: Image.asset(filteredCustomerTickets[index].locationLogo),
                                                            ),
                                                          ),

                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .width - 180,
                                                                child: Text(filteredCustomerTickets[index].locationName,
                                                                  textAlign: TextAlign.left,
                                                                  style: const TextStyle(
                                                                      fontWeight: FontWeight.bold, fontSize: 15),),
                                                              ),
                                                              // Container(height: 7),
                                                              SizedBox(
                                                                width: MediaQuery.of(context).size.width - 180,
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                    children: [
                                                                      const TextSpan(
                                                                        text: "Invoice Date: : ",
                                                                        style: TextStyle(color: Colors.black),
                                                                      ),
                                                                      TextSpan(
                                                                        text: filteredCustomerTickets[index].ticketDateTime,
                                                                        style: const TextStyle(color: Color(0xff93A7A7)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(context).size.width - 180,
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                    children: [
                                                                      const TextSpan(
                                                                        text: "ParkingSpot Number: : ",
                                                                        style: TextStyle(color: Colors.black),
                                                                      ),
                                                                      TextSpan(
                                                                        text: filteredCustomerTickets[index].parkingSpotNumber,
                                                                        style: const TextStyle(color: Color(0xff93A7A7)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // Padding(
                                                        //   padding: const EdgeInsets.only(),
                                                        //   child: IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
                                                        // ),
                                                      ],
                                                    ),
                                                  ]),
                                            )
                                        );
                                      }
                                  ),
                                ),
                              ),
                            ]
                        )
                    ),

                  ]
              ),
            )
        ),
      bottomNavigationBar: SizedBox(height: 70,
          child: FluidNavBar(staticCustomerId: widget.staticCustomerId,)),
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



//   Visibility(
//                         visible: showInvoiceDetails,
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: double.infinity,
//                                 height: 50,
//                                 alignment: Alignment.centerLeft,
//                                 decoration: const BoxDecoration(
//                                     color: Color.fromRGBO(58, 57, 57, 1)),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       showInvoiceDetails = false;
//                                       showProcessing = false;
//                                       showInvoice = true;
//                                     });
//                                   },
//                                   child: const Text(
//                                     ' |Back to your Tickets',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                     textAlign: TextAlign.right,
//
//                                   ),
//                                 ),
//                               ),
//
//                               SingleChildScrollView(
//                                 child: SizedBox(
//                                     height: MediaQuery.sizeOf(context).height ,
//                                     child: customerTicketsDetails.isEmpty
//                                         ?  Text("$x") :
//                                     SizedBox(
//                                       height: MediaQuery.of(context).size.height,
//                                       width: MediaQuery.of(context).size.width,
//                                       child: ListView.builder(
//                                           itemCount: customerTicketsDetails.length,
//                                           itemBuilder: (BuildContext context, int index){
//                                             return Column(
//                                               children: [
//                                                 CustomerInvoicesDetailsControl(invoiceDetailsInfo: customerTicketsDetails[0], staticCustomerId: widget.staticCustomerId,)
//                                               ],
//                                             );
//
//                                           }),
//                                     )
//                                 ),
//
//                               ),
//                             ])
//                     )