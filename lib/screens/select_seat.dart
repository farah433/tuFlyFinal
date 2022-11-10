import 'package:flutter/material.dart';
import 'package:tufly/screens/mpesa_number.dart';
import '../components/buttons.dart';
import'../const.dart';
import'../components/seats_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SelectSeat extends StatefulWidget {
  static String id = 'select_seat';

  @override
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
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

    //Firebase Seats
    updateToBooked(seatID,)async {
    await FirebaseFirestore.instance.collection('seats').doc(seatID).update({'isBooked': true});
  }

  //Object from StreamSeatA
  SeatsAStream seatsAStream = SeatsAStream();

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Seats'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  width: 270,
                  height: 700,
                  decoration: BoxDecoration(
                    color: kLastFlightorange.withBlue(100),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Text(newCompanyName, style: kfightName),
                      SizedBox(height: 10,),
                      Text(newNewDate, style: kfightName.copyWith(fontSize: 16)),
                      Text(newDepTime, style: kfightName.copyWith(fontSize: 16)),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          SeatsAStream(),
                          // SeatsBStream(),
                          // SeatsCStream(),
                          // SeatsDStream(),
                          // SeatsEStream(),
                          
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(radius: 8, backgroundColor: Colors.white,),
                          Text(' Empty', style: kBodyTextStyle.copyWith(fontSize: 14),),
                          SizedBox(width: 8,),
                          CircleAvatar(radius: 8, backgroundColor: kDorange,),
                          Text(' Selected', style: kBodyTextStyle.copyWith(fontSize: 14),),
                          SizedBox(width: 8,),
                          CircleAvatar(radius: 8, backgroundColor: kReservedSeat,),
                          Text(' Reserved', style: kBodyTextStyle.copyWith(fontSize: 14),),
                        ],
                      ),
                      ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                      SizedBox(height: 20),
                      Text(newFlightNum, style: kfightNameB.copyWith(fontWeight: FontWeight.w300),),
                      Text('Flight no.', style: kfightNameB),
                      SizedBox(height: 20),
                      Text(newFromWhere, style: kfightName),
                      Icon(Icons.flight_land_rounded,color: kBorange,),
                      Text(newToWhere, style: kfightName),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      Text('D48', style: kfightName.copyWith(fontSize: 30, color:kPorange,fontWeight: FontWeight.w300),),
                      Text('D49', style: kfightName.copyWith(fontSize: 30,color:kPorange, fontWeight: FontWeight.w300),),
                      Text('Seats', style: kfightNameB),
                      SizedBox(height: 20),
                        Text('Ksh', style: kfightNameB.copyWith(fontSize:  20),),
                        SizedBox(width: 3,),
                        Text(newPrice, style: kfightName.copyWith(fontSize: 30,color:kPorange, fontWeight: FontWeight.w300),),
                      Text('Price', style: kfightNameB),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            BottomButton('Next', kBorange, (){
              // setSelectedToBooked();
              Navigator.pushNamed(context, MpesaNumberScreen.id, arguments: {
                'companyName': newCompanyName,
                'fromWhere':newFromWhere,
                'toWhere':newToWhere,
                'newDate':newNewDate,
                'depTime':newDepTime,
                'FlightNum':newFlightNum,
                'price':newPrice,
                
              });
              }),
          ],
        ),
        ),
    );
  }
}


//For the StreamBuilder to fetch data from Firestore and Display for Flight Seats A
class SeatsAStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('SeatsA').snapshots(),
      builder: (context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final seats = snapshot.data.docs;
        List <SeatContainer> seatContainers = [];
        for(var seat in seats){
          final seatID = seat['id'];
          final isSelected = seat['isSelected'];
          final isEmpty = seat['isEmpty'];
          final isBooked = seat['isBooked'];
          final seatContainer = SeatContainer(seatID, isEmpty, isSelected, isBooked,);
          seatContainers.add(seatContainer);


        }
        return Expanded(
          child: Column(
            children: seatContainers),);
      },
      );
  }

  
}

