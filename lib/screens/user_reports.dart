import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/other_components.dart';
import '../const.dart';

class UserReportsScreen extends StatefulWidget {
  static String id = 'userReports';

  @override
  State<UserReportsScreen> createState() => _UserReportsScreenState();
}

class _UserReportsScreenState extends State<UserReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Trip History'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('History of Trips', style: kSplashTextStyle.copyWith(fontSize: 18),),
            ),
            UserTripsFlightStream(),
          ],
          ),
      ),
    );
  }
}

//For the StreamBuilder to fetch data from Firestore and Display Users Trips
class UserTripsFlightStream extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('TripUsers').doc(FirebaseAuth.instance.currentUser!.uid).collection('trips').snapshots(),
      builder: (context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final trips = snapshot.data.docs;
        List <LastTripWithData> todaysFlightsContainers = [];
        for(var trip in trips){
          final companyName = trip['company'];
          final fromWhere = trip['from'];
          final toWhere = trip['to'];
          final depTime = trip['time'];
          final depDate = trip['date'];
          final seat = trip['seats'];
          final flightNum = trip['flight_no'];
          final todaysFlightsContainer = LastTripWithData(companyName, flightNum, fromWhere, toWhere, depDate, depTime, seat);
          todaysFlightsContainers.add(todaysFlightsContainer);
        }
        return Expanded(
          child: ListView(
            children: todaysFlightsContainers),
        );
      },
      );
  }
}