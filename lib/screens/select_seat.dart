import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tufly/screens/mpesa_number.dart';
import '../components/buttons.dart';
import'../const.dart';
import'../components/seats_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List chosenSeatsNumber= [];
int seatsNumber = 0;
int seatPrice = 0;
int airlineChargeperSeat = 0;





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

  //  var finalPrice = int.parse(newPrice) * seatsNumber;
       airlineChargeperSeat = int.parse(newPrice);



  //Object from StreamSeatA
  SeatsAStream seatsAStream = SeatsAStream();

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Seats'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
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
                            SeatsBStream(),
                            SeatsCStream(),
                            SeatsDStream(),
                            SeatsEStream(),

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
                        SizedBox(height: 10,),
                        Text('Seats', style: kfightNameB),
                        Text(chosenSeatsNumber.toString() , style: kfightName.copyWith(fontSize: 16)),
                        Text('Ksh', style: kfightNameB.copyWith(fontSize:  20),),
                        SizedBox(width: 3,),
                        Text(seatPrice.toString(), style: kfightName.copyWith(fontSize: 20),),
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
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              PaymentBottomButton('Next', kBorange, (){

                if(chosenSeatsNumber.isEmpty){
                  Fluttertoast.showToast(msg: "Kindly select a seat!", gravity: ToastGravity.TOP);
                }else{
                  Navigator.pushNamed(context, MpesaNumberScreen.id, arguments: {
                    'companyName': newCompanyName,
                    'fromWhere':newFromWhere,
                    'toWhere':newToWhere,
                    'newDate':newNewDate,
                    'depTime':newDepTime,
                    'FlightNum':newFlightNum,
                    'price':newPrice,
                    'seats': chosenSeatsNumber.toString(),


                });
                }
                }),
            ],
          ),
        ),
        ),
    );
  }
}


//For the StreamBuilder to fetch data from Firestore and Display for Flight Seats A
class SeatsAStream extends StatefulWidget {
  @override
  State<SeatsAStream> createState() => _SeatsAStreamState();
}

class _SeatsAStreamState extends State<SeatsAStream> {

  int selectedSeatsTimes = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('SeatsA').orderBy('id').snapshots(),
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
          final seatContainer = SeatContainer(seatID, isEmpty, isSelected, isBooked,
                  () async {

         print(seatID);
         chosenSeatsNumber.add(seatID);
         print(chosenSeatsNumber);



         seatsNumber = chosenSeatsNumber.length;
         seatPrice =  seatsNumber * airlineChargeperSeat;





          } ,
                  ()async{
                print(seatID);
                chosenSeatsNumber.removeLast();
                print(chosenSeatsNumber);
              }
          );
          seatContainers.add(seatContainer);



        }
        return Expanded(
          child: Column(
            children: seatContainers),);
      },
      );
  }
}

//For the StreamBuilder to fetch data from Firestore and Display for Flight Seats B
class SeatsBStream extends StatelessWidget {


  int selectedSeatsTimes = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('SeatsB').orderBy('id').snapshots(),
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
          final seatContainer = SeatContainer(seatID, isEmpty, isSelected, isBooked,
                  () async {

         print(seatID);
         chosenSeatsNumber.add(seatID);
         print(chosenSeatsNumber);



         seatsNumber = chosenSeatsNumber.length;
         seatPrice =  seatsNumber * airlineChargeperSeat;





          }
          ,
              ()async{
                print(seatID);
                chosenSeatsNumber.removeLast();
                print(chosenSeatsNumber);
              }
          );
          seatContainers.add(seatContainer);



        }
        return Expanded(
          child: Column(
            children: seatContainers),);
      },
      );
  }
}


//For the StreamBuilder to fetch data from Firestore and Display for Flight Seats C
class SeatsCStream extends StatelessWidget {


  int selectedSeatsTimes = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('SeatsC').orderBy('id').snapshots(),
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
          final seatContainer = SeatContainer(seatID, isEmpty, isSelected, isBooked,
                  () async {

         print(seatID);
         chosenSeatsNumber.add(seatID);
         print(chosenSeatsNumber);



         seatsNumber = chosenSeatsNumber.length;
         seatPrice =  seatsNumber * airlineChargeperSeat;





          } ,
                  ()async{
                print(seatID);
                chosenSeatsNumber.removeLast();
                print(chosenSeatsNumber);
              }
          );
          seatContainers.add(seatContainer);



        }
        return Expanded(
          child: Column(
            children: seatContainers),);
      },
      );
  }
}

//For the StreamBuilder to fetch data from Firestore and Display for Flight Seats C
class SeatsDStream extends StatelessWidget {


  int selectedSeatsTimes = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('SeatsD').orderBy('id').snapshots(),
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
          final seatContainer = SeatContainer(seatID, isEmpty, isSelected, isBooked,
                  () async {

         print(seatID);
         chosenSeatsNumber.add(seatID);
         print(chosenSeatsNumber);



         seatsNumber = chosenSeatsNumber.length;
         seatPrice =  seatsNumber * airlineChargeperSeat;





          }
              ,
                  ()async{
                print(seatID);
                chosenSeatsNumber.removeLast();
                print(chosenSeatsNumber);
              });
          seatContainers.add(seatContainer);



        }
        return Expanded(
          child: Column(
            children: seatContainers),);
      },
      );
  }
}

//For the StreamBuilder to fetch data from Firestore and Display for Flight Seats C
class SeatsEStream extends StatelessWidget {


  int selectedSeatsTimes = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('SeatsE').orderBy('id').snapshots(),
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
          final seatContainer = SeatContainer(seatID, isEmpty, isSelected, isBooked,
                  () async {

         print(seatID);
         chosenSeatsNumber.add(seatID);
         print(chosenSeatsNumber);



         seatsNumber = chosenSeatsNumber.length;
         seatPrice =  seatsNumber * airlineChargeperSeat;





          }
              ,
                  ()async{
                print(seatID);
                chosenSeatsNumber.removeLast();
                print(chosenSeatsNumber);
              }
          );
          seatContainers.add(seatContainer);



        }
        return Expanded(
          child: Column(
            children: seatContainers),);
      },
      );
  }
}

