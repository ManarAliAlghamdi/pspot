//import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homeScreen.dart';
import 'login.dart';
// import 'package:project3/screen/saved_places.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordControoler = TextEditingController();
  final _confirmpasswordControoler = TextEditingController();
  final _usernameController = TextEditingController();

  Future signup() async {
    if (passwordConfirm()){
      //await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim();
        password: _passwordControoler.text.trim();
      //);
      Navigator.of(context).pushNamed('/');
    }
  }
  bool passwordConfirm(){
    if (_passwordControoler.text.trim() ==
        _confirmpasswordControoler.text.trim()){
      return true;
    } else {
      return false;
    }

  }

  void openSignup(){
    Navigator.of(context).pushReplacementNamed('signup');
  }
  void saved(){
    Navigator.of(context).pushReplacementNamed('saved_places');
  }


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordControoler.dispose();
    _confirmpasswordControoler.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 235, 235),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //Title
              Text(
                'Sign Up',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 40, fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 71, 69, 69)),
              ),
              //subtitle
              Text(
                'Welcome Here you can Sign Up',
                style: GoogleFonts.robotoCondensed(fontSize: 18),
              ),
            const SizedBox(height: 40,),
            TextField(cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                labelText: 'User Name',
                hintText: 'Full Nmae',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: const Icon(Icons.supervised_user_circle_outlined, color: Colors.black, size: 18, ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                      ),
                    ),
            const SizedBox(height: 20,),
            TextField(cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                labelText: 'Phone NO',
                hintText: 'Phone Number',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: const Icon(Icons.phone_android, color: Colors.black, size: 18, ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                      ),
                    ),
            const SizedBox(height: 20,),
            TextField(cursorColor: Colors.black,
              controller: _passwordControoler ,
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.visibility_off,color: Colors.grey,),
                contentPadding: const EdgeInsets.all(0.0),
                labelText: 'Password',
                hintText: 'Password',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,

                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: const Icon(Icons.admin_panel_settings_sharp, color: Colors.black, size: 18, ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                      ),
                    ),

            const SizedBox(height: 20,),
            TextField(cursorColor: Colors.black,
              controller: _confirmpasswordControoler,
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.visibility_off,color: Colors.grey,),
                contentPadding: const EdgeInsets.all(0.0),
                labelText: 'Confirm',
                hintText: 'Confirm Password',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: const Icon(Icons.admin_panel_settings_sharp, color: Colors.black, size: 18, ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                      ),
                    ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: saved,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Color(0xffc4dde0))
                    ,
                        //borderRadius: BorderRadius.circular(12)),
                    child: GestureDetector(
                      onTap:(){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context)=> const HomeScreen()));
                      },
                        child: Text(
                          'Sign UP',
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //text_signUp
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'you already have an account?',
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context)=> const LoginScreen()));
                  },
                  child: Text(
                    'Sign in', // توديني لصفحه التسجيل بس ما تفعلت
                    style: GoogleFonts.robotoCondensed(
                      color: const Color.fromRGBO(113, 180, 177, 0.984),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ])
            ]),
          ),
        ),
      ),
    );
  }
}



