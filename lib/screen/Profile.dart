// import 'package:demo_project/main.dart';
import 'package:flutter/material.dart';
import '../models/customers_information.dart';
import 'homeScreen.dart';
import '/models/shared_methods.dart';
import '../modules/fluid_nav_bar.dart';

class UserProfile extends StatefulWidget {
  final int staticCustomerId;
  const UserProfile ({Key? key, required this.staticCustomerId}) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List <CustomerInformation> customerInfo = [];
  int staticCustomerId = 0;
  bool showProcessing = true;
  bool showCustomerInformation = false;

  void initCustomerProfile(int customerId) async {
    customerInfo = [];
    await getCustomerInformation(customerId).then((value) {
      setState(() {
        customerInfo = value;
        showProcessing = false;
        showCustomerInformation = true;
      });
    });
  }

  Future<void> _refreshCustomerInformation() async {
    setState(() {
      showProcessing = true;
      showCustomerInformation = false;
    });
    await getCustomerInformation(widget.staticCustomerId).then((value) {
      setState(() {
        customerInfo = value;
        showProcessing = false;
        showCustomerInformation = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCustomerProfile(widget.staticCustomerId);
  }

  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    staticCustomerId = widget.staticCustomerId;
    print('profile: $staticCustomerId');


    return Scaffold(
      appBar: AppBar(

        title: const Text('Your Profile'),
        backgroundColor: const Color(0xffC4DFDF),

      ),

      body: Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(

            child: Center(

              child: SizedBox(

                  height: 400,
                  child: Column(
                      children: [
                        Visibility(
                            visible: showProcessing,
                            child: Center(
                              child: Image.asset(
                                  'assets/images/processing.gif'),
                            )),
                        // Locations
                         Visibility(
                            visible: showCustomerInformation,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 350,
                                    width: 370,
                                    child: RefreshIndicator(
                                      onRefresh: _refreshCustomerInformation,
                                      child: ListView.builder(
                                          itemCount: customerInfo.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Center(
                                              child: Container(
                                                  height: 350,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .circular(10.0),

                                                  ),
                                                  child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,),
                                                        Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .all(5.0),
                                                                child: Column(

                                                                    children: [
                                                                      Container(

                                                                        margin: const EdgeInsets.only(top: 20.0),
                                                                        // Adjust the top margin as needed
                                                                        child: Row(
                                                                            children: [
                                                                              const Icon(Icons.person, color: Colors.amber, size: 20),
                                                                              const SizedBox(width: 20,),
                                                                              RichText(
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    const TextSpan(
                                                                                      text: "First Name: ",
                                                                                      style: TextStyle(
                                                                                          fontSize: 20,
                                                                                          color: Colors
                                                                                              .black),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: customerInfo[index]
                                                                                          .customerFirstName,
                                                                                      style: const TextStyle(
                                                                                          fontSize: 18,
                                                                                          color: Color(0xff93A7A7)
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 20,),
                                                                      Row(
                                                                          children: [
                                                                            const Icon(Icons.person, color: Colors.amber, size: 20),
                                                                            const SizedBox(width: 20,),
                                                                            RichText(
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  const TextSpan(
                                                                                    text: "Last Name: ",
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors
                                                                                            .black),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: customerInfo[index]
                                                                                        .customerLastName,
                                                                                    style: const TextStyle(
                                                                                        fontSize: 18,
                                                                                        color: Color(
                                                                                            0xff93A7A7)
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ]
                                                                      ),

                                                                      const SizedBox(
                                                                        height: 20,),

                                                                      Row(
                                                                          children: [
                                                                            const Icon(Icons.email, color: Colors.amber, size: 20),
                                                                            const SizedBox(width: 15,),
                                                                            RichText(
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  const TextSpan(
                                                                                    text: "E-mail: ",
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors
                                                                                            .black),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: customerInfo[index]
                                                                                        .customerEmail,
                                                                                    style: const TextStyle(
                                                                                        fontSize: 18,
                                                                                        color: Color(
                                                                                            0xff93A7A7)
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ]
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 20,),
                                                                      Row(
                                                                        children: [
                                                                          const Icon(Icons.phone, color: Colors.amber, size: 20),
                                                                          const SizedBox(width: 20,),
                                                                          RichText(
                                                                            text: TextSpan(
                                                                              children: [
                                                                                const TextSpan(
                                                                                  text: "Phone Number: ",
                                                                                  style: TextStyle(
                                                                                      fontSize: 20,
                                                                                      color: Colors
                                                                                          .black),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: customerInfo[index]
                                                                                      .customerPhoneNumber,
                                                                                  style: const TextStyle(
                                                                                      fontSize: 18,
                                                                                      color: Color(
                                                                                          0xff93A7A7)
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 20,),
                                                                      Row(
                                                                          children: [
                                                                            const Icon(Icons.password, color: Colors.amber, size: 20),
                                                                            const SizedBox(width: 20,),
                                                                            RichText(
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  const TextSpan(
                                                                                    text: "Account Password: ",
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors
                                                                                            .black),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: customerInfo[index]
                                                                                        .customerPassword,
                                                                                    style: const TextStyle(
                                                                                        fontSize: 18,
                                                                                        color: Color(
                                                                                            0xff93A7A7)
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ]
                                                                      ),

                                                                    ]),
                                                              ),
                                                            ]
                                                        )
                                                      ]
                                                  )
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                  )
                                ]
                            )
                        ),

                      ])
              ),
            )
        ),

      ),
      bottomNavigationBar: SizedBox(height: 100, child: FluidNavBar(staticCustomerId: staticCustomerId,)),
    );
  }
}

//   Widget buildTextField(
//       String labelText, String placeholder, bool isPasswordTextField) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 30),
//       child: TextField(
//         obscureText: isPasswordTextField ? isObscurePassword : false,
//         decoration: InputDecoration(
//
//             suffixIcon: isPasswordTextField
//                 ? IconButton(
//                     icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
//                     onPressed: () {
//                       setState(() {
//                         isObscurePassword = !isObscurePassword;
//                       });
//                     })
//                 : null,
//             contentPadding: const EdgeInsets.only(bottom: 5),
//             labelText: labelText,
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: placeholder,
//             hintStyle: const TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)
//         ),
//       ),
//     );
//   }
// }
