import 'package:flutter/material.dart';
import 'package:tufly/details/flights.dart';
import '../const.dart';

class AvailableFlightsContainer extends StatelessWidget {
  AvailableFlightsContainer(this.flightCompany, this.fromWhere, this.toWhere, this.depTime, this.flightPrice, this.flightNumber, this.passingFunction);

  String flightCompany;
  String fromWhere;
  String toWhere;
  String depTime;
  String flightPrice;
  String flightNumber;
  void Function() passingFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: passingFunction,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
                  height: 140,
                  width: 400,
                  decoration: BoxDecoration(
                    color: kLastFlightorange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                            image: AssetImage('images/$flightCompany.jpg'),
                            fit: BoxFit.cover,
                            ),  
                            ),
                                ),
                              ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(flightCompany, style: kfightName,),
                          SizedBox(height: 5,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(fromWhere, style: kfightName.copyWith(color: Colors.black, fontSize: 16),),
                            Icon(Icons.flight_land_rounded),
                            Text(toWhere, style: kfightName.copyWith(color: Colors.black, fontSize: 16),),
                            ],
                            ),
                            SizedBox(height: 5,),
                            Text(depTime, style: kfightName.copyWith(fontSize: 18,),),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text('Ksh', style: kfightName.copyWith(fontSize:  16),),
                                SizedBox(width: 3,),
                                Text(flightPrice.toString(), style: kfightName.copyWith(fontSize: 18),),
                                SizedBox(width: 10,),
                                Text('Fight no. $flightNumber', style: kfightName.copyWith(color: Colors.black, fontSize: 16),),
                              ],
                            ),
                        ],),
                    ],
                  ),
                ),
      ),
    );
  }
}

class FlightsContainer extends StatefulWidget {

  FlightsContainer(this.companyName, this.fromWhere, this.toWhere, this.depTime, this.price, this.flightNum, this.deleteFunction);

  String companyName;
  String fromWhere;
  String toWhere;
  String depTime;
  String price;
  String flightNum;
  void Function() deleteFunction;

  bool isAvailable = true;

  @override
  State<FlightsContainer> createState() => _FlightsContainerState();
}

class _FlightsContainerState extends State<FlightsContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
                height: 160,
                width: 400,
                decoration: BoxDecoration(
                  color: widget.isAvailable? kLastFlightorange : kReservedSeat,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('images/${widget.companyName}.jpg'),
                            fit: BoxFit.cover,
                            )
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 1,),
                        Text(widget.companyName, style: kfightName,),
                        SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(widget.fromWhere, style: kfightName.copyWith(color: Colors.black, fontSize: 16),),
                          Icon(Icons.flight_land_rounded),
                          Text(widget.toWhere, style: kfightName.copyWith(color: Colors.black, fontSize: 16),),
                          ],
                          ),
                          SizedBox(height: 5,),
                          Text(widget.depTime, style: kfightName.copyWith(fontSize: 18),),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text('Ksh', style: kfightName.copyWith(fontSize:  16),),
                              SizedBox(width: 3,),
                              Text(widget.price.toString(), style: kfightName.copyWith(fontSize: 18),),
                              SizedBox(width: 8,),
                              Text('Fight no. ${widget.flightNum}', style: kfightName.copyWith(color: Colors.black, fontSize: 16),),
                            ],
                          ),
                          Row(
                            children: [
                            IconButton(onPressed: widget.deleteFunction, icon: Icon(Icons.delete, color: Colors.red,)),
                            IconButton(onPressed: (){
                              setState(() {
                                widget.isAvailable = false;
                              });
                            }, icon: Icon(Icons.cancel,color: Colors.blue,)),
                            IconButton(onPressed: (){
                              setState(() {
                                widget.isAvailable = true;
                              });
                            }, icon: Icon(Icons.check_circle, color: kBorange,)),
                            ],
                          ),
                      ],),
                  ],
                ),
              ),
    );
  }
}

class TodaysSchedule extends StatelessWidget {

  TodaysSchedule(this.companyName, this.fromWhere, this.toWhere, this.depTime, this.flightNumber, this.price,);

  String companyName;
  String fromWhere;
  String toWhere;
  String depTime;
  String flightNumber;
  int price;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, top: 10),
      child: Container(
                height: 140,
                width: 220,
                decoration: BoxDecoration(
                  color: kLastFlightorange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: kPorange.withAlpha(200),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset('images/$companyName.png'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 2,),
                            Text(companyName, style: kfightName,),
                            SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(fromWhere, style: kfightName.copyWith(color: Colors.black, fontSize: 16),),
                              Icon(Icons.flight),
                              Text(toWhere, style: kfightName.copyWith(color: Colors.black, fontSize: 16),),
                              ],
                              ),
                              SizedBox(height: 5,),
                          ],),
                      ],
                    ),
                    Text('  $depTime', style: kfightName.copyWith(fontSize: 18,),),
                    SizedBox(height: 5,),
                    Text('  Flight no. $flightNumber', style: kfightName.copyWith(color: Colors.black, fontSize: 16),),
                    Row(
                      children: [
                        Text('  Ksh', style: kfightName.copyWith(fontSize:  16),),
                        SizedBox(width: 3,),
                        Text(price.toString(), style: kfightName.copyWith(fontSize: 18),),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }
}

class SideBarListTile extends StatelessWidget {
  SideBarListTile(this.icon, this.title, this.onTap);
  final Icon icon;
  final String title;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
            leading: icon,iconColor: kPorange,
            title: Text(title, style: kBodyTextStyle),
            onTap: onTap,
          );
  }
}