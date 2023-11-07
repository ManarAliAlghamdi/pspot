import 'package:flutter/material.dart';
import '/models/shared_methods.dart';
import '../models/customer_faves_models.dart';
import '../modules/fluid_nav_bar.dart';
import '../modules/saved_ticket_contol.dart';
import 'bookYourSpot.dart';

class SavedSpot extends StatefulWidget {
  final int staticCustomerId;
  const SavedSpot ({Key? key, required this.staticCustomerId}) : super(key: key);
  @override
  _SavedSpotState createState() => _SavedSpotState();
}

class _SavedSpotState extends State<SavedSpot> {
  bool showFavesTicket = false;
  bool showProcessing = true;
  List<CustomerFavesTickets> favesTickets = [];
  List<CustomerFavesTickets> filteredFavesTickets = [];
  TextEditingController searchTextField = TextEditingController();

  void initFavesTickets(customerNo) async {
    favesTickets = [];

    await getCustomerFavesTickets(widget.staticCustomerId).then((value) {
      setState(() {
        showFavesTicket = true;
        showProcessing = false;
        favesTickets = value;
      });
      filteredFavesTickets = favesTickets;
    });
  }

  Future<void> _refreshTickets() async {
    setState(() {
      showFavesTicket = false;
      showProcessing = true;
    });
    await getCustomerFavesTickets(widget.staticCustomerId).then((value) {
      setState(() {
        showFavesTicket = true;
        showProcessing = false;
        favesTickets = value;
      });
      filteredFavesTickets = favesTickets;
    });
  }

  // filled up the filtered list according to user search
  void filterCustomerTickets() {
    setState(() {
      filteredFavesTickets =
          favesTickets.where((i) =>
              i.locationName.toLowerCase()
                  .contains(searchTextField.text.toLowerCase()))
              .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFavesTickets(widget.staticCustomerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Favorite Tickets", style: TextStyle(color: Colors.black),),
          backgroundColor: const Color(0xffC4DFDF),),
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
                    Visibility(
                      visible: showFavesTicket,
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
                                    itemCount: filteredFavesTickets.length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return GestureDetector(
                                        onTap: (){

                                        },
                                        child: Row(
                                          children: [
                                            CustomerFavesTicketsControl(
                                              ticketsInfo: filteredFavesTickets[index],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ]),
            )
        ),
        bottomNavigationBar:  SizedBox(height: 50, child: FluidNavBar(staticCustomerId: widget.staticCustomerId,))
    );
  }

}

// return Scaffold(
// body: Column(children: [
// const SizedBox(height: 20),
// ElevatedButton.icon(
// //child: (Text("You Have No Previous Places /n Reserve Your Spots ",
// //style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)),
// icon: const Icon(Icons.favorite),
// label: const Center(
// child: Text("click here to save favorite spot Now!",
// style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// ),
// onPressed: () {
// Navigator.pushReplacement(context, MaterialPageRoute(
// builder: (context)=> const BookYourSpot(title: 'Parking Spots | Locations List')));
// },
// style: ElevatedButton.styleFrom(
// foregroundColor: Colors.black87, backgroundColor: Colors.white, padding: const EdgeInsets.all(20.0),
// elevation: 15,
// shadowColor: Colors.grey,
// alignment: Alignment.centerLeft,
// ),
// ),
// const SizedBox(height: 20),
// const Text(
// "My Saved Spots",
// style: TextStyle(fontSize: 20, color: Colors.grey),
// textAlign: TextAlign.left,
// ),
// const Expanded(
// child: Center(
// child: Text(
// "no saved spots yet..",
// textAlign: TextAlign.center,
// ),
// ))
// ]),