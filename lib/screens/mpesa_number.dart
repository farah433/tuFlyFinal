
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';
import'../screens/ticket_screen.dart';

import '../components/buttons.dart';
import '../components/other_components.dart';
import '../const.dart';

class MpesaNumberScreen extends StatefulWidget {

   static String id = 'mpesa_number';

  @override
  State<MpesaNumberScreen> createState() => _MpesaNumberScreenState();
}

class _MpesaNumberScreenState extends State<MpesaNumberScreen> {

  //Controllers for each field
  final numberController = TextEditingController();
  
  DocumentReference? paymentRef;

  //Updating Account
  Future<void> updateAccount(String mCheckoutRequestID){
    Map<String, String> initData ={
      'CheckoutRequestID' : mCheckoutRequestID,
    };
    paymentRef!.set({"info":"receipt data goes here."});
    return paymentRef!
    .collection("deposit")
    .doc(mCheckoutRequestID)
    .set(initData)
    .then((value) => print("Transaction Initialized."))
    .catchError((error) => print('Failed to init transaction: $error'));
  }

  Future <dynamic> startTransaction(double amount, String phone) async {

    dynamic transactionInitialisation;
 //Wrap it with a try-catch
  try {
  //Run it
  transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
                  businessShortCode: "174379",//use your store number if the transaction type is CustomerBuyGoodsOnline
                  transactionType: TransactionType.CustomerPayBillOnline, //or CustomerBuyGoodsOnline for till numbers
                  amount: amount,
                  partyA: phone,
                  partyB: "174379",
                  callBackURL: Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
                  accountReference: "payment",
                  phoneNumber: phone,
                  baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
                  transactionDesc: "demo",
                  passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

                  print("RESULT : "+transactionInitialisation.toString());
                  
  } catch (error) {
  //you can implement your exception handling here.
  //Network un-reachability is a sure exception.

    /*
    Other 'throws':
    1. Amount being less than 1.0
    2. Consumer Secret/Key not set
    3. Phone number is less than 9 characters
    4. Phone number not in international format(should start with 254 for KE)
     */
    Fluttertoast.showToast(msg: error.toString(), gravity: ToastGravity.TOP);

  print(error.toString());
  }
  }

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
        title: Text('Payment Method'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10,),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
            ),
            height: 400,
            width: 400,
            child: Column(
              children: [
                Text('Kindly insert the M-pesa number to be charged for this trip.', style: kSplashTextStyle.copyWith(fontSize: 20, color: Colors.grey),),
                SizedBox(height: 10,),
                Text('The format should be of 9 characters..example 712345678.', style: kSplashTextStyle.copyWith(fontSize: 16, color: Colors.grey),),
                SizedBox(height: 30,),
                PriceTextField('MPESA number', 'Enter Mpesa number', false, numberController,
                (value) => value != null && value.length < 9 || value!.length > 9 
                  ? 'The number must be of 9 Characters': null,),
                  SizedBox(height: 40,),
                BottomButton('PAY $newPrice', kBorange, (){startTransaction(1.00, "254${numberController.text.trim()}");}),
                BottomButton('TO TICKET', kBorange, (){Navigator.pushNamed(context, TicketScreen.id, arguments: {
                      'companyName': newCompanyName,
                      'fromWhere':newFromWhere,
                      'toWhere':newToWhere,
                      'newDate':newNewDate,
                      'depTime':newDepTime,
                      'FlightNum':newFlightNum,
                      'price':newPrice,
                });}),
              ],
            ),
          ),
        ),
        ),
    );
  }
}