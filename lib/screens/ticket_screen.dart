import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import'../screens/home_screen.dart';

import '../components/buttons.dart';
import '../const.dart';

class TicketScreen extends StatefulWidget {
  static String id = "ticketScreen";

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {

  String? fullname;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    print(fullname);
  }

  //get users data
  void getUserData()async {
    await FirebaseFirestore.instance.collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid).
    get().then((value) => fullname = value.data()!['firstname']);

    setState(() {
      fullname;
    });
    print(fullname);
  }

  @override
  Widget build(BuildContext context) {

    //Passing data from previous screen 
    final routeData = ModalRoute.of(context)!.settings.arguments as Map;
    final newCompanyName = routeData['companyName'];
    final newToWhere = routeData['toWhere'];
    final newFromWhere = routeData['fromWhere'];
    final newDepTime = routeData['depTime'];
    final newPrice = routeData['price'];
    final newFlightNum = routeData['flightNum'];
    final newNewDate = routeData['newDate'];
    final newSeats = routeData['seats'];
    
    return Scaffold(
      appBar: AppBar(
        title: Text('My Ticket'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Image.asset('images/logo.png', scale: 5,),
                Text('     tuFly', style: kfightName,),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(newFromWhere, style: kBodyTextStyle,),
                    Icon(Icons.flight_land_rounded, color: kBorange,),
                    Text(newToWhere, style: kBodyTextStyle,),
                    Text(newDepTime, style: kBodyTextStyle,),
                  ],
                ),
                SizedBox(height: 10,),
                Text('TRAVELLER', style: kfightName,),
                Text('Name : $fullname', style: kBodyTextStyle,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('DATE', style: kfightName,),
                        Text(newNewDate, style: kBodyTextStyle,),
                        
                      ],
                    ),
                    Column(
                      children: [
                        Text('FLIGHT NO.', style: kfightName,),
                        Text('jhkgtu', style: kBodyTextStyle,),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: kPorange.withAlpha(100),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset('images/$newCompanyName.png'),
                        ),
                      ),
                      Text(newCompanyName, style: kBodyTextStyle,),
                        
                      ],
                    ),
                    Column(
                      children: [
                        Text('SEATS', style: kfightName,),
                        Text(newSeats, style: kBodyTextStyle,),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text('Thanks for choosing our service!', style: kBodyTextStyle.copyWith(color: Colors.grey),),
                SizedBox(height: 5,),
                Text('Contact the branch for any clarifications.', style: kBodyTextStyle.copyWith(color: Colors.grey),),
                SizedBox(height: 15,),
                BottomButton('BACK TO HOMESCREEN', kBorange, (){
                  Navigator.pushNamed(context, HomeScreen.id);
                }),
              ],
            ),
            ),
        ),
      ),
    );
  }

}