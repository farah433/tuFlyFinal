import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import '../components/buttons.dart';
import '../components/other_components.dart';
import '../screens/home_screen.dart';
import 'login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../registrations/email_verification.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  
  //to navigator to login Screen
  Future toLoginPage(){
    return Navigator.pushNamed(context, LoginScreen.id);
  }

  //Email & Password
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final pNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //For the Spinner
  bool showSpinner = false;

  //For the Spinner
  String? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Expanded(
                child: Hero( tag: 'logo', child: Image.asset('images/logo.png', scale: 4),)),
              Text('JOIN US!', style: kSplashTextStyle.copyWith(color: kBorange, decoration: TextDecoration.underline)),
              SizedBox(height: 15,),
              RegTextField('FIRST NAME', 'Enter your first name', false, fNameController,
              (value) => value!.isEmpty 
              ? 'Enter your first name': null,
              ),
              RegTextField('LAST NAME', 'Enter your last name', false, lNameController,
              (value) => value!.isEmpty
              ? 'Enter your last name': null,
              ),
              RegTextField('EMAIL ADDRESS', 'Enter email address', false, emailController,
              (email) => email != null && !EmailValidator.validate(email)
              ? 'Enter valid Email': null,
              ),
              RegTextField('PASSWORD', 'Enter password', true, passwordController,
              (value) => value != null && value.length < 6
              ? 'Enter password min. 6 characters': null,
              ),
              BottomButton('Sign In', kPorange, (){signup();}),
              SizedBox(height: 10,),
              TextspanOfLinks('Have an account? ', toLoginPage, 'Login'),
              SizedBox(height: 30,),
            ],
            ),
          ),
        ),
      ),
    );
  }

  //Function to SignUp
  Future signup() async {

    //show LoadingSpinner
    setState(() {
      showSpinner = true;
    });

    try{
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(), password: passwordController.text.trim());
      if(user != null && fNameController != null && lNameController != null){

        userId = FirebaseAuth.instance.currentUser!.uid;

        Navigator.pushNamed(context, EmailVerification.id);
      }
      addUserDetails(fNameController.text.trim(), lNameController.text.trim(), emailController.text.trim(), userId);
    } on FirebaseAuthException catch (error){
      Fluttertoast.showToast(msg: error.message!, gravity: ToastGravity.TOP);
      // Utils.showSnackBar(e.messengerKey);
      }
      //Disable LoadingSpinner
      setState(() {
        showSpinner = false;
      });
  }

  //Function to Add users details to Firestore
  Future addUserDetails(String firstName, String lastName, String userEmail, String? myId) async{
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'firstname': firstName,
      'lasttname': lastName,
      'email': userEmail,
      'uid': myId,
    });
  }

}


