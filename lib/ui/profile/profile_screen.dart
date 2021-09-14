import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/provider/dark_theme_provider.dart';
import 'package:e_commerce_app/ui/cart/cart_screen.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:e_commerce_app/util/theme_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //********************This bool is to monitor the dark and light mode
  // bool _value = false;

  late ScrollController _scrollController;
  var top = 0.0;

  //For fetching data from FIREBASE
  var _name ='';
  var _email = '';
  String _phoneNo = '';
  var _joinedAt = '';
  bool profileBool = false;
  String profilePic = '';

  //Profile pic
  late File? _pickedImage;
  bool _pickedImageBool = false;


  //**********FIREBASE PART****************
  //For logging out purposes
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getDataFromFireStore()async{
    final User _accountUser = _auth.currentUser!;
    final _uid = _accountUser.uid;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(_uid).get();
    //****************** Here--> name,email,phoneNo and joinedAt are fields that we have stored in the firebase console
    setState(() {
      _name = userDoc.get('name');
      print('name');
      _email = userDoc.get('Email');
      _phoneNo = userDoc.get('Phone No');
      _joinedAt = userDoc.get('joinedAt');
    });

  }


  //*********************SETTING PROFILE PHOTO*****************************8
  void _pickImageFromCamera()async{
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    try{
      final ref = FirebaseStorage.instance.ref().child('profileImage').child('$_name.jpg');
      await ref.putFile(pickedImageFile);
      profilePic = await ref.getDownloadURL();


    }catch(error){
      print("Error occured while uploading profile photo to firebase storage: $error");
    }
    setState(() {
      profileBool= true;
      _pickedImageBool = true;
      _pickedImage = pickedImageFile;
      Navigator.pop(context);
    });
    // Navigator.pop(context);
  }

  void _pickImageGallery()async{
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    try{
      final ref = FirebaseStorage.instance.ref().child('profileImage').child('$_name+.jpg');
      await ref.putFile(pickedImageFile);
      profilePic = await ref.getDownloadURL();


    }catch(error){
      print("Error occured while uploading profile photo to firebase storage: $error");
    }
    setState(() {
      profileBool = true;
      _pickedImageBool = true;
      _pickedImage = pickedImageFile;
      Navigator.pop(context);
    });
    // Navigator.pop(context);
  }

  void _removeImage(){
    setState(() {
      profileBool = false;
      _pickedImageBool = false;
      _pickedImage = null;
      Navigator.pop(context);
    });
    // Navigator.pop(context);
  }
  //*********************SETTING PROFILE PHOTO*****************************8



  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    getDataFromFireStore();
    _pickedImage = File('images');

  }

  @override
  Widget build(BuildContext context) {
    double? _expandedHeight = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            //// VERY VERY IMPORTANT TO ASSIGN THE controller
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)
                    )
                ),
                automaticallyImplyLeading: false,
                backgroundColor:Colors.deepPurple.shade600,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context,BoxConstraints constraints){
                      top = constraints.biggest.height;
                      return Container(
                        decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //   colors: [Colors.purple.shade200,Colors.white60],
                          //   begin: const FractionalOffset(0.0, 0.0),
                          //   end: const FractionalOffset(1.0,0.0),
                          //   stops: [1.0,0.0],
                          //   tileMode: TileMode.clamp
                          // )
                        ),
                        child: FlexibleSpaceBar(
                          centerTitle: true,
                          collapseMode: CollapseMode.parallax,
                          background:_pickedImageBool?Image.file(_pickedImage!,fit: BoxFit.cover,):Image.asset('images/search_background.jpg',fit: BoxFit.cover,),
                          //Image.asset('images/search_background.jpg',fit: BoxFit.cover,) ,
                          //Image.file(_pickedImage!,fit: BoxFit.cover,)
                          title: AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.bounceInOut,
                            //If the top is collapsing make the flexible space bar visible else let it stay invisible
                            opacity: top <= _expandedHeight ? 1.0:0.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.purple),
                                      image: DecorationImage(
                                          image: NetworkImage("https://llandscapes-10674.kxcdn.com/wp-content/uploads/2018/10/How-to-build-a-strong-landscape-Instagram-account.jpg"),
                                      fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                 Padding(
                                   padding: const EdgeInsets.only(top:10),
                                   child: Text(_name,
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 20.0,
                                       color: Colors.grey.shade300,
                                       fontStyle: FontStyle.normal
                                     ),),
                                 )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                //************This is a must when using SilverAppBar
                expandedHeight: _expandedHeight,
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return accountInfo(context);
              }, childCount: 1))
            ],
          ),

          //***********************Camera Button
          _buildFab(_expandedHeight)
        ],
      ),
    );
  }



  Widget accountInfo(BuildContext context) {
    //**************************This is for changing the theme back and forth
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        profileTitle('User bag'),
        Divider(
          height: 2,
          thickness: 2.5,
        ),
        listTile(IconClass.cart, 'Cart', '', Icons.navigate_next),
        listTile(IconClass.myOrders, 'My orders', '', Icons.navigate_next),

        profileTitle('Account Info'),
        Divider(
          height: 2,
          thickness: 2.5,
        ),
        listTile(IconClass.gmail, _email, _joinedAt,
            MaterialIcons.account_circle),
        listTile(IconClass.phone, 'Mobile No', _phoneNo.toString(),
            MaterialIcons.phone_in_talk),
        listTile(IconClass.shipment, 'Shipment', 'Track your shipment', null),
        listTile(IconClass.phone, 'Help', 'contact us', null),


        profileTitle("Settings"),
        Divider(
          height: 2,
          thickness: 2.5,
        ),
        SizedBox(
          height: 5,
        ),
        //*****************Have used list_tile_switch dependency to use the below switch button
        listTileSwitch(themeChange,context),
        listTile(IconClass.logOut, "Log out", "", null)
      ],
    );
  }

  Padding profileTitle(String title) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
        child: Text(
          "$title",
          style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
      )

    ;
  }

  ListTile listTile(IconData leadingIcon, String title, String subtitle,
      IconData? trailingIcon) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.deepPurple.shade50,
        child: Icon(leadingIcon),
      ),
      title: Text(
        "$title",
        style:
            TextStyle(fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
      ),
      subtitle: Text(
        "$subtitle",
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12.0),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 10),
        child: Container(
          height: 20,
          width: 20,
          child: Icon(
            trailingIcon,
            size: 30,
          ),
        ),
      ),
      onTap: () {
        if(title=='Cart'){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
        }else if(title =='Log out'){
          _showFirebaseLogoutDialog('Signing out', 'Are you sure you want to logout?');
        }
      },
    );
  }

  listTileSwitch(DarkThemeProvider themeChange,BuildContext context) {
    return ListTileSwitch(
      //Initially themeChange.darkTheme is false;
      value: themeChange.darkTheme,
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.deepPurple.shade50,
        child: Icon(IconClass.darkMode),
      ),
      onChanged: (value) {
        setState(() {
          //If the value we got is true then dark theme will be activated
          themeChange.darkTheme = value;
        });
      },
      visualDensity: VisualDensity.comfortable,
      switchType: SwitchType.cupertino,
      switchActiveColor: Colors.indigo,
      title: Text('Dark Mode'),
    );
  }

  Widget _buildFab(double expandedHeight){
    //Defining the defaultTopMargin which will be used in Positioned widget for top margin
    final double defaultTopMargin = expandedHeight + 30;
    //Scale(this varies from 0 - 1)
    final double scaleStart = 160;
    final double scaleEnd = scaleStart/2;

    //Defining changing top and scale variables
    double top = defaultTopMargin;
    double scale = 1.0;

    //_scrollController.hasClients listens to scroll up or scroll down made by the user
    if(_scrollController.hasClients){
      //offset --> it is the amount by which the the FAB has been scrolled from its normal position
      double offset = _scrollController.offset;
      top -=offset;
      if(offset < defaultTopMargin - scaleStart){
        //If offset is small---> Don't scale down do nothing;
        scale = 1.0;
      }else if(offset < defaultTopMargin - scaleEnd){
        //If offset is between scaleStart and scaleEnd ---> Scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      }else{
        //if offset is too high ----> scaleDown fully
        scale = 0.0;
      }
    }

    //We will be using the transform Widget to move and scale the FAB attached to the silverAppBar
    return Positioned(
      top: top,
      right: 16,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          onPressed: (){
            _showCameraOptions('Choose image from');
          },
          heroTag: 'cameraButton',
          child: Icon(IconClass.camera),
          backgroundColor: Colors.purple,
        ),

      ),
    );


  }

  Future<void> _showFirebaseLogoutDialog(String title,String subtitle) async {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.info_outline,color: Colors.red,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(subtitle),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(

                  onPressed: ()=>Navigator.pop(context),
                  child: Text("Cancel",style: TextStyle(
                      color: Colors.grey
                  ),)),

              TextButton(

                  onPressed: ()async{
                    try{
                      await _auth.signOut();
                    }catch(error){
                      print('Firebase logout Error occured $error');
                    }
                  },
                  child: Text("Ok",style: TextStyle(
                      color: Colors.redAccent
                  ),)),
            ],
          )
        ],
      );
    });
  }

  _showCameraOptions(String title) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
              child: Icon(Icons.info_outline,color: Colors.red,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(title),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),

        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: _pickImageFromCamera,
                      icon: Icon(MaterialIcons.photo_camera)),
                  SizedBox(width: 10,),
                  Text('Camera',style:TextStyle(
                    fontSize: 18,
                  ))
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  IconButton(
                      onPressed: _pickImageGallery,
                      icon: Icon(MaterialCommunityIcons.crop_landscape)),
                  SizedBox(width: 10,),
                  Text('Gallery',style:TextStyle(
                    fontSize: 18,
                  ))
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  IconButton(
                      onPressed: _removeImage,
                      icon: Icon(MaterialIcons.remove_circle_outline)),
                  SizedBox(width: 10,),
                  Text('Remove',style:TextStyle(
                    fontSize: 18,
                    color: Colors.redAccent.shade400
                  ))
                ],
              )
            ],
          )
        ],
      );
    });
  }

}
