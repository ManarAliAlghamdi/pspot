import 'package:flutter/material.dart';

import '../modules/fluid_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffdfa),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 235, 235),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.black87,),
                            hintText: "Search your saved place",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
                        )
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                  const SizedBox(
                    height: 20,
                    child: Text('Famous Places' ,
                      style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        famousPlaces('assets/images/blvd.png', imageSize: 200),
                        famousPlaces('assets/images/KAFD.jpg', imageSize: 200),
                        famousPlaces('assets/images/Rpark.png', imageSize: 200),
                        famousPlaces('assets/images/blvd.png', imageSize: 200),
                        famousPlaces('assets/images/KAFD.jpg',imageSize: 200),
                        famousPlaces('assets/images/Rpark.png', imageSize: 200),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    child: Text('My Saved Places:' ,
                      style: TextStyle(fontSize: 15 ,
                          fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        famousPlaces('assets/images/blvd.png',imageSize:100),
                        famousPlaces('assets/images/KAFD.jpg', imageSize: 200),
                        famousPlaces('assets/images/Rpark.png', imageSize: 200),
                        famousPlaces('assets/images/blvd.png', imageSize: 200),
                        famousPlaces('assets/images/KAFD.jpg', imageSize: 200),
                        famousPlaces('assets/images/Rpark.png', imageSize: 200),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
      bottomNavigationBar: const SizedBox(height: 100, child: FluidNavBar()),
    );

  }
  Widget famousPlaces (image, {required int imageSize}) {
    return AspectRatio(aspectRatio: 2.55 / 3,
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.contain,
              image:AssetImage(image)
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                stops: const [0.1, 0.9],
                colors: [
                  Colors.black.withOpacity(.0),
                  Colors.black.withOpacity(.0)
                ]
            ),
          ),
        ),
      ),
    );
  }
}