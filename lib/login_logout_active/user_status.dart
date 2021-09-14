


import 'package:e_commerce_app/intro_page/landing_page.dart';
import 'package:e_commerce_app/intro_page/splash_screen.dart';
import 'package:e_commerce_app/ui/bottom_navigation_bar.dart';
import 'package:e_commerce_app/ui/main_screen/main_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserLoginStatus extends StatelessWidget {
  const UserLoginStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //The below Class checks
    //If the user is yet to login(directs to landing page)
    //Else if already logged in(directs to ShopApp() or main page)
    //Else has some error

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,userSnapshot){
      if(userSnapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());
      }else if(userSnapshot.connectionState == ConnectionState.active){
        //Meaning the user has logged in
        if(userSnapshot.hasData){
          return MainScreens();
        }else{
          //If the snapshot is empty go back to landing page
          return IntroPage();
        }
      }else if(userSnapshot.hasError){
        return Center(child:Text("Some Login Error Has occured"));
      }else{
        return Scaffold(
          body: Center(child:Text('Something is wrong')),
        );
      }
    });
  }
}
