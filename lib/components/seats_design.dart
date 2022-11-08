import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  void updateToBooked(seatId) async {
    //IF SEAT IS SELECTED AND PAYMENT MADE THEN => BOOK


      await FirebaseFirestore.instance.collection('seats').doc(widget.seatId).update({'isBooked': true});
      widget.isBooked = true;

      Fluttertoast.showToast(msg: 'Seat has been booked!', gravity: ToastGravity.TOP);



    // else if(widget.isSelected == false){
    //   widget.isBooked= false;
    //   await FirebaseFirestore.instance.collection('seats').doc(seatId).update({'isBooked': false});
    //
    //   Fluttertoast.showToast(msg: 'Seat has been booked!', gravity: ToastGravity.TOP);
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onDoubleTap: () async{
                      setState(() {
                        widget.isSelected =false;



                      });
                     // updateToBooked(widget.seatId);
                    },
                    onTap: () async {
                      setState(() {
                        widget.isSelected = true;
                        //if payment is made => book

                       });
                      updateToBooked(widget.seatId); // brings error message cannot find the doc kwa firestore,some good progress lakini

                    },
                    child: widget.isBooked
                     ? Image.asset('images/seat3.png')
                     : widget.isSelected
                     ? Image.asset('images/seat2.png')
                     : Image.asset('images/seat1.png')),
                );
  }
}