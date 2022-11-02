import 'package:flutter/material.dart';
import 'package:tufly/details/flights.dart';
import '../components/buttons.dart';
import '../components/other_components.dart';
import '../const.dart';
import '../screens/select_seat.dart';
import'../screens/choose_seat.dart';
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
    final newPassangers = routeData['passangers'];

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
            
            AvailableFlightsContainer('Fly540', newFromWhere, newToWhere, '9PM', '7000', 'JHY75yOO', (){
              Navigator.pushNamed(context, SelectSeats.id, arguments: {
                'flightCompany': flightCompany[0],
                'date' : newDate,
                'passangers': newPassangers,
                'fromWhere':newFromWhere,
                'toWhere':newToWhere,
              });
            }),
            AvailableFlightStream(newFromWhere, newToWhere),
          ],
          ),
      ),
    );
  }
}

//For the StreamBuilder to fetch data from Firestore and Display for Available Flights
class AvailableFlightStream extends StatelessWidget {

  AvailableFlightStream(this.fromWhere, this.toWhere);
  String fromWhere ;
   String toWhere ;

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
          final availableFlightsContainer = AvailableFlightsContainer(companyName, fromWhere, toWhere, depTime, price, flightNum, (){Navigator.pushNamed(context, ChooseSeat.id);});
          availableFlightContainers.add(availableFlightsContainer);
        }
        return Expanded(
          child: ListView(
            children: availableFlightContainers),);
      },
      );
  }
}