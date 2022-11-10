import 'package:flutter/material.dart';

import '../components/buttons.dart';
import '../components/printable_data.dart';
import '../const.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TicketScreen extends StatelessWidget {
  static String id = "ticketScreen";

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

    
    return Scaffold(
      appBar: AppBar(
        title: Text('My Ticket'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Image.asset('images/logo.png', scale: 5,),
                Text('     tuFly', style: kfightName,),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(newFromWhere, style: kBodyTextStyle,),
                    Icon(Icons.flight_land_rounded, color: kBorange,),
                    Text(newToWhere, style: kBodyTextStyle,),
                    Text(newDepTime, style: kBodyTextStyle,),
                  ],
                ),
                SizedBox(height: 10,),
                Text('TRAVELLER', style: kfightName,),
                Text('First name and Last name', style: kBodyTextStyle,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('DATE', style: kfightName,),
                        Text(newNewDate, style: kBodyTextStyle,),
                        
                      ],
                    ),
                    Column(
                      children: [
                        Text('FLIGHT NO.', style: kfightName,),
                        Text('jhkgtu', style: kBodyTextStyle,),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                      Text(newCompanyName, style: kBodyTextStyle,),
                        
                      ],
                    ),
                    Column(
                      children: [
                        Text('SEATS', style: kfightName,),
                        Text('DE, FE', style: kBodyTextStyle,),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text('Thanks for choosing our service!', style: kBodyTextStyle.copyWith(color: Colors.grey),),
                SizedBox(height: 5,),
                Text('Contact the branch for any clarifications.', style: kBodyTextStyle.copyWith(color: Colors.grey),),
                SizedBox(height: 15,),
                BottomButton('Save as PDF', kBorange, (){printDoc();}),
              ],
            ),
            ),
        ),
      ),
    );
  }
Future<void> printDoc() async {
  final image1 = await imageFromAssetBundle('assets/images/logo.png');
  final doc = pw.Document();
  doc.addPage(pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context){
      return buildPrintableData(image1);
    }));
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save());
}
  
}