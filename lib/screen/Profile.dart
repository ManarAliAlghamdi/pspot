// import 'package:demo_project/main.dart';
import 'package:flutter/material.dart';
import 'homeScreen.dart';

import '../modules/fluid_nav_bar.dart';

class EditProfileUI extends StatefulWidget {
  const EditProfileUI({super.key});

  @override
  _EditProfileUIState createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  bool isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pspot'),
          backgroundColor: const Color(0xffC4DFDF),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=> const HomeScreen()));
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')))),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                color: Colors.amberAccent),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildTextField("Full Name", "Manar Alghamdi", false),
                buildTextField("Email", "manar07@hotmail.com", false),
                buildTextField("Password", "1234", true),
                buildTextField("Phone Number", "0550008921", false),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context)=> const HomeScreen()));

                      },
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text("Cancel",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.black)),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context)=> const HomeScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffC4DFDF),
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text("Save",
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 2,
                                color: Colors.white)))
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const SizedBox(height: 100, child: FluidNavBar()),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    })
                : null,
            contentPadding: const EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
      ),
    );
  }
}
