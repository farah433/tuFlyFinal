import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/splash_screen.dart';
import '../registrations/signup_screen.dart';
import '../registrations/login_screen.dart';
import '../registrations/email_verification.dart';
import '../screens/home_screen.dart';
import '../registrations/forgot_password.dart';
import 'screens/user_reports.dart';
import '../screens/flight_search.dart';
import '../screens/available_flights.dart';
import '../screens/adm_homescreen.dart';
import '../screens/adm_addflights.dart';
import'../screens/choose_seat.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // scaffoldMessengerKey: Utils.messengerKey,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(color: Colors.orange),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ForgotPassword.id: (context) => ForgotPassword(),
        UserReportsScreen.id: (context) => UserReportsScreen(),
        FlightSearch.id: (context) => FlightSearch(),
        AvailabeFlights.id: (context) => AvailabeFlights(),
        AdmHomeScreen.id: (context) => AdmHomeScreen(),
        EmailVerification.id: (context) => EmailVerification(),
        AddFlightsScreen.id: (context) => AddFlightsScreen(),
        ChooseSeat.id:(context) => ChooseSeat(),
      },
    );
  }
}
