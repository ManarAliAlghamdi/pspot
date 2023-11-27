import 'package:flutter/material.dart';
import 'package:pspot_test/screen/bookYourSpot.dart';
import '../models/nav_item_model.dart';
import '../screen/Profile.dart';

import '../screen/homeScreen.dart';
import '../screen/invoices.dart';
import '../screen/customer_faves_locations.dart';

class FluidNavBar extends StatefulWidget {
  final int staticCustomerId;
  const FluidNavBar ({Key? key, required this.staticCustomerId}) : super(key: key);

  @override
  _FluidNavBarState createState() => _FluidNavBarState();
}

class _FluidNavBarState extends State<FluidNavBar> {
  int _selectedIndex = 0;
  final List<NavItem> _navItems = [
    NavItem(Icons.account_circle_outlined, "Profile"),
    NavItem(Icons.inventory_2_outlined, "Reservations"),
    NavItem(Icons.home, "Bitcoin"),
    NavItem(Icons.bookmark, "Bookmark"),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => UserProfile(staticCustomerId: widget.staticCustomerId,)));
      } else
        if (index == 1) {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>  CustomerInvoice(staticCustomerId: widget.staticCustomerId,)));
      } else if (index == 2) {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen(staticCustomerId: widget.staticCustomerId,)));
      } else if (index == 3) {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>  SavedSpot(staticCustomerId: widget.staticCustomerId,)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 90.0,
        width: 50.0,
        child: FloatingActionButton(

          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=> BookYourSpot(title: 'Parking Spots | Locations List', staticCustomerId: widget.staticCustomerId, dateOrLocation: 'locations', locationIdFromFaves: 0, locationLogo: '', locationName: '',)));
            },
          backgroundColor: Colors.amberAccent,
          child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: const Icon(Icons.pin_drop_outlined,
                  size: 30.0,
                  color: Color(0xff2D2727)
              )
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xffC4DFDF),
        shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10),
              ),
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _navItems.map((item) {
            var index = _navItems.indexOf(item);
            return Row(
              children: [
                const SizedBox(width: 10,),
                SizedBox(
                  width: 65,
                  height: 40,
                  child: IconButton(
                    onPressed: () => _onNavItemTapped(index),
                    icon: Icon(
                      item.icon,
                      color:  Colors.white ,
                      size: 40,
                    ),
                  ),
                ),


                const SizedBox(width: 10,),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}