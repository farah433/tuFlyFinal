import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tufly/components/available_flights_container.dart';
import 'package:tufly/screens/select_seat.dart';
import '/const.dart';
import '../components/other_components.dart';
import 'user_reports.dart';
import '../screens/flight_search.dart';
import '../details/flights.dart';
import '../details/county.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool hasTrip = false;

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   String? name1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getUserData();
    getUser4();

  }

  //get users data
  void getUserData()async {
    await FirebaseFirestore.instance.collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid).
    get().then((value) => name1 = value.data()!['firstname']);

    setState(() {
       name1;
    });
    print(name1);
  }

  // Future<void> _getUserDetails() async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //
  //   if(doc.exists) { // this will check availability of document
  //     name1 = doc.data()!['firstname'].toString();
  //
  //   }else{
  //    name1 = "User";
  //   }
  //   setState((){});
  // }
  // getUser ()async{
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   await FirebaseFirestore.instance.collection('users').doc(uid).get().then((user) {
  //     user.docs.forEach((result) {
  //       name1= result.data()['firstname'];
  //
  //     });
  // }
  // }
  //
  getUser4(){
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          var value = data!['firstname'];

          setState(() {
            name1 = value;
          });
          print(value);
          return value;
        }
        return const Text('User');
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPorange,
        leading: Image.asset('images/logo.png'),
        title: Text(
          'Good morning, $name1',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, UserReportsScreen.id);
              },
              icon: Icon(
                Icons.description,
              )),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: Icon(
                Icons.logout,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: kPorange,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, FlightSearch.id, arguments: countiesListTo[0],);
          }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'OUR LOCAL AIRLINES',
                  style: kSplashTextStyle.copyWith(fontSize: 20),
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TopMenuBoxes(flightCompany[0], (){_launchURL('www.jambojet.com');}),
                        TopMenuBoxes(flightCompany[1], (){_launchURL('www.skywardexpress.co.ke');}),
                        TopMenuBoxes(flightCompany[2], (){_launchURL('www.fly540.com');}),
                        TopMenuBoxes(flightCompany[3], (){_launchURL('www.flysafarilink.com');}),
                        TopMenuBoxes(flightCompany[4], (){_launchURL('www.flyrenegadeair.com');}),
                        TopMenuBoxes(flightCompany[5], (){_launchURL('www.fly748.com');}),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'POPULAR DESTINATION',
                  style: kSplashTextStyle.copyWith(fontSize: 20),
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (context, index) => Row(
                      children: [
                        HomeReusableContainer(150, 220, countiesListTo[30], (){Navigator.pushNamed(context, FlightSearch.id);}),
                        HomeReusableContainer(150, 220, countiesListTo[28], (){Navigator.pushNamed(context, FlightSearch.id);}),
                        HomeReusableContainer(150, 220, countiesListTo[31], (){Navigator.pushNamed(context, FlightSearch.id);}),
                        HomeReusableContainer(150, 220, countiesListTo[21], (){Navigator.pushNamed(context, FlightSearch.id);}),
                        HomeReusableContainer(150, 220, countiesListTo[17], (){Navigator.pushNamed(context, FlightSearch.id);}),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'YOUR LAST FLIGHT',
                  style: kSplashTextStyle.copyWith(fontSize: 20),
                ),
                hasTrip ? LastTripFlightStream() :
                HomeReusableContainer(150, 400, 'No booking yet!', (){}),
                // LastTripWithData('jambojet', 'jkjutb', 'Mairobi', 'Mombasa', '34/01/2022', 'TimeoftheDat 05.30', '[54,46]'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'TODAY\'S SCHEDULE',
                  style: kSplashTextStyle.copyWith(fontSize: 20),
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (context, index) => TodayFlightStream(),
                    // Row(
                    //   children: [
                    //     TodaysSchedule('748 Air', 'Nairobi', 'Eldoret', '10PM',
                    //         'JHNHG74', 8000),
                    //     TodaysSchedule('Skyward', 'Busia', 'Nairobi', '9PM',
                    //         'JHN7874', 9000),
                    //     TodaysSchedule('Jambojet', 'Eldoret', 'Busia', '10PM',
                    //         'GFN89OK', 1000),
                    //     TodaysSchedule('748 Air', 'Nairobi', 'Eldoret', '10PM',
                    //         'JHNHG74', 8000),
                    //   ],
                    // ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  //URL Launcher for Our Local Airlines
  Future <void> _launchURL(String url) async{
    final Uri uri = Uri(scheme: 'https', host: url);
    if(!await launchUrl(uri, mode: LaunchMode.externalApplication)){
      throw 'Cannot launch url';
    }
  }
}

//For the StreamBuilder to fetch data from Firestore and Display TODAYS Flights
class TodayFlightStream extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Flights').snapshots(),
      builder: (context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final flights = snapshot.data.docs;
        List <TodaysSchedule> TodaysFlightsContainers = [];
        for(var flight in flights){
          final companyName = flight['company'];
          final fromWhere = flight['from'];
          final toWhere = flight['to'];
          final depTime = flight['time'];
          final price = flight['price'];
          final flightNum = flight['flight_no'];
          final TodaysFlightsContainer = TodaysSchedule(companyName, fromWhere, toWhere, depTime, flightNum, price);
          TodaysFlightsContainers.add(TodaysFlightsContainer);
        }
        return Row(
          children:
            TodaysFlightsContainers,
        );
      },
      );
  }
}

//For the StreamBuilder to fetch data from Firestore and Display YOUR LAST TRIP
class LastTripFlightStream extends StatefulWidget {


  @override
  State<LastTripFlightStream> createState() => _LastTripFlightStreamState();
}

class _LastTripFlightStreamState extends State<LastTripFlightStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('TripUsers').doc(FirebaseAuth.instance.currentUser!.uid).collection('trips').snapshots(),
      builder: (context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        setState(() {
          hasTrip = true;
        });
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
        return Column(
          children: todaysFlightsContainers);
      },
      );
  }
}

