import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/modules/fluid_nav_bar.dart';

import 'reserveParkingSpot.dart';

class ReservationDateTime extends StatefulWidget {
  final int staticCustomerId;
  final int locationId;
  final String locationLogo;
  final String locationName;
  const ReservationDateTime({super.key,  required this.staticCustomerId, required this.locationLogo, required this.locationName, required this.locationId});



  @override
  State<ReservationDateTime> createState() => _ReservationDateTimeState();
}

class _ReservationDateTimeState extends State<ReservationDateTime> {

  int counter = 1;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String formattedDate = '';


  DateTime selectedDateTime = DateTime.now();
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xffC4DFDF), // Set the picker color
            colorScheme: const ColorScheme.light(primary: Color(0xffC4DFDF)),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDateTime) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData().copyWith(
              primaryColor: const Color(0xffC4DFDF),
              colorScheme: const ColorScheme.light(primary: Color(0xffC4DFDF)),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),

            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }


  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd  HH:mm').format(dateTime);  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) =>
                 FluidNavBar(staticCustomerId: widget.staticCustomerId)

          ));
          
        }, icon: Icon(Icons.arrow_back,),),

        title: Text("Reservation Date & Time", style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xffC4DFDF),
      ),
      body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 70, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Select Your Reservation Date And Time to ",
                              style: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            TextSpan(
                              text:widget.locationName,
                              style: const TextStyle(color: Color(0xff93A7A7, ), fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Text(
                    '${_formatDateTime(selectedDateTime)}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffC4DFDF),

                    ),
                    onPressed: () => _selectDateTime(context),
                    child: const Text('Select Date And Time', style: TextStyle(color: Colors.white),),
                  ),
                  Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(top: 20, ),
                          child: Text("How Long Do Need Your Spot?", style: TextStyle(
                              fontSize: 20
                          ),)),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 42),
                            child: IconButton(onPressed: (){
                              setState(() {
                                counter++;
                              });
                            }, icon: const Icon(Icons.add)),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 40, right: 10),
                              child: Text("$counter Hours", style: const TextStyle(fontSize: 30),)),

                          Padding(
                            padding: const EdgeInsets.only(left: 45, bottom: 10),
                            child: IconButton(onPressed: (){
                              setState(() {
                                counter--;
                              });
                            }, icon: const Icon(Icons.minimize)),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffC4DFDF),
                        // background (button) color
                        foregroundColor: Colors
                            .white, // foreground (text) color
                      ),
                      onPressed: () {
                        print(_formatDateTime(selectedDateTime));
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) =>
                                ReserveParkingSpot(
                                  staticCustomerId: widget.staticCustomerId,
                                  locationId: widget.locationId,
                                  dateRev: _formatDateTime(selectedDateTime) ,
                                  period: counter, locationName: widget.locationName,
                                  locationLogo: widget.locationLogo,)));
                      },
                      child: const Text('Choose Your Spot'),
                    ),
                  ),
                ],
              ),
            ),),


    );
  }
}

