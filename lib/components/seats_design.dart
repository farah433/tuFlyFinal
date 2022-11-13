import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import'../screens/select_seat.dart';


//Design of Each Seats
class SeatContainer extends StatefulWidget {

  SeatContainer(this.seatID, this.isEmpty, this.isSelected, this.isBooked,this.bookNow, this.unBook );
  String seatID;
  bool isEmpty;
  bool isSelected;
  bool isBooked;
  void Function () bookNow;
  void Function () unBook;






  @override
  State<SeatContainer> createState() => _SeatContainerState();
}

class _SeatContainerState extends State<SeatContainer> {
 String firstSelected= '0';
 String secSelected= '0';
 String thirdSelected= '0';
 String fourthSelected= "0";
 String fifthSelected= "0";
 String sixthSelected= "0";

  List<String>  chosenSeatsNumber  = [];

  int selectedSeatsTimes = 0;

  int seatCounter = 0;



  @override
  Widget build(BuildContext context) {
    // chosenSeatsNumber.add(firstSelected);
    // chosenSeatsNumber.add(secSelected);
    // chosenSeatsNumber.add(thirdSelected);

    return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onDoubleTap: () async{
                      selectedSeatsTimes = 0;

                      setState(() {
                        widget.isSelected =false;
                      });
                      widget.unBook();

                    print(chosenSeatsNumber);
                    Fluttertoast.showToast(msg: "Seat is unselected");
                    },
                    onTap: () async {
                      selectedSeatsTimes ++;



                      if(selectedSeatsTimes == 1){
                        setState(() {
                          widget.isSelected = true;
                        });
                        widget.bookNow();
                      }
                      else{
                        Fluttertoast.showToast(msg: "Seat already selected!");
                      }



                    },
                    child: widget.isBooked
                     ? Image.asset('images/seat3.png')
                     : widget.isSelected
                     ? Image.asset('images/seat2.png')
                     : Image.asset('images/seat1.png')),
                );
  }
}