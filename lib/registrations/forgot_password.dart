import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tufly/components/other_components.dart';
import '../const.dart';
import '../components/buttons.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';



class ForgotPassword extends StatefulWidget {
  static String id = 'forgotpassword';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  //Email controller
  final emailController = TextEditingController();

  //Show Spinner
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero( tag: 'logo', child: Image.asset('images/logo.png', height: 100,),),
                SizedBox(height: 30,),
                Text('Kindly enter the email address registered under your account.', style: kSplashTextStyle.copyWith(fontSize: 16, color: Colors.grey),),
                SizedBox(height: 30,),
                RegTextField('EMAIL ADDRESS', 'Enter email address', false, emailController,
                (email) => email != null && !EmailValidator.validate(email)
                ? 'Enter valid Email': null,              
                ),
                BottomButton('Reset password', kPorange, (){passwordReset();}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Function to allow Login
  Future passwordReset() async {

    //show LoadingSpinner
    setState(() {
      showSpinner = true;
    });

    try{
      final user = await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailController.text.trim());
      Fluttertoast.showToast(msg: 'Link has been send to your Email', gravity: ToastGravity.TOP);      
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error){
      Fluttertoast.showToast(msg: error.message!, gravity: ToastGravity.TOP);
      // Utils.showSnackBar(e.messengerKey);
      }
      //Disable LoadingSpinner
      setState(() {
        showSpinner = false;
      });
  }

}