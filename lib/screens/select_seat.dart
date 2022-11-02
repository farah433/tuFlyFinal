import 'package:flutter/material.dart';
import '../const.dart';
import '../components/buttons.dart';
import '../components/other_components.dart';
import '../components/seats_design.dart';

class SelectSeats extends StatefulWidget {
  static String id = 'select_seat';

  @override
  State<SelectSeats> createState() => _SelectSeatsState();
}

class _SelectSeatsState extends State<SelectSeats> {
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
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SeatDesign(),
                      SizedBox(height: 40,),
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
}