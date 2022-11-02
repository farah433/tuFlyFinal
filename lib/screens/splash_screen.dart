import 'package:flutter/material.dart';
import '../registrations/signup_screen.dart';
import '../const.dart';
import '../components/buttons.dart';

class SplashScreen extends StatelessWidget {
  static String id = 'splash_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.jpg'),
          fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.4), BlendMode.dstATop),
          ),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.only(right: 40),
                child: Hero(
                  tag: 'logo',
                  child: Image.asset('images/logo.png', scale: 2.5,)),
              ),
              SizedBox(height: 10,),
              Text('tuFLY', style: kLogoTextStyle),
              SizedBox(height: 200,)
            ],
          ),
          RichText(text: TextSpan(
            children: [ 
            TextSpan(text: 'We\'re ', style: kSplashTextStyle),
            TextSpan(text: 'HERE ', style: kSplashTextStyle.copyWith(color: Color(0xFF9E3507),),),
            TextSpan(text: 'to take', style: kSplashTextStyle),
            ],
          ),),
          RichText(text: TextSpan(
            children: [ TextSpan(text: 'you ', style: kSplashTextStyle),
            TextSpan(text: 'THERE', style: kSplashTextStyle.copyWith(color: Color(0xFF9E3507),),),
            TextSpan(text: '.', style: kSplashTextStyle),
            ],
          ),
          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: BottomButton('Get Started', kPorange, (){Navigator.pushNamed(context, SignUpScreen.id);}),
          ),
        ],),
      ),
      ),
    );
  }
}


