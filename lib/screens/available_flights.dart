import 'package:flutter/material.dart';
import 'package:tufly/details/flights.dart';
import '../components/buttons.dart';
import '../components/other_components.dart';
import '../const.dart';
import'../screens/select_seat.dart';
import '../components/available_flights_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvailabeFlights extends StatefulWidget {
  static String id = 'available_flights_screen';

  @override
  State<AvailabeFlights> createState() => _AvailabeFlightsState();
}

class _AvailabeFlightsState extends State<AvailabeFlights> {

  //SET THE price, flightNo., time....

  @override
  Widget build(BuildContext context) {

    final routeData = ModalRoute.of(context)!.settings.arguments as Map;
    final newFromWhere = routeData['fromWhere'];
    final newToWhere = routeData['toWhere'];
    final newDate = routeData['selecteddate'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Available Flights'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('Flight(s) available on $newDate', style: kSplashTextStyle.copyWith(fontSize: 18),),
            ),
            AvailableFlightStream(newFromWhere, newToWhere, newDate),
          ],
          ),
      ),
    );
  }
}

//For the StreamBuilder to fetch data from Firestore and Display for Available Flights
class AvailableFlightStream extends StatelessWidget {

  AvailableFlightStream(this.fromWhere, this.toWhere, this.newDate);
  String fromWhere ;
   String toWhere ;
   String newDate;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Flights').where('from' ,isEqualTo: fromWhere).where('to', isEqualTo: toWhere).snapshots(),
      builder: (context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final flights = snapshot.data.docs;
        List <AvailableFlightsContainer> availableFlightContainers = [];
        for(var flight in flights){
          final companyName = flight['company'];
          final fromWhere = flight['from'];
          final toWhere = flight['to'];
          final depTime = flight['time'];
          final price = flight['price'];
          final flightNum = flight['flight_no'];
          final availableFlightsContainer = AvailableFlightsContainer(companyName, fromWhere, toWhere, depTime, price, flightNum, (){
            //Pushing Arguments to the ChooseSeat screen
            Navigator.pushNamed(context, SelectSeat.id, arguments: {
              'companyName' : companyName,
              'fromWhere' : fromWhere,
              'toWhere' : toWhere,
              'depTime' : depTime,
              'newDate' : newDate,
              'price': price,
              'flightNum' : flightNum,
            });});
          availableFlightContainers.add(availableFlightsContainer);
        }
        return Expanded(
          child: ListView(
            children: availableFlightContainers),);
      },
      );
  }
}