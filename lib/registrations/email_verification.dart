import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tufly/screens/home_screen.dart';
import '../components/buttons.dart';
import '../const.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailVerification extends StatefulWidget {
  static String id = 'email_verification';

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {

  //Check if email is verified
  bool isEmailVerified = false;

  //Check if user can request for another email verification link
  bool canResendEmail = false;

  //Check every 3sec if email is verified
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3),
      (timer) => checkEmailVerification(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  //Check Email Verification
  Future checkEmailVerification()async{
    //Reload the user before calling isEmailVerified
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() { isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;});
    //Cancel timer so as theCheckEmailVerification is not executed any more
    if(isEmailVerified){timer?.cancel();}
  }

  //Send Verification Email
  Future sendVerificationEmail()async {
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {canResendEmail = false;});
      await Future.delayed(Duration(seconds: 5));
      setState(() {canResendEmail = true;});

    }on FirebaseAuthException catch (error){
      Fluttertoast.showToast(msg: error.message!, gravity: ToastGravity.TOP);
      }
  }


  @override
  Widget build(BuildContext context) => isEmailVerified
  ? HomeScreen()
  : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('A verification email has been sent to your Email Address.', style: kfightNameB.copyWith(color: Colors.grey), textAlign: TextAlign.center,),
              SizedBox(height: 10),
              BottomButton('Resend Email', kPorange, (){canResendEmail? sendVerificationEmail(): null;}),
              SizedBox(height: 10),
              BottomButton('Cancel', kBorange.withAlpha(200), (){FirebaseAuth.instance.signOut();}),
            ],
          ),
        ),
      ),
    );
}