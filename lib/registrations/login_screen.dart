import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import '../const.dart';
import '../components/other_components.dart';
import '../components/buttons.dart';
import 'signup_screen.dart';
import '../screens/home_screen.dart';
import 'forgot_password.dart';
import '../screens/adm_homescreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //For the Spinner
  bool showSpinner = false;
  
  //to navigator to signup and ForgetPassword screens
  Future toSignupPage(){
    return Navigator.pushNamed(context, SignUpScreen.id);
  }
  Future tofogotpasswordpage(){
    return Navigator.pushNamed(context, ForgotPassword.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Hero( tag: 'logo', child: Image.asset('images/logo.png', scale: 4,),)),
                SizedBox(height: 50,),
                Text('WELCOME BACK!', style: kSplashTextStyle.copyWith(color: kBorange, decoration: TextDecoration.underline)),
                SizedBox(height: 15,),
                LoginTextField('EMAIL ADDRESS', 'Enter your email address', false, emailController),
                LoginTextField('PASSWORD', 'Enter your password', true, passwordController),
      
                //Change the onPressed to direct to homeScreen not the Adm Screen
                BottomButton('Log In', kPorange, (){login();}),
                SizedBox(height: 10,),
                Center(
                  child: LinkTextspan('Forgot password? ', tofogotpasswordpage, 20),
                ),
                SizedBox(height: 30,),
                TextspanOfLinks('Have no account? ', toSignupPage, 'Signup'),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Function to allow Login
  Future login() async {

    //show LoadingSpinner
    setState(() {
      showSpinner = true;
    });

    try{
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(), password: passwordController.text.trim());
      if(user != null && emailController.text.trim() == 'farahdahir@gmail.com' && passwordController.text.trim() == '123456'){
        Navigator.pushNamed(context, AdmHomeScreen.id);
      }
      else if(user != null){
        // Navigator.pushNamed(context, AdmHomeScreen.id);
        Navigator.pushNamed(context, HomeScreen.id);
      }
    }on FirebaseAuthException catch (error){
      Fluttertoast.showToast(msg: error.message!, gravity: ToastGravity.TOP);
      // Utils.showSnackBar(e.messengerKey);
      }
      //Disable LoadingSpinner
      setState(() {
        showSpinner = false;
      });
      passwordController.clear();
  }

}
