import 'package:flutter/material.dart';
import '../const.dart';
import '../components/other_components.dart';
import '../components/buttons.dart';
import '../details/county.dart';
import '../screens/available_flights.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlightSearch extends StatefulWidget {
  static String id = 'flight_search';

  @override
  State<FlightSearch> createState() => _FlightSearchState();
}

class _FlightSearchState extends State<FlightSearch> {
  DateTime? selectedDate;
  //Variables inside different fields
  int passangers = 1;

  //number of valid passangers 1-7
  void numberOfPassangers() {}

  //Starting value of the dropdownMenu
  String selectedcountyFrom = countiesListFrom[0];
  String selectedcountyTo = countiesListTo[0];

  //Resetting the values FROM & TO if similar
  void similarCounties() {
    if (selectedcountyFrom == selectedcountyTo) {
      selectedcountyTo = countiesListTo[0];
    } else if (selectedcountyTo == selectedcountyFrom) {
      selectedcountyFrom = countiesListFrom[0];
    }
  }

  //Creating dropdownItem for the FROM Field
  List<DropdownMenuItem> getDropdownMenuItemFrom() {
    List<DropdownMenuItem> dropDownItemsFrom = [];
    for (int i = 0; i < countiesListFrom.length; i++) {
      String county = countiesListFrom[i];
      var newItem = DropdownMenuItem(
        child: Text(
          county,
          style: kLabelTextStyle.copyWith(color: Colors.black),
        ),
        value: county,
      );
      dropDownItemsFrom.add(newItem);
    }

    similarCounties();
    return dropDownItemsFrom;
  }

  //Creating dropdownItem for the TO Fields
  List<DropdownMenuItem> getDropdownMenuItemTo() {
    List<DropdownMenuItem> dropDownItemsTo = [];
    for (int i = 0; i < countiesListTo.length; i++) {
      String county = countiesListTo[i];
      var newItem = DropdownMenuItem(
        child: Text(
          county,
          style: kLabelTextStyle.copyWith(color: Colors.black),
        ),
        value: county,
      );
      dropDownItemsTo.add(newItem);
    }
    similarCounties();
    return dropDownItemsTo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Flight Search'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 250,
              width: 400,
              child: Image.asset('images/flight_search.png'),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kPorange,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Kindly fill the details below',
                      style: kButtonTextStyle.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            FlightDetails(
                                200,
                                'FROM ',
                                Icon(Icons.flight_takeoff_rounded),
                                DropdownButton(
                                    items: getDropdownMenuItemFrom(),
                                    value: selectedcountyFrom,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedcountyFrom = value;
                                      });
                                    })),
                            SizedBox(
                              height: 20,
                            ),
                            FlightDetails(
                                200,
                                'TO ',
                                Icon(Icons.flight_land_rounded),
                                DropdownButton(
                                    items: getDropdownMenuItemTo(),
                                    value: selectedcountyTo,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedcountyTo = value;
                                      });
                                    })),
                          ],
                        ),
                        FlightDetails(
                          150,
                          'DATE ',
                          Icon(
                            Icons.calendar_month,
                            size: 20,
                          ),
                          TextButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate:
                                            selectedDate ?? DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2085))
                                    .then((date) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                });
                              },
                              child: Text(
                                selectedDate == null
                                    ? 'Departure date'
                                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                style:
                                    kLabelTextStyle.copyWith(color: kBorange),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlightDetails(
                        300,
                        'PASSANGER(S) ',
                        Icon(Icons.airline_seat_recline_extra_rounded),
                        Row(
                          children: [
                            IconButtomCalc(
                              () {
                                setState(() {
                                  if (passangers > 1) {
                                    passangers--;
                                  } else {
                                    passangers = 1;
                                  }
                                });
                              },
                              Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                passangers.toString(),
                                style: kSplashTextStyle,
                              ),
                            ),
                            IconButtomCalc(
                              () {
                                setState(() {
                                  if (passangers < 7) {
                                    passangers++;
                                  } else {
                                    passangers = 7;
                                  }
                                });
                              },
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: BottomButton('Search', kBorange, () {
                      searchFlight();
                    })),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Function to push details to Available flights screen
  void searchFlight() {
    if (selectedcountyFrom != countiesListFrom[0] &&
        selectedcountyTo != countiesListTo[0] &&
        selectedDate != null) {
      Navigator.pushNamed(context, AvailabeFlights.id, arguments: {
        'fromWhere': selectedcountyFrom,
        'toWhere': selectedcountyTo,
        'selecteddate':
            '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
        'passangers': passangers,
      });
    } else {
      Fluttertoast.showToast(
          msg: 'One of the fields is Empty.', gravity: ToastGravity.TOP);
    }
  }
}
