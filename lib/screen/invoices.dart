import 'package:flutter/material.dart';
import '/models/shared_methods.dart';
import '/modules/customer_invoice_details.dart';
import '../models/customer_invoice_model.dart';
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
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => CustomerInvoicesDetailsControl(
            invoiceDetailsInfo: customerTicketsDetails[0], staticCustomerId: widget.staticCustomerId,)));

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
          leading: IconButton(onPressed: () {  }, icon: Icon(Icons.add, size: 0,color: Color(0xffC4DFDF,)),),

          title:  Padding(
            padding: EdgeInsets.only(left: 30),
            child: const Text(
              "Parking Invoices", style: TextStyle(color: Colors.white),),
          ),
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

                                              showTicketsDetails(filteredCustomerTickets[index].invoiceNo);

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
                                                                        text: filteredCustomerTickets[index].ticketDateTime.substring(0,10),
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

    );
  }
}

