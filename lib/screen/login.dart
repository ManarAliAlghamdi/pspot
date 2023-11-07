import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/shared_methods.dart';
import 'Profile.dart';
import 'homeScreen.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _firstNameController = TextEditingController();
  final _passwordController = TextEditingController();
  int customerId = 0;
  String firstName = '';
  String password = '';

void initCustomerId(String firstName, String password)async{

  await getCustomerId(firstName, password).then((value) {
    if (1 != 0){
      print(value);
    }
      setState(() {
        customerId = value;
      });

  });
}
Future<void> _initCustomerId(String firstName, String password)async{


  await getCustomerId(firstName, password).then((value) {
    if (1 != 0){
      print(value);
    }
      customerId = value;
  });
}
//   @override
//   void dispose() async{
//
//    super.dispose();
//     _firstNameController.dispose();
//     _passwordController.dispose();
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 235, 235),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //Titler
              Text(
                'SIGN IN',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 40, fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 71, 69, 69)),
              ),
              //subtitle
              Text(
                'Welcome back ! Nice to see you again :-)',
                style: GoogleFonts.robotoCondensed(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),


              //E_textfield
            const SizedBox(height: 40,),
            TextField(
              cursorColor: Colors.black,
              controller: _firstNameController,
              onChanged: (text) {
                setState(() {
                  firstName = _firstNameController.text;
                });
              },

              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0.0),
                  labelText: 'First Name',
                  // hintText: 'Phone number',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,),
                  prefixIcon: const Icon(Icons.person_rounded, color: Colors.black, size: 18),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100, width: 2),
                    borderRadius: BorderRadius.circular(10),),

                  floatingLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                        )
                      ),
                    ),
              const SizedBox(height: 20,),
              TextField(cursorColor: Colors.black,
                controller: _passwordController,
                obscureText: true,
                onChanged: (text) {
                  setState(() {
                    password = _passwordController.text;
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.visibility_off,color: Colors.grey,),
                  contentPadding: const EdgeInsets.all(0.0),
                  labelText: 'Password',
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(Icons.key, color: Colors.black, size: 18, ),
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
              //signIN_Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  // onTap: signIn,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Color(0xffc4dde0))
                      ,
                    child: GestureDetector(
                      onTap: () async{
                       await _initCustomerId(firstName, password);

                         Navigator.push(context, MaterialPageRoute(
                             builder: (context)=> UserProfile(staticCustomerId: customerId,)
                         ));


                      },

                        child: Text(
                          'Sign in',
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
                  'Not yet a member ?',
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                   onTap: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(
                         builder: (context)=> const SignUp()));
                   },
                  child: Text(
                    'Sign up now', // توديني لصفحه التسجيل بس ما تفعلت
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
