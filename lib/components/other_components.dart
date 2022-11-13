
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/link.dart';
import '../const.dart';
import '../screens/user_reports.dart';
import'../screens/flight_search.dart';
import 'package:flutter/gestures.dart';
import'package:url_launcher/url_launcher.dart';

//TextField for Login
class LoginTextField extends StatelessWidget {
  LoginTextField(this.labelText, this.hintText, this.obsecure, this.controller);

  //For each widget being created
  final String labelText;
  final String hintText;
  bool obsecure;

  //Email & Password Controller
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        style: kTextFieldInput,
        keyboardType: TextInputType.emailAddress,
        obscureText: obsecure,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: kTextFieldInput.copyWith(fontSize: 16),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange, width: 1.5),
          ),
        ),
      ),
    );
  }
}

//TextFormField for SignUp
class RegTextField extends StatelessWidget {
  RegTextField(this.labelText, this.hintText, this.obsecure, this.controller,
      this.validation);

  //For each widget being created
  final String labelText;
  final String hintText;
  bool obsecure;

  //Email & Password Controller
  var controller = TextEditingController();

  //Validation Function for Email & Password
  String? Function(String?) validation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        style: kTextFieldInput,
        keyboardType: TextInputType.emailAddress,
        obscureText: obsecure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validation,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: kTextFieldInput.copyWith(fontSize: 16),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange, width: 1.5),
          ),
        ),
      ),
    );
  }
}

//TextFormField for Adding Flight
class AddFlightTextField extends StatelessWidget {
  AddFlightTextField(this.labelText, this.hintText, this.obsecure,
      this.controller, this.validation);

  //For each widget being created
  final String labelText;
  final String hintText;
  bool obsecure;

  //Email & Password Controller
  var controller = TextEditingController();

  //Validation Function for Email & Password
  String? Function(String?) validation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        style: kTextFieldInput,
        keyboardType: TextInputType.emailAddress,
        obscureText: obsecure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validation,
        decoration: InputDecoration(
          filled: true,
          fillColor: kLightorange,
          labelText: labelText,
          labelStyle: kLabelTextStyle.copyWith(fontSize: 20),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: kLightorange, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange, width: 1.5),
          ),
        ),
      ),
    );
  }
}

//Price @ Adm Add page
class PriceTextField extends StatelessWidget {
  PriceTextField(this.labelText, this.hintText, this.obsecure, this.controller,
      this.validation);

  //For each widget being created
  final String labelText;
  final String hintText;
  bool obsecure;

  //Email & Password Controller
  var controller = TextEditingController();

  //Validation Function for Email & Password
  String? Function(String?) validation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        style: kTextFieldInput,
        keyboardType: TextInputType.number,
        obscureText: obsecure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validation,
        decoration: InputDecoration(
          filled: true,
          fillColor: kLightorange,
          labelText: labelText,
          labelStyle: kLabelTextStyle.copyWith(fontSize: 20),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: kLightorange, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange, width: 1.5),
          ),
        ),
      ),
    );
  }
}

//TextSpan for the signup? & login?
class TextspanOfLinks extends StatelessWidget {
  TextspanOfLinks(this.question, this.functionto, this.linkto);
  Future Function() functionto;
  String question;
  String linkto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: question,
                style: kSplashTextStyle.copyWith(fontSize: 22),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap = functionto,
                text: linkto,
                style: kSplashTextStyle.copyWith(
                    color: kPorange,
                    fontSize: 22,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Search button
class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextField(
        onChanged: (value) {},
        style: kTextFieldInput,
        // keyboardType: Keybo,
        decoration: InputDecoration(
          filled: true,
          fillColor: kBorange,
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange, width: 1.5),
          ),
        ),
      ),
    );
  }
}

//Top Menu boxes
class TopMenuBoxes extends StatelessWidget {
  TopMenuBoxes(this.flightname, this.ontap);
  final String flightname;
  void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 9, top: 15),
      child: Column(
        children: [
            GestureDetector(
              onTap: ontap,
              child: Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: kPorange.withAlpha(100),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset('images/$flightname.png'),
                ),
              ),
            ),
          
          SizedBox(
            height: 8,
          ),
          Text(
            flightname,
            style: kSplashTextStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

//Link Textspans
class LinkTextspan extends StatelessWidget {
  LinkTextspan(this.textname, this.onTap, this.fontsize);
  final String textname;
  final Future Function() onTap;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: textname,
            style: kSplashTextStyle.copyWith(
                color: kPorange,
                fontStyle: FontStyle.italic,
                fontSize: fontsize,
                decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}

//HomeReusableContainer
class HomeReusableContainer extends StatelessWidget {
  HomeReusableContainer(this.height, this.width, this.cityName, this.ontap);
  final double height;
  final double width;
  final String cityName;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, top: 10),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/$cityName.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4), BlendMode.dstATop),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              cityName,
              style: kfightName,
            )),
          ),
        ),
      ),
    );
  }
}

// //AppBarDettails
// class AppBarDetails extends StatelessWidget {

//   AppBarDetails(this.title,);

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//         backgroundColor: kPorange,
//         leading: Image.asset('images/logo.png'),
//         title: Text('Good morning, Farah!',),
//         actions: [
//           IconButton(onPressed: (){Navigator.pushNamed(context, ProfileScreen.id);}, icon: Icon(Icons.person,)),
//         ],
//       );
//   }
// }

//Drop Down TextField inside Flight search
class FlightDetails extends StatelessWidget {
  FlightDetails(this.width, this.title, this.iconname, this.child);
  final double width;
  final String title;
  final Icon iconname;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: width,
      decoration: BoxDecoration(
        color: kLightorange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 8, top: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [Text(title, style: kLabelTextStyle), iconname],
            ),
            child,
          ],
        ),
      ),
    );
  }
}

//Icon Buttons
class IconButtomCalc extends StatelessWidget {
  IconButtomCalc(this.onpressed, this.icon);
  final Function() onpressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: kBorange,
        borderRadius: BorderRadius.circular(3),
      ),
      child: IconButton(
        padding: const EdgeInsets.all(4.0),
        onPressed: onpressed,
        icon: icon,
      ),
    );
  }
}


//LAST TRIP CONTAINER WITH DATA
class LastTripWithData extends StatelessWidget {

  LastTripWithData(this.company, this.flightNum, this.fromWhere, this.toWhere, this.date, this.time, this.seatId);

  String company;
  String flightNum;
  String fromWhere;
  String toWhere;
  String date;
  String time;
  String seatId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, top: 10),
      child: Container(
        height: 150,
        width: 400,
        decoration: BoxDecoration(
          color: kBorange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(fromWhere, style: kBodyTextStyle.copyWith(color: Colors.white),),
                  SizedBox(width: 10,),
                  Icon(Icons.flight_land_rounded, color: Colors.white,),
                  SizedBox(width: 10,),
                  Text(toWhere, style: kBodyTextStyle.copyWith(color: Colors.white),),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset('images/$company.png'),
                          ),
                          Column(
                            children: [
                              Text('DATE & TIME'),
                              Text(date +' - ' +time),
                            ],
                          ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('FLIGHT NO.'),
                      Text(flightNum),
                    ],
                  ),
                  Column(
                    children: [
                      Text('SEATs'),
                      Text(seatId),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}