

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce_app/intro_page/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {



  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 43.0,
      fontFamily: 'Berkshire',
    );

    return Scaffold(
      body: Stack(
        children: [
          SplashScreen(
              seconds: 8,
              navigateAfterSeconds: LandingPage(),
              image: Image.asset('images/logo.gif'),
              backgroundColor: Color(0xffffff66),
              photoSize: 225,
              useLoader: false,
          ),


          // Positioned(
          //   bottom: 350,
          //   left: 100,
          //   child: AnimatedTextKit(
          //     animatedTexts: [
          //       FadeAnimatedText('Thrift Shop',
          //           duration: Duration(seconds: 1),
          //
          //           textStyle: TextStyle(fontSize: 43,fontFamily: 'Berkshire',color: Colors.black.withOpacity(0.7))),
          //     ],
          //   ),
          // ),

          Positioned(
            bottom: 350,
            left: 100,
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Thrift Shop',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'Thrift Shop',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'Thrift Shop',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
                ColorizeAnimatedText(
                  'Thrift Shop',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
              totalRepeatCount: 50,
            ),
          ),


        ],
      )
    );
  }
}

