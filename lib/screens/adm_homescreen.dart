import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/other_components.dart';
import '../components/available_flights_container.dart';
import 'adm_addflights.dart';
import '../components/buttons.dart';
import '../const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../details/flights.dart';


class AdmHomeScreen extends StatefulWidget {
  static String id = 'adm_homeScreen';

  @override
  State<AdmHomeScreen> createState() => _AdmHomeScreenState();
}

class _AdmHomeScreenState extends State<AdmHomeScreen> {

  //To convert info from Add page to the wiget
  String companyName ='';
  // String fromWhere ='';
  // String toWhere ='';
  // String depTime ='';
  // int price = 0;
  // String flightNum  ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/logo.png'),
        title: Text('Admin tuFly!',),
        actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.description),),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddFlightsScreen.id);
                },
              icon: Icon(Icons.add),),
            IconButton(
              onPressed: (){
               FirebaseAuth.instance.signOut();
                Navigator.pop(context);
            },
            icon: Icon(Icons.logout),),   
        ],
      ),
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('REGISTERED AIRLINES AND FLIGHTS', style: kSplashTextStyle.copyWith(fontSize: 18),),
                  IconButton(onPressed: (){}, icon: Icon(Icons.sort_rounded,color: kBorange,)),
                ],
              ),
              SizedBox(height: 10,),
              FlightStream(),
            ],
          ),
        ),
        ),
    );
  }
}


//For the StreamBuilder to fetch data from Firestore and Display
class FlightStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Flights').snapshots(),
      builder: (context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final flights = snapshot.data.docs;
        List <FlightsContainer> flightContainers = [];
        for(var flight in flights){
          final companyName = flight['company'];
          final fromWhere = flight['from'];
          final toWhere = flight['to'];
          final depTime = flight['time'];
          final price = flight['price'];
          final flightNum = flight['flight_no'];
          final flightsContainer = FlightsContainer(
            companyName, fromWhere, toWhere, depTime, price, flightNum,
            (){
              deleteFlight(snapshot.data.docs[flights.indexOf(flight)].id);
              }
            );
          flightContainers.add(flightsContainer);
        }
        return Expanded(
          child: ListView(
            children: flightContainers),);
      },
      );
  }
  //Delete Any of the flights from Firestore
  void deleteFlight(id) async {
    await FirebaseFirestore.instance.collection('Flights').doc(id).delete();
    Fluttertoast.showToast(msg: 'Flight has been deleted!', gravity: ToastGravity.TOP);
  }
}
