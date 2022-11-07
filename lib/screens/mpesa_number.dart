import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';

class MpesaNumberScreen extends StatefulWidget {

   static String id = 'mpesa_number';

  @override
  State<MpesaNumberScreen> createState() => _MpesaNumberScreenState();
}

class _MpesaNumberScreenState extends State<MpesaNumberScreen> {

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
                  
  } catch (e) {
  //you can implement your exception handling here.
  //Network un-reachability is a sure exception.

    /*
    Other 'throws':
    1. Amount being less than 1.0
    2. Consumer Secret/Key not set
    3. Phone number is less than 9 characters
    4. Phone number not in international format(should start with 254 for KE)
     */

  print(e.toString());
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){startTransaction(10.00, "254740745514");}),
      body: SafeArea(child: Container(),),
    );
  }
}