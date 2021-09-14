


import 'package:e_commerce_app/ui/bottom_navigation_bar.dart';
import 'package:e_commerce_app/ui/upload_page/upload_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MainScreens extends StatefulWidget {
  const MainScreens({Key? key}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  @override
  Widget build(BuildContext context) {
    return PageView(children: [ShopApp(),UploadPage()],);
  }
}
