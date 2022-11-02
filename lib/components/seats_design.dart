import 'package:flutter/material.dart';

//Design of Seats in Row format
class SeatDesign extends StatefulWidget {

  @override
  State<SeatDesign> createState() => _SeatDesignState();
}

class _SeatDesignState extends State<SeatDesign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(child: Image.asset('images/seat1.png')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(child: Image.asset('images/seat2.png')),
                ),
                SizedBox(width: 80,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(child: Image.asset('images/seat3.png')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(child: Image.asset('images/seat3.png')),
                ),
                
              ],
            ),
    );
  }
}