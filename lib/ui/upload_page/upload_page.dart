import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/ui/main_screen/main_screens.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:uuid/uuid.dart';

import '../bottom_navigation_bar.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _formKey = GlobalKey<FormState>();

  //TextEditing controllers
  final TextEditingController _productNameEdit = TextEditingController();
  final TextEditingController _descriptionEdit = TextEditingController();
  final TextEditingController _priceEdit = TextEditingController();
  final TextEditingController _imageUrlEdit = TextEditingController();
  final TextEditingController _categoryEdit = TextEditingController();
  final TextEditingController _quantityEdit = TextEditingController();
  final TextEditingController _brandEdit = TextEditingController();

  //Product fields
  String _productName = '';
  String _description = '';
  String _price = '';
  String _imageUrl = '';
  String _brand = '';
  String _categoryName = '';
  int _quantity = 0;
  var url = '';

  //Focus nodes
  final FocusNode _productIdFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _imageUrlFocus = FocusNode();
  final FocusNode _categoryFocus = FocusNode();
  final FocusNode _quantityFocus = FocusNode();
  final FocusNode _brandFocus = FocusNode();



  //Image
  late File? _pickedImage;
  bool _pickedImageBool = false;

  //***************FIREBASE VARIABLES***************
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Random productID generator
  var uuid = Uuid();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productIdFocus.dispose();
    _descriptionFocus.dispose();
    _priceFocus.dispose();
    _imageUrlFocus.dispose();
    _categoryFocus.dispose();
    _quantityFocus.dispose();
    _brandFocus.dispose();
  }

  //*********************SETTING PRODUCT PHOTO*****************************8
  void _pickImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImageBool = true;
      _pickedImage = pickedImageFile;
    });
    // Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImageBool = true;
      _pickedImage = pickedImageFile;
    });
    // Navigator.pop(context);
  }

  void _removeImage() {
    setState(() {
      _pickedImageBool = false;
      _pickedImage = null;
    });
    // Navigator.pop(context);
  }
  //*********************SETTING PRODUCT PHOTO*****************************8

  void uploadDataToFirebase()async{
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
      try{
        //*************UPLOADING IMAGE TO FIREBASE USING FIREBASE STORAGE***************
        final ref = FirebaseStorage.instance.ref().child('productImage').child(_productName+'.jpg');
        await ref.putFile(_pickedImage!);
        url = await ref.getDownloadURL();


        final User user = _auth.currentUser!;
        final userId = user.uid;
        final productId = uuid.v4();
        FirebaseFirestore.instance.collection('products').doc(productId).set({
          'productId':userId,
          'productName':_productName,
          'price':_price,
          'description':_description,
          'category':_categoryName,
          'brand':_brand,
          'quantity':_quantity,
          'imageUrl':url
            });
      }catch(error){
        _showFirebaseSignUpError('Firebase Upload','Error uploading data to firebase');
        print('Error occured in uploading the product:$error');
      }
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        RotatedBox(
          quarterTurns: 2,
          child: WaveWidget(
            config: CustomConfig(
              gradients: [
                [Colors.red, Color(0xEEF44336)],
                [Colors.red[800]!, Color(0x77E57373)],
                [Colors.orange, Color(0x66FF9800)],
                [Colors.yellow, Color(0x55FFEB3B)]
              ],
              durations: [35000, 19440, 10800, 6000],
              heightPercentages: [0.1, 0.12, 0.14, 0.16],
              blur: MaskFilter.blur(BlurStyle.solid, 10),
              gradientBegin: Alignment.topCenter,
              gradientEnd: Alignment.bottomRight,
            ),
            waveAmplitude: 2,
            // heightPercentages: [0.25, 0.26, 0.28, 0.31],
            size: Size(
              double.infinity,
              double.infinity,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextFormField(
                              controller: _productNameEdit,
                              key: ValueKey('productName'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'ProductId is needed';
                                }
                                return null;
                              },

                              //***********Shows next button in the keypad in place of enter button
                              textInputAction: TextInputAction.next,
                              //***************Once the user hits enter(or next) It will direct the focus to the next field ie password in our case
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_priceFocus),

                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  hintText: 'Product Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none))),

                              //***************WILL USE THIS IN FIREBASE*************
                              onSaved: (name) {
                                _productName = name!;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: TextFormField(
                              controller: _priceEdit,
                              key: ValueKey('price'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the price of your product';
                                }
                                return null;
                              },

                              //***********Assigning the focus node for the phoneNo field---->Used in the name field
                              focusNode: _priceFocus,
                              //***********Shows next button in the keypad in place of enter button
                              textInputAction: TextInputAction.next,
                              //***************Once the user hits enter(or next) It will direct the focus to the next field ie email in our case
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_imageUrlFocus),

                              //*********This attribute makes sure that the input is only numbers so that user cannot enter alphabets for phone no

                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  hintText: 'Price',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none))),

                              //***************WILL USE THIS IN FIREBASE*************
                              onSaved: (value) {
                                _price = value!;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildImageUploadRow(context),


                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextFormField(
                              controller: _categoryEdit,
                              key: ValueKey('category'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Category needed';
                                }
                                return null;
                              },

                              //***********Shows next button in the keypad in place of enter button
                              focusNode: _categoryFocus,
                              textInputAction: TextInputAction.next,
                              //***************Once the user hits enter(or next) It will direct the focus to the next field ie password in our case
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_brandFocus),

                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  hintText: 'Category',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none))),

                              //***************WILL USE THIS IN FIREBASE*************
                              onSaved: (category) {
                                _categoryName = category!;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextFormField(
                              controller: _brandEdit,
                              key: ValueKey('brand'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Brand field required';
                                }
                                return null;
                              },

                              //***********Assigning the focus node for the phoneNo field---->Used in the name field
                              focusNode: _brandFocus,
                              //***********Shows next button in the keypad in place of enter button
                              textInputAction: TextInputAction.next,
                              //***************Once the user hits enter(or next) It will direct the focus to the next field ie email in our case
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_quantityFocus),

                              //*********This attribute makes sure that the input is only numbers so that user cannot enter alphabets for phone no

                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  hintText: 'Brand',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none))),

                              //***************WILL USE THIS IN FIREBASE*************
                              onSaved: (brand) {
                                _brand = brand!;
                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            child: TextFormField(
                              controller: _quantityEdit,
                              key: ValueKey('quantity'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Quantity required';
                                }
                                return null;
                              },

                              //***********Assigning the focus node for the phoneNo field---->Used in the name field
                              focusNode: _quantityFocus,
                              //***********Shows next button in the keypad in place of enter button
                              textInputAction: TextInputAction.next,
                              //***************Once the user hits enter(or next) It will direct the focus to the next field ie email in our case
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_descriptionFocus),

                              //*********This attribute makes sure that the input is only numbers so that user cannot enter alphabets for phone no

                              keyboardType: TextInputType.numberWithOptions(decimal: false),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).backgroundColor,
                                  hintText: 'Quantity',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none))),

                              //***************WILL USE THIS IN FIREBASE*************
                              onSaved: (description) {
                                _description = description!;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: TextFormField(
                          controller: _descriptionEdit,
                          key: ValueKey('description'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Description required';
                            }
                            return null;
                          },

                          //***********Assigning the focus node for the phoneNo field---->Used in the name field
                          focusNode: _descriptionFocus,
                          //***********Shows next button in the keypad in place of enter button
                          textInputAction: TextInputAction.done,
                          //***************Once the user hits enter(or next) It will direct the focus to the next field ie email in our case
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_quantityFocus),

                          //*********This attribute makes sure that the input is only numbers so that user cannot enter alphabets for phone no

                          keyboardType: TextInputType.name,
                          maxLines: 10,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              hintText: 'Description',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none))),

                          //***************WILL USE THIS IN FIREBASE*************
                          onSaved: (description) {
                            _description = description!;
                          },
                        ),
                      ),
                    ),





                  ],
                ),
              )),
        ),
      ]),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.redAccent),
        child: TextButton(
          onPressed:() {
            uploadDataToFirebase();
            setState(() {
              _descriptionEdit.clear();
              _quantityEdit.clear();
              _brandEdit.clear();
              _categoryEdit.clear();
              _productNameEdit.clear();
              _priceEdit.clear();
            });
            Navigator.push(context, MaterialPageRoute(builder: (context)
            =>MainScreens()));

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Upload',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              SizedBox(
                width: 12,
              ),
              Icon(
                Feather.upload,
                color: Colors.amberAccent,
              )
            ],
          ),
        ),
      ),
        resizeToAvoidBottomInset: false
    );
  }

  Row buildImageUploadRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.25,
            child: _pickedImageBool
                ? Image.file(
                    _pickedImage!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'images/search_background.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: _pickImageFromCamera,
                      icon: Icon(MaterialIcons.photo_camera)),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Camera',
                      style: TextStyle(
                        fontSize: 18,
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: _pickImageGallery,
                      icon: Icon(MaterialCommunityIcons.crop_landscape)),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Gallery',
                      style: TextStyle(
                        fontSize: 18,
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: _removeImage,
                      icon: Icon(MaterialIcons.remove_circle_outline)),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Remove',
                      style: TextStyle(
                          fontSize: 18, color: Colors.redAccent.shade400))
                ],
              )
            ],
          ),
        )
      ],
    );
  }


  Future<void> _showFirebaseSignUpError(String title,String subtitle) async {
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
                  child: Text("Ok",style: TextStyle(
                      color: Colors.grey
                  ),)),
            ],
          )
        ],
      );
    });
  }
}
