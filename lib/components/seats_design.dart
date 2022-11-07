import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Design of Each Seats
class SeatContainer extends StatefulWidget {

  SeatContainer(this.seatId, this.isAvailable, this.isSelected, this.isBooked,);
  String seatId;
  bool isAvailable;
  bool isSelected;
  bool isBooked;

  @override
  State<SeatContainer> createState() => _SeatContainerState();
}

class _SeatContainerState extends State<SeatContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onDoubleTap: () async{
                      setState(() {
                        widget.isSelected =false;
                      });
                    },
                    onTap: () async {
                      setState(() {
                        widget.isSelected = true;
                     //   await FirebaseFirestore.instance.collection('Seats').doc(id).update({'isSelected' : true});
                      });

                    },
                    child: widget.isBooked
                     ? Image.asset('images/seat3.png')
                     : widget.isSelected
                     ? Image.asset('images/seat2.png')
                     : Image.asset('images/seat1.png')),
                );
  }
}