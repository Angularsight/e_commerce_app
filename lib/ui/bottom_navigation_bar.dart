



import 'package:e_commerce_app/ui/cart/cart_screen.dart';
import 'package:e_commerce_app/ui/feed/feed_screen.dart';
import 'package:e_commerce_app/ui/home/home_screen.dart';
import 'package:e_commerce_app/ui/main_screen/main_screens.dart';
import 'package:e_commerce_app/ui/profile/profile_screen.dart';
import 'package:e_commerce_app/ui/search/search_screen.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ShopApp extends StatefulWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  _ShopAppState createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {

  var screens = [
    HomeScreen(),
    FeedScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen()
  ];

 late List<Map<String,Object>> _pages;

  int _selectedIndexPage = 0;


  void _selectedPage(int index){
    setState(() {
      _selectedIndexPage = index;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages = [
      {
        'page':MainScreens(),
        'title':"Home"
      },
      {
        'page':FeedScreen(),
        'title':"Feeds"
      },
      {
        'page':SearchScreen(),
        'title':"Search"
      },
      {
        'page':CartScreen(),
        'title':"Cart"
      },
      {
        'page':ProfileScreen(),
        'title':"Profile"
      }
    ];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("${_pages[_selectedIndexPage]['title']}"),
      //   centerTitle: true,
      // ),

      body: screens[_selectedIndexPage],

      bottomNavigationBar: BottomAppBar(
        notchMargin: 1.0,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight *1.05,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black26,width: 3))
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndexPage,
            elevation: 10,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.black,
            onTap: _selectedPage, // This will automatically pass the index of the selected item to the _selectedPage function
            items: [
            BottomNavigationBarItem(
            icon: Icon(IconClass.home,size: 25,),
            label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(IconClass.feed,size:25), label: "Feed"),
            BottomNavigationBarItem(activeIcon:null,icon: Icon(null),label: ""),
            BottomNavigationBarItem(icon: Icon(IconClass.cart,size:25),label: "Cart"),
            BottomNavigationBarItem(icon: Icon(IconClass.profile,size: 25,),label: "Profile")
            ],

          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          tooltip: "Search",
          child: Icon(IconClass.search),
          onPressed: (){
            setState(() {
              _selectedIndexPage = 2;
            });
          },
        ),
      ),

        //****************THIS IS TO AVOID THE FLOATING ACTION BUTTON FROM COMING UP WHEN WE PRESS THE KEYBOARD
        resizeToAvoidBottomInset: false

      );




  }



}
