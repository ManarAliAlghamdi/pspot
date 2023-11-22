import 'package:flutter/material.dart';
import '/models/shared_methods.dart';

import '../models/customer_faves_models.dart';

class CustomerFavesTicketsControl extends StatefulWidget {
  final CustomerFavesTickets ticketsInfo;
  final int staticCustomerId;
  const CustomerFavesTicketsControl({Key? key, required this.ticketsInfo, required this.staticCustomerId}) : super(key: key);

  @override
  State<CustomerFavesTicketsControl> createState() => _CustomerTicketsControlState();
}

class _CustomerTicketsControlState extends State<CustomerFavesTicketsControl> {
  CustomerFavesTickets? ticketsInfo;
  bool isFaves = true;
  int staticCustomerId = 0;
  int parkingSpotId = 0;
  int locationId = 0;
  List<int> favesLocation = [0];

  Future<void> customerAddFaves(int customerId, int parkingSpotId) async {
    await addFaves(customerId, parkingSpotId).then((value) {
      setState(() {
        isFaves = true;
      });
    });
  }

  Future<void> customerRemoveFaves(int customerId, int parkingSpotId) async {
    await removeFaves(customerId, parkingSpotId).then((value) {
      setState(() {
        isFaves = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {

    // });
    ticketsInfo = widget.ticketsInfo;
    locationId = ticketsInfo!.locationId;
    staticCustomerId = widget.staticCustomerId;
    return GestureDetector(
      child: Container(
          child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  // Added this
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 56,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset(ticketsInfo!.locationLogo),
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
                            child: Text(
                              ticketsInfo!.locationName,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: IconButton(
                          onPressed: () async {
                            if (isFaves) {
                              print(
                                  " faves = true $staticCustomerId $parkingSpotId");
                              await customerRemoveFaves(
                                  widget.staticCustomerId,
                                  ticketsInfo!.locationId);
                            } else if (isFaves == false) {
                              print(
                                  " faves = false $staticCustomerId $locationId");

                              await customerAddFaves(
                                  widget.staticCustomerId,
                                  ticketsInfo!.locationId);
                            }
                          },

                          icon: isFaves ? const Icon(Icons.favorite, color: Colors.orange,) :
                          const Icon(Icons.favorite_border)),
                    ),
                  ],
                ),
              ])),
    );
  }
}
