import 'package:e_commerce_app/intro_page/landing_page.dart';
import 'package:e_commerce_app/intro_page/splash_screen.dart';
import 'package:e_commerce_app/login_logout_active/user_status.dart';
import 'package:e_commerce_app/login_page/login.dart';
import 'package:e_commerce_app/network/product_api.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/dark_theme_provider.dart';
import 'package:e_commerce_app/provider/products.dart';
import 'package:e_commerce_app/ui/bottom_navigation_bar.dart';
import 'package:e_commerce_app/ui/main_screen/main_screens.dart';
import 'package:e_commerce_app/ui/upload_page/upload_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/util/theme_data.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';

void main(){
  //*********FIREBASE INITIALIZATION****************
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  //***********************Need to initialize the provider in order to use the dark theme
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();


  //**************This function will monitor the status of the app theme and will store the theme even if it is pushed into background
  void getAppThemeStatus() async{
    themeChangeProvider.darkTheme = await themeChangeProvider.darkThemePreferences.getDarkTheme();
  }

  @override
  void initState() {
    //***********Calling the getAppThemeStatus here
    getAppThemeStatus();
    super.initState();
  }

  //**************FIREBASE INITIALIZATION*****************
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    //ChangeNotifierProvider inside MultiProvider class keeps continuously listening to changes in the home:ShopApp()
    return FutureBuilder<Object>(
      future: _initialization,
      builder: (context, snapshot) {
        //**********FIREBASE AUTH PART*****************
        if(snapshot.connectionState==ConnectionState.waiting){
          return MaterialApp(
            home:Scaffold(
              body: Center(child : CircularProgressIndicator()),
            )
          );
        }else if(snapshot.hasError){
          return MaterialApp(
              home:Scaffold(
                body: Center(child : Text('Error occured from Firebase side')),
              )
          );
        }

        return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_){
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(create: (_){
                return Products();
              }),
              ChangeNotifierProvider(create: (_){
                return CartProvider();
              }),

        ],
        //************************** Consumer ===>This class is used to keep listening the changes happening in the home:ShopApp()
        child: Consumer<DarkThemeProvider>(
          builder: (context, themeData,child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: " Shop App ",
              theme: Styles.themeData(themeChangeProvider.darkTheme,context),

              //The below Class checks
              //If the user is yet to login(directs to landing page)
              //Else if already logged in(directs to ShopApp() or main page)
              //Else has some error
              home: UserLoginStatus()


            );
          }
          )
        );
      }
    );
  }
}

