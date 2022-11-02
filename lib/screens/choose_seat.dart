import 'package:flutter/material.dart';
import '../const.dart';
import '../components/buttons.dart';

class ChooseSeat extends StatefulWidget {
  static String id = 'choose_seat';

  @override
  State<ChooseSeat> createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> {

  //Seat Count for left and right
  var countSeatLeft = 2*13;
  var countSeatRight = 2*13;
  var listSeatLeft = [];
  var listSeatRight = [];

  //Data for the seats
  initSeatValueToList(List data, count, side){
    var objectData;
    for(int i = 0; i < count; i++){
      objectData = {
        "id": side+'${i+1}',
        "isBooked": false,
        "isAvailable": true,
        "isSelected": false,
        "isVisible": true,
      };
      setState(() {
        data.add(objectData);
      });
    }
    print(data);
  }

  //The the inite state of the Widget before building
  @override
  void initState() {
    initSeatValueToList(listSeatLeft, countSeatLeft, 'L');
    initSeatValueToList(listSeatRight, countSeatRight, 'R');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
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
                    color: kLastFlightorange,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Row(
                        children: [
                          Expanded(child: seatDesign(listSeatLeft),),
                          Expanded(child: seatDesign(listSeatRight),),
                        ],
                      ),
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
                          child: Image.asset('images/Fly540.png'),
                        ),
                      ),
                      Text('Fly540', style: kfightNameB),
                      SizedBox(height: 20),
                      Text('36756h', style: kfightNameB.copyWith(fontWeight: FontWeight.w300),),
                      Text('Flight no.', style: kfightNameB),
                      SizedBox(height: 20),
                      Text('Nairobi', style: kfightName),
                      Icon(Icons.flight,color: kBorange,),
                      Text('Eldoret', style: kfightName),
                      SizedBox(height: 20),
                      Text('10/06/20', style: kfightName),
                      Text('10pm', style: kfightName),
                      SizedBox(height: 20),
                      Text('D48', style: kfightName.copyWith(fontSize: 30, color:kPorange,fontWeight: FontWeight.w300),),
                      Text('D49', style: kfightName.copyWith(fontSize: 30,color:kPorange, fontWeight: FontWeight.w300),),
                      Text('Seats', style: kfightNameB),
                      SizedBox(height: 20),
                        Text('Ksh', style: kfightNameB.copyWith(fontSize:  20),),
                        SizedBox(width: 3,),
                        Text('8,000', style: kfightName.copyWith(fontSize: 30,color:kPorange, fontWeight: FontWeight.w300),),
                      Text('Price', style: kfightNameB),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            BottomButton('Next', kBorange, (){}),
          ],
        ),
        ),
    );
  }
  
  //The Seat actual Design
  Widget seatDesign(List dataSeat){
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
        itemCount: dataSeat.length,
        itemBuilder:(context, index) {
          return Container(
            margin: EdgeInsets.all(5),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          );
        }
        ),
    );
  }
}