import 'package:flutter/material.dart';

import '/screen/Profile.dart';
import '/screen/customer_faves_locations.dart';
import '../screen/HomePage.dart';
import '../screen/invoices.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

class FluidNavBar extends StatefulWidget {
  final int staticCustomerId;
  const FluidNavBar ({Key? key, required this.staticCustomerId}) : super(key: key);

  @override
  State<FluidNavBar> createState() => _FluidNavBarState();
}

class _FluidNavBarState extends State<FluidNavBar> {
  final _pageControlller = PageController();

  @override
  void dispose() {
    _pageControlller.dispose();
  }
   @override
 void initState() {
  super.initState();

  WidgetsFlutterBinding.ensureInitialized();

   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageControlller,
        children:  <Widget>[
          HomePage(
            staticCustomerId: widget.staticCustomerId,
            locationId: 0,
            locationLogo: '',
            locationName: '',),
          CustomerInvoice(staticCustomerId: widget.staticCustomerId,),
          SavedSpot(staticCustomerId: widget.staticCustomerId,),
          UserProfile(staticCustomerId: widget.staticCustomerId,)
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        color: const Color(0xffCAE2E2),
        controller: _pageControlller,
        flat: true,
        useActiveColorByDefault: false,
        items: const [
          RollingBottomBarItem(Icons.home,
              label: 'Home', activeColor: Colors.orangeAccent),
          RollingBottomBarItem(Icons.inventory,
              label: 'Invoices', activeColor: Colors.orangeAccent),
          RollingBottomBarItem(Icons.favorite,
              label: 'Favorites', activeColor: Colors.orangeAccent),
          RollingBottomBarItem(Icons.person,
              label: 'Profile', activeColor: Colors.orangeAccent),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _pageControlller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}















