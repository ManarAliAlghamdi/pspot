import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '/models/locations_model.dart';
import '/models/shared_methods.dart';
class SectionControl extends StatefulWidget {
  final SectionModel sectionInfo;
  final List<ParkingSpotModel> filteredParkingSpots ;
  const SectionControl({Key? key, required this.sectionInfo, required this.filteredParkingSpots,required int staticCustomerId}) : super(key: key);


  @override
  State<SectionControl> createState() => _SectionControl();
}

class _SectionControl  extends State<SectionControl> {
  SectionModel sectionInfo = SectionModel(sectionId: 0, sectionDescription: '', sectionCapacity: 0, sectionAvailableSpots: 0, sectionFloorNo: 0);
  List<ParkingSpotModel> parkingSpots = [];
  late AnimationController controller;
   List<ParkingSpotModel> rightParkings = [];
   List<ParkingSpotModel> leftParkings = [];
  TextEditingController requestedHoursTextField = TextEditingController();
  TextEditingController subTotalTextField = TextEditingController();
  TextEditingController totalTextField = TextEditingController();
  TextEditingController taxTextField = TextEditingController();
  String paymentMethode = 'visa';
  Future<void> _refreshLocations() async {}

  Future<List<ParkingSpotModel>?> _showReservationDialog(int index) async
  {
    BuildContext dialogContext;
    dialogContext = context;
    List<ParkingSpotModel> returnedList = [];
    await showDialog(context: context, builder:(context)
    {
      return StatefulBuilder(
          builder: (dialogContext,
              state) {

            bool showDialogProcessing = false;
            return
              Dialog(

                  backgroundColor: Colors
                      .transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  elevation: 16,
                  child: Stack(
                    children: [
                      Visibility(
                        visible:!showDialogProcessing,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors
                                  .transparent,
                              borderRadius: BorderRadius
                                  .circular(
                                  20)),
                          height: MediaQuery
                              .sizeOf(
                              context)
                              .height -
                              200,
                          width: MediaQuery
                              .sizeOf(
                              context)
                              .width,
                          child: Stack(
                              children:
                              [
                                Container(
                                  height: MediaQuery.sizeOf(context).height - 230,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets
                                      .only(
                                      top: 10.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets
                                            .all(
                                            8.0),
                                        child: Container(
                                            width: MediaQuery
                                                .sizeOf(
                                                context)
                                                .width -
                                                100,
                                            height: 50,
                                            alignment: Alignment
                                                .center,
                                            color: Colors
                                                .grey,
                                            child:
                                            const Text(
                                              'Confirming',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight
                                                      .bold),
                                              textAlign: TextAlign
                                                  .center,)),
                                      ),
                                      const SizedBox(
                                        height: 20,),
                                      Container(
                                        width: MediaQuery
                                            .sizeOf(
                                            context)
                                            .width -
                                            100,
                                        child: Text(
                                          'Parking Spot No: : ${leftParkings[index]
                                              .parkingSpotDescription} ',
                                          style: const TextStyle(
                                              fontSize: 20),
                                          textAlign: TextAlign
                                              .start,),
                                      ),
                                      const SizedBox(
                                        height: 20,),

                                      Padding(
                                        padding: const EdgeInsets
                                            .all(
                                            8.0),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Requested Hours: ',
                                              style: TextStyle(
                                                  fontSize: 20),
                                              textAlign: TextAlign
                                                  .center,),
                                            GestureDetector(
                                              onTap: (){requestedHoursTextField.text = '${int.parse(requestedHoursTextField.text) + 1}';},
                                              child: Container(
                                                width: 30,height: 30,
                                                child: FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: Image.asset('assets/images/add.png')),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50,
                                              width: 50,
                                              child:
                                              TextField(
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                  keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                      decimal: false),
                                                  textAlign: TextAlign
                                                      .center,
                                                  textAlignVertical: TextAlignVertical
                                                      .center,
                                                  decoration: const InputDecoration(

                                                    border: OutlineInputBorder(),

                                                  ),
                                                  controller: requestedHoursTextField,
                                                  onChanged: (
                                                      text) {
                                                    taxTextField
                                                        .text =
                                                    '15%';
                                                    double subTotal = int
                                                        .parse(
                                                        requestedHoursTextField
                                                            .text) *
                                                        1.5;
                                                    subTotalTextField
                                                        .text =
                                                    '$subTotal';
                                                    totalTextField
                                                        .text =
                                                    '${subTotal +
                                                        (subTotal *
                                                            .15)}';
                                                  }),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                if(int.parse(requestedHoursTextField.text)>1)
                                                {
                                                  requestedHoursTextField.text = '${int.parse(requestedHoursTextField.text) - 1}';
                                                }

                                              },
                                              child: Container(
                                                width: 30,height: 30,
                                                child: FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: Image.asset('assets/images/minus.png')),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          height: 10,
                                          width: MediaQuery
                                              .sizeOf(
                                              context)
                                              .width),
                                      Padding(
                                        padding: const EdgeInsets
                                            .all(
                                            8.0),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Sub Total: ',
                                              style: TextStyle(
                                                  fontSize: 20),
                                              textAlign: TextAlign
                                                  .center,),
                                            SizedBox(
                                              height: 50,
                                              width: 100,
                                              child:
                                              TextField(
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                      decimal: false),
                                                  textAlign: TextAlign
                                                      .center,
                                                  textAlignVertical: TextAlignVertical
                                                      .center,
                                                  decoration: const InputDecoration(

                                                    border: OutlineInputBorder(),

                                                  ),
                                                  controller: subTotalTextField,
                                                  onChanged: (
                                                      text) {
                                                    taxTextField
                                                        .text =
                                                    '15%';
                                                    double subTotal = int
                                                        .parse(
                                                        requestedHoursTextField
                                                            .text) *
                                                        1.5;
                                                    subTotalTextField
                                                        .text =
                                                    '$subTotal';
                                                    totalTextField
                                                        .text =
                                                    '${subTotal +
                                                        (subTotal *
                                                            .15)}';
                                                  }),
                                            )

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          height: 10,
                                          width: MediaQuery
                                              .sizeOf(
                                              context)
                                              .width),
                                      Padding(
                                        padding: const EdgeInsets
                                            .all(
                                            8.0),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Tax Amount: ',
                                              style: TextStyle(
                                                  fontSize: 20),
                                              textAlign: TextAlign
                                                  .center,),
                                            SizedBox(
                                              height: 50,
                                              width: 100,
                                              child:
                                              TextField(
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                      decimal: false),
                                                  textAlign: TextAlign
                                                      .center,
                                                  textAlignVertical: TextAlignVertical
                                                      .center,
                                                  decoration: const InputDecoration(

                                                    border: OutlineInputBorder(),

                                                  ),
                                                  controller: taxTextField,
                                                  onChanged: (
                                                      text) {
                                                    taxTextField
                                                        .text =
                                                    '15%';
                                                    double subTotal = int
                                                        .parse(
                                                        requestedHoursTextField
                                                            .text) *
                                                        1.5;
                                                    subTotalTextField
                                                        .text =
                                                    '$subTotal';
                                                    totalTextField
                                                        .text =
                                                    '${subTotal +
                                                        (subTotal *
                                                            .15)}';
                                                  }),
                                            )

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          height: 10,
                                          width: MediaQuery
                                              .sizeOf(
                                              context)
                                              .width),
                                      const SizedBox(
                                        height: 10,),
                                      Padding(
                                        padding: const EdgeInsets
                                            .all(
                                            8.0),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Total amount: ',
                                              style: TextStyle(
                                                  fontSize: 20),
                                              textAlign: TextAlign
                                                  .center,),
                                            SizedBox(
                                              height: 50,
                                              width: MediaQuery
                                                  .sizeOf(
                                                  context)
                                                  .width -
                                                  240,
                                              child:
                                              TextField(
                                                  enabled: false,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                      decimal: false),
                                                  textAlign: TextAlign
                                                      .center,
                                                  textAlignVertical: TextAlignVertical
                                                      .center,
                                                  decoration: const InputDecoration(

                                                    border: OutlineInputBorder(),

                                                  ),
                                                  controller: totalTextField,
                                                  onChanged: (
                                                      text) {

                                                  }),
                                            )

                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,),
                                      Padding(
                                        padding: const EdgeInsets
                                            .all(
                                            8.0),
                                        child: Container(
                                            width: MediaQuery
                                                .sizeOf(
                                                context)
                                                .width -
                                                10,
                                            child: const Text(
                                              'Payment method:',
                                              style: TextStyle(
                                                  fontSize: 20),
                                              textAlign: TextAlign
                                                  .start,)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets
                                            .all(
                                            8.0),
                                        child: Row(
                                          children: [

                                            Container(width: 30,height: 30,
                                              child: FittedBox(
                                                fit: BoxFit.fill,
                                                child:  paymentMethode ==
                                                    'debit'?Image.asset('assets/images/checked.png') : Image.asset('assets/images/unChecked.png'),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  paymentMethode =
                                                  'debit';
                                                });
                                                updated(state);
                                              },
                                              child: SizedBox(
                                                width: 60,
                                                height: 50,

                                                child: FittedBox(
                                                  fit: BoxFit
                                                      .fill,
                                                  child: Image
                                                      .asset(
                                                      'assets/images/creditCard.png'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            SizedBox(width: 30,height: 30,
                                              child: FittedBox(
                                                fit: BoxFit.fill,
                                                child:  paymentMethode ==
                                                    'visa'?Image.asset('assets/images/checked.png') : Image.asset('assets/images/unChecked.png'),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  paymentMethode =
                                                  'visa';
                                                });
                                                updated(state);
                                              },
                                              child: Container(
                                                width: 60,
                                                height: 50,
                                                child: FittedBox(
                                                  fit: BoxFit
                                                      .fill,
                                                  child: Image
                                                      .asset(
                                                      'assets/images/visaCard.png'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Container(width: 30,height: 30,
                                              child: FittedBox(
                                                fit: BoxFit.fill,
                                                child:  paymentMethode ==
                                                    'cash'?Image.asset('assets/images/checked.png') : Image.asset('assets/images/unChecked.png'),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  paymentMethode =
                                                  'cash';
                                                });
                                                updated(state);
                                              },
                                              child: Container(
                                                width: 60,
                                                height: 50,
                                                child: FittedBox(
                                                  fit: BoxFit
                                                      .fill,
                                                  child: Image
                                                      .asset(
                                                      'assets/images/cash.png'),
                                                ),
                                              ),
                                            )
                                          ],),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets
                                      .only(
                                      top: MediaQuery
                                          .sizeOf(
                                          context)
                                          .height -
                                          270,
                                      right: 100,
                                      left: 100),
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        showDialogProcessing = true;
                                      });

                                      await updated(state).then((value)
                                      async {
                                        await reserveParkingSlot(leftParkings[index].parkingSpotId).then((value)
                                        {
                                          parkingSpots = value;
                                          fillParkingList();
                                          returnedList = leftParkings;
                                          return returnedList;
                                        });
                                      }


                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius
                                              .circular(
                                              40),
                                          color: Colors
                                              .transparent),
                                      height: 100,
                                      width: 100,
                                      child: FittedBox(
                                        fit: BoxFit
                                            .fill,
                                        child: Image
                                            .asset(
                                            'assets/images/confirm.png'),
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),
                      Visibility(
                          visible:showDialogProcessing,
                          child: Container(
                            width: 200,height: 200,
                            child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset('assets/images/processing.gif')),
                          ))
                    ],
                  )
              );
          });
    }).then((value) {
      Navigator.pop(dialogContext);
      return returnedList;});

  }


void fillParkingList() {

  rightParkings = parkingSpots.where((i) => i.parkingSpotDirection.toLowerCase() == 'right').toList();
  leftParkings = parkingSpots.where((i) => i.parkingSpotDirection.toLowerCase() == 'left').toList();
}
  @override
  Widget build(BuildContext context) {
    sectionInfo = widget.sectionInfo;
    parkingSpots = widget.filteredParkingSpots;
    fillParkingList();

    return GestureDetector(

      child: Container(child: Column(
        children: [
          const SizedBox(height: 10,),
          Row(children: [

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                          width:MediaQuery.of(context).size.width - 180,
                          child: Text( sectionInfo.sectionDescription,textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        SizedBox( // East and West parkings
                          height: MediaQuery.sizeOf(context).height - 300,
                          width: MediaQuery.sizeOf(context).width - 50,
                          child: Row(children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(width: 150, color: Colors.white,
                                child: RefreshIndicator(
                                  onRefresh: _refreshLocations,
                                  child: ListView.builder(
                                      itemCount:  leftParkings.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:(BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: (){getLocations(1);},
                                          child: Transform(
                                            alignment: FractionalOffset.center,
                                            transform: Matrix4.rotationZ(
                                              3.1415926535897932 / 4,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap:(){
                                                      setState(() {
                                                        leftParkings.map((item) {
                                                          item.isSelected = false;
                                                        }).toList();
                                                        rightParkings.map((item) {
                                                          item.isSelected = false;
                                                        }).toList();

                                                        leftParkings[index].isSelected = true;
                                                      });
                                                      BuildContext dialogContext;
                                                      showDialog(context: context, builder:(context)
                                                      {
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                state) {
                                                              dialogContext = context;
                                                              bool showDialogProcessing = false;
                                                              return
                                                                Dialog(

                                                                    backgroundColor: Colors
                                                                        .transparent,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius
                                                                            .circular(
                                                                            40)),
                                                                    elevation: 16,
                                                                    child:
                                                                    Stack(
                                                                      children:
                                                                      [
                                                                        Visibility(
                                                                          visible:!showDialogProcessing,
                                                                          child: Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors
                                                                                  .transparent,
                                                                              borderRadius: BorderRadius
                                                                                  .circular(
                                                                                  20)),
                                                                          height: MediaQuery
                                                                              .sizeOf(
                                                                              context)
                                                                              .height -
                                                                              200,
                                                                          width: MediaQuery
                                                                              .sizeOf(
                                                                              context)
                                                                              .width,
                                                                          child: Stack(
                                                                              children:
                                                                              [
                                                                                Container(
                                                                                  height: MediaQuery
                                                                                      .sizeOf(
                                                                                      context)
                                                                                      .height -
                                                                                      230,
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius
                                                                                          .circular(
                                                                                          20),
                                                                                      color: Colors
                                                                                          .white),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .only(
                                                                                      top: 10.0),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .all(
                                                                                            8.0),
                                                                                        child: Container(
                                                                                            width: MediaQuery
                                                                                                .sizeOf(
                                                                                                context)
                                                                                                .width -
                                                                                                100,
                                                                                            height: 50,
                                                                                            alignment: Alignment
                                                                                                .center,
                                                                                            color: Colors
                                                                                                .grey,
                                                                                            child:
                                                                                            const Text(
                                                                                              'Confirming',
                                                                                              style: TextStyle(
                                                                                                  fontSize: 20,
                                                                                                  fontWeight: FontWeight
                                                                                                      .bold),
                                                                                              textAlign: TextAlign
                                                                                                  .center,)),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 20,),
                                                                                      Container(
                                                                                        width: MediaQuery
                                                                                            .sizeOf(
                                                                                            context)
                                                                                            .width -
                                                                                            100,
                                                                                        child: Text(
                                                                                          'Parking Spot No: : ${leftParkings[index]
                                                                                              .parkingSpotDescription} ',
                                                                                          style: const TextStyle(
                                                                                              fontSize: 20),
                                                                                          textAlign: TextAlign
                                                                                              .start,),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 20,),

                                                                                      Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .all(
                                                                                            8.0),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            const Text(
                                                                                              'Requested Hours: ',
                                                                                              style: TextStyle(
                                                                                                  fontSize: 20),
                                                                                              textAlign: TextAlign
                                                                                                  .center,),
                                                                                            GestureDetector(
                                                                                              onTap: (){
                                                                                                requestedHoursTextField.text = '${int.parse(requestedHoursTextField.text) + 1}';},
                                                                                              child: Container(
                                                                                                width: 30,height: 30,
                                                                                                child: FittedBox(
                                                                                                    fit: BoxFit.fill,
                                                                                                    child: Image.asset('assets/images/add.png')),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 50,
                                                                                              width: 50,
                                                                                              child:
                                                                                              TextField(
                                                                                                  style: const TextStyle(
                                                                                                      fontSize: 20),
                                                                                                  keyboardType: const TextInputType
                                                                                                      .numberWithOptions(
                                                                                                      decimal: false),
                                                                                                  textAlign: TextAlign
                                                                                                      .center,
                                                                                                  textAlignVertical: TextAlignVertical
                                                                                                      .center,
                                                                                                  decoration: const InputDecoration(

                                                                                                    border: OutlineInputBorder(),

                                                                                                  ),
                                                                                                  controller: requestedHoursTextField,
                                                                                                  onChanged: (
                                                                                                      text) {
                                                                                                    taxTextField
                                                                                                        .text =
                                                                                                    '15%';
                                                                                                    double subTotal = int
                                                                                                        .parse(
                                                                                                        requestedHoursTextField
                                                                                                            .text) *
                                                                                                        1.5;
                                                                                                    subTotalTextField
                                                                                                        .text =
                                                                                                    '$subTotal';
                                                                                                    totalTextField
                                                                                                        .text =
                                                                                                    '${subTotal +
                                                                                                        (subTotal *
                                                                                                            .15)}';
                                                                                                  }),
                                                                                            ),
                                                                                            GestureDetector(
                                                                                              onTap: (){
                                                                                                if(int.parse(requestedHoursTextField.text)>1)
                                                                                                  {
                                                                                                    requestedHoursTextField.text = '${int.parse(requestedHoursTextField.text) - 1}';
                                                                                                  }

                                                                                                },
                                                                                              child: Container(
                                                                                                width: 30,height: 30,
                                                                                                child: FittedBox(
                                                                                                    fit: BoxFit.fill,
                                                                                                    child: Image.asset('assets/images/minus.png')),
                                                                                              ),
                                                                                            ),

                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                          height: 10,
                                                                                          width: MediaQuery
                                                                                              .sizeOf(
                                                                                              context)
                                                                                              .width),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .all(
                                                                                            8.0),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            const Text(
                                                                                              'Sub Total: ',
                                                                                              style: TextStyle(
                                                                                                  fontSize: 20),
                                                                                              textAlign: TextAlign
                                                                                                  .center,),
                                                                                            SizedBox(
                                                                                              height: 50,
                                                                                              width: 100,
                                                                                              child:
                                                                                              TextField(
                                                                                                  style: const TextStyle(
                                                                                                      fontSize: 20),
                                                                                                  keyboardType: TextInputType
                                                                                                      .numberWithOptions(
                                                                                                      decimal: false),
                                                                                                  textAlign: TextAlign
                                                                                                      .center,
                                                                                                  textAlignVertical: TextAlignVertical
                                                                                                      .center,
                                                                                                  decoration: const InputDecoration(

                                                                                                    border: OutlineInputBorder(),

                                                                                                  ),
                                                                                                  controller: subTotalTextField,
                                                                                                  onChanged: (
                                                                                                      text) {
                                                                                                    taxTextField
                                                                                                        .text =
                                                                                                    '15%';
                                                                                                    double subTotal = int
                                                                                                        .parse(
                                                                                                        requestedHoursTextField
                                                                                                            .text) *
                                                                                                        1.5;
                                                                                                    subTotalTextField
                                                                                                        .text =
                                                                                                    '$subTotal';
                                                                                                    totalTextField
                                                                                                        .text =
                                                                                                    '${subTotal +
                                                                                                        (subTotal *
                                                                                                            .15)}';
                                                                                                  }),
                                                                                            )

                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                          height: 10,
                                                                                          width: MediaQuery
                                                                                              .sizeOf(
                                                                                              context)
                                                                                              .width),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .all(
                                                                                            8.0),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            const Text(
                                                                                              'Tax Amount: ',
                                                                                              style: TextStyle(
                                                                                                  fontSize: 20),
                                                                                              textAlign: TextAlign
                                                                                                  .center,),
                                                                                            SizedBox(
                                                                                              height: 50,
                                                                                              width: 100,
                                                                                              child:
                                                                                              TextField(
                                                                                                  style: const TextStyle(
                                                                                                      fontSize: 20),
                                                                                                  keyboardType: TextInputType
                                                                                                      .numberWithOptions(
                                                                                                      decimal: false),
                                                                                                  textAlign: TextAlign
                                                                                                      .center,
                                                                                                  textAlignVertical: TextAlignVertical
                                                                                                      .center,
                                                                                                  decoration: const InputDecoration(

                                                                                                    border: OutlineInputBorder(),

                                                                                                  ),
                                                                                                  controller: taxTextField,
                                                                                                  onChanged: (
                                                                                                      text) {
                                                                                                    taxTextField
                                                                                                        .text =
                                                                                                    '15%';
                                                                                                    double subTotal = int
                                                                                                        .parse(
                                                                                                        requestedHoursTextField
                                                                                                            .text) *
                                                                                                        1.5;
                                                                                                    subTotalTextField
                                                                                                        .text =
                                                                                                    '$subTotal';
                                                                                                    totalTextField
                                                                                                        .text =
                                                                                                    '${subTotal +
                                                                                                        (subTotal *
                                                                                                            .15)}';
                                                                                                  }),
                                                                                            )

                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                          height: 10,
                                                                                          width: MediaQuery
                                                                                              .sizeOf(
                                                                                              context)
                                                                                              .width),
                                                                                      const SizedBox(
                                                                                        height: 10,),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .all(
                                                                                            8.0),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            const Text(
                                                                                              'Total amount: ',
                                                                                              style: TextStyle(
                                                                                                  fontSize: 20),
                                                                                              textAlign: TextAlign
                                                                                                  .center,),
                                                                                            SizedBox(
                                                                                              height: 50,
                                                                                              width: MediaQuery
                                                                                                  .sizeOf(
                                                                                                  context)
                                                                                                  .width -
                                                                                                  240,
                                                                                              child:
                                                                                              TextField(
                                                                                                  enabled: false,
                                                                                                  keyboardType: TextInputType
                                                                                                      .numberWithOptions(
                                                                                                      decimal: false),
                                                                                                  textAlign: TextAlign
                                                                                                      .center,
                                                                                                  textAlignVertical: TextAlignVertical
                                                                                                      .center,
                                                                                                  decoration: const InputDecoration(

                                                                                                    border: OutlineInputBorder(),

                                                                                                  ),
                                                                                                  controller: totalTextField,
                                                                                                  onChanged: (
                                                                                                      text) {

                                                                                                  }),
                                                                                            )

                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 10,),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .all(
                                                                                            8.0),
                                                                                        child: Container(
                                                                                            width: MediaQuery
                                                                                                .sizeOf(
                                                                                                context)
                                                                                                .width -
                                                                                                10,
                                                                                            child: const Text(
                                                                                              'Payment method:',
                                                                                              style: TextStyle(
                                                                                                  fontSize: 20),
                                                                                              textAlign: TextAlign
                                                                                                  .start,)),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .all(
                                                                                            8.0),
                                                                                        child: Row(
                                                                                          children: [

                                                                                            Container(width: 30,height: 30,
                                                                                              child: FittedBox(
                                                                                                fit: BoxFit.fill,
                                                                                                child:  paymentMethode ==
                                                                                                    'debit'?Image.asset('assets/images/checked.png') : Image.asset('assets/images/unChecked.png'),
                                                                                              ),
                                                                                            ),
                                                                                            GestureDetector(
                                                                                              onTap: () {
                                                                                                setState(() {
                                                                                                  paymentMethode =
                                                                                                  'debit';
                                                                                                });
                                                                                                updated(state);
                                                                                              },
                                                                                              child: SizedBox(
                                                                                                width: 60,
                                                                                                height: 50,

                                                                                                child: FittedBox(
                                                                                                  fit: BoxFit
                                                                                                      .fill,
                                                                                                  child: Image
                                                                                                      .asset(
                                                                                                      'assets/images/creditCard.png'),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(width: 5,),
                                                                                            SizedBox(width: 30,height: 30,
                                                                                              child: FittedBox(
                                                                                                fit: BoxFit.fill,
                                                                                                child:  paymentMethode ==
                                                                                                    'visa'?Image.asset('assets/images/checked.png') : Image.asset('assets/images/unChecked.png'),
                                                                                              ),
                                                                                            ),
                                                                                            GestureDetector(
                                                                                              onTap: () {
                                                                                                setState(() {
                                                                                                  paymentMethode =
                                                                                                  'visa';
                                                                                                });
                                                                                                updated(state);
                                                                                              },
                                                                                              child: Container(
                                                                                                width: 60,
                                                                                                height: 50,
                                                                                                child: FittedBox(
                                                                                                  fit: BoxFit
                                                                                                      .fill,
                                                                                                  child: Image
                                                                                                      .asset(
                                                                                                      'assets/images/visaCard.png'),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(width: 5,),
                                                                                            Container(width: 30,height: 30,
                                                                                            child: FittedBox(
                                                                                              fit: BoxFit.fill,
                                                                                              child:  paymentMethode ==
                                                                                              'cash'?Image.asset('assets/images/checked.png') : Image.asset('assets/images/unChecked.png'),
                                                                                            ),
                                                                                            ),
                                                                                            GestureDetector(
                                                                                              onTap: () {
                                                                                                setState(() {
                                                                                                  paymentMethode =
                                                                                                  'cash';
                                                                                                });
                                                                                                updated(state);
                                                                                              },
                                                                                              child: Container(
                                                                                                width: 60,
                                                                                                height: 50,
                                                                                                child: FittedBox(
                                                                                                  fit: BoxFit
                                                                                                      .fill,
                                                                                                  child: Image
                                                                                                      .asset(
                                                                                                      'assets/images/cash.png'),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets
                                                                                      .only(
                                                                                      top: MediaQuery
                                                                                          .sizeOf(
                                                                                          context)
                                                                                          .height -
                                                                                          270,
                                                                                      right: 100,
                                                                                      left: 100),
                                                                                  child: GestureDetector(
                                                                                    onTap: () async {
                                                                                      setState(() {
                                                                                        showDialogProcessing = true;
                                                                                      });

                                                                                      await updated(state).then((value)
                                                                                      async {
                                                                                        await reserveParkingSlot(leftParkings[index].parkingSpotId).then((value)
                                                                                        {
                                                                                          parkingSpots = value;
                                                                                          fillParkingList();
                                                                                          Navigator.pop(dialogContext);
                                                                                          setState(() {

                                                                                          });
                                                                                        });
                                                                                      }


                                                                                      );
                                                                                      },
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius
                                                                                              .circular(
                                                                                              40),
                                                                                          color: Colors
                                                                                              .transparent),
                                                                                      height: 100,
                                                                                      width: 100,
                                                                                      child: FittedBox(
                                                                                        fit: BoxFit
                                                                                            .fill,
                                                                                        child: Image
                                                                                            .asset(
                                                                                            'assets/images/confirm.png'),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ]
                                                                          ),
                                                                      ),
                                                                        ),
                                                                      Visibility(
                                                                          visible:showDialogProcessing,
                                                                          child: Container(
                                                                            width: 200,height: 200,
                                                                        child: FittedBox(
                                                                            fit: BoxFit.fill,
                                                                            child: Image.asset('assets/images/processing.gif')),
                                                                      ))
                                                                      ],
                                                                    )
                                                                );
                                                            });
                                                      }).then((value)
                                                      {
                                                        setState(() {
                                                        });
                                                      }

                                                      );
                                                      requestedHoursTextField.text = "1";
                                                    },
                                                    child: Container(
                                                    height: 100,
                                                    color: leftParkings == null || leftParkings.isEmpty? null : leftParkings[index].isSelected? Colors.blue:null,
                                                    child: FittedBox(
                                                        fit: BoxFit.fill,
                                                        child:leftParkings == null || leftParkings.isEmpty? null : leftParkings[index].parkingSpotStatus == false? Image.asset('assets/images/reservedParking.png'):
                                                        leftParkings[index].isSNSpot == 'yes'? Image.asset('assets/images/snParking.png') : Image.asset('assets/images/emptyParking.png'))
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(20.0),
                                                    child: Text(leftParkings == null || leftParkings.isEmpty? '' : leftParkings[index].parkingSpotDescription,style: TextStyle(fontSize: 30),),
                                                  ),
                                             ] ),
                                            ),
                                          ),
                                        );}
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container(color: const Color.fromRGBO(75, 75, 75, 1),)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(width: 150, color: Colors.white,
                                child: RefreshIndicator(
                                  onRefresh: _refreshLocations,
                                  child: ListView.builder(
                                      itemCount:  rightParkings.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:(BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: (){setState(() {
                                            for (var map in rightParkings) {

                                              leftParkings.map((item) {
                                                item.isSelected = false;
                                              }).toList();
                                               rightParkings.map((item) {
                                                 item.isSelected = false;
                                                }).toList();

                                            }
                                           rightParkings[index].isSelected = true;
                                          });},
                                          child: Transform(
                                            alignment: FractionalOffset.center,
                                            transform: Matrix4.rotationZ(
                                              -3.1415926535897932 / 4,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Stack(
                                                  children: [
                                                    GestureDetector(
                                                      onTap:(){

                                                      },
                                                      child: Container(
                                                          height: 100,
                                                          color: rightParkings == null || rightParkings.isEmpty ?  null : rightParkings[index].isSelected? Colors.orange:null,
                                                          child: FittedBox(
                                                              fit: BoxFit.fill,
                                                              child:rightParkings == null || rightParkings.isEmpty ?  null : rightParkings[index].parkingSpotStatus == false? Image.asset('assets/images/reservedParking.png'):
                                                            rightParkings[index].isSNSpot == 'yes'? Image.asset('assets/images/snParking.png') :  Image.asset('assets/images/emptyParking.png'))
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Text(rightParkings == null || rightParkings.isEmpty ?  '' : rightParkings[index].parkingSpotDescription,style: TextStyle(fontSize: 30),),
                                                    ),
                                                  ] ), ),
                                          ),
                                        );}
                                  ),
                                ),
                              ),
                            ),
                          ],),
                        ),

                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],),
          const SizedBox(height: 10,),
        ],
      ),

      ) ,);
  }

}