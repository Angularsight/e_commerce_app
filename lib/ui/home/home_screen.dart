

import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:backdrop/sub_header.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/ProductModel.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/network/product_api.dart';
import 'package:e_commerce_app/provider/dark_theme_provider.dart';
import 'package:e_commerce_app/provider/products.dart';
import 'package:e_commerce_app/ui/feed/feed_screen.dart';
import 'package:e_commerce_app/ui/home/brands/brand_navigation_rail.dart';
import 'package:e_commerce_app/ui/home/discount_products/discount_products.dart';
import 'package:e_commerce_app/ui/home/home_classes.dart';
import 'package:e_commerce_app/ui/product_details/product_details_screen.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:e_commerce_app/util/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import 'category/category_widget.dart';
import 'home_back_layer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late Future<ProductModel> allProducts;

  List swiperImages = [
    'images/swiper_apple.jpg',
    'images/swiper_dell.png',
    'images/swiper_handm.png',
    'images/swiper_lv.png',
    'images/swiper_nike.jpg',
    'images/swiper_samsung.jpg'
  ];

  //******************Using firebase uploaded products to show MERCHANT PRODUCTS section*****************
  var fireStoreDb = FirebaseFirestore.instance.collection('products').snapshots();


  @override
  Widget build(BuildContext context) {
    //For the discount products section
    final productsData = Provider.of<Products>(context);

    final themeChange = Provider.of<DarkThemeProvider>(context);
    final theme = Theme.of(context);

    return Container(
      child: Center(
        child:BackdropScaffold(
            backLayerBackgroundColor: theme.accentColor,
          frontLayerScrim: themeChange.darkTheme? Styles.themeData(true, context).scaffoldBackgroundColor
              :Colors.grey.shade300,
          //******************headerHeight is responsible for backLayer height
          headerHeight: MediaQuery.of(context).size.height*0.25,
          appBar: BackdropAppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple
              ),
            ),

            //**************Leading is the attribute and BackdropToggleButton is the widget
            // which makes this transition or animation possible from front layer to back layer *************************
            leading: BackdropToggleButton(
              icon: AnimatedIcons.home_menu,
            ),
            title: Text("Home"),
            actions: <Widget>[

              //**********************This displays the profile icon on right top
              IconButton(onPressed: (){},
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(IconClass.profile,color: Colors.deepPurpleAccent,),
                  ))
            ],
          ),

          //***********************backLayer is where we design our backdrop layout***********************
          backLayer: BackHomeLayer(),

          //***************front layer is the actual home screen*****************
          frontLayer:SingleChildScrollView(
            child: Column(

              children: [
                //*********************AUTOPLAY SCREEN***************************
                Container(
                height: 250,
                margin: EdgeInsets.only(bottom: 25),
                width: double.infinity,
                child: Carousel(
                  onImageTap: (index){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ChangeNotifierProvider.value(
                          value: productsData.carouselProducts[index],
                          child: ProductDetailsScreen());
                    }));
                  },
                  boxFit: BoxFit.cover,
                  autoplay: true,
                  autoplayDuration: Duration(milliseconds: 3000),
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 6.0,
                  dotIncreasedColor: Colors.deepPurple,
                  dotBgColor: Colors.transparent,
                  dotPosition: DotPosition.bottomCenter,
                  dotVerticalPadding: 10.0,
                  showIndicator: true,
                  indicatorBgPadding: 7.0,
                  images: [
                    NetworkImage('https://images.squarespace-cdn.com/content/v1/548ec3bee4b068057bfb6db7/1555524365342-FSB67T1LCR7M776FHNTB/palm+trees+bag.jpg?format=1000w'),
                    NetworkImage('https://c.files.bbci.co.uk/44CF/production/_117751671_satan-shoes1.jpg'),
                    NetworkImage("https://5.imimg.com/data5/IU/JV/MY-22625489/german-silver-stone-studs-500x500.jpg"),
                    NetworkImage("https://m.media-amazon.com/images/I/718398O4TVL._SL1500_.jpg"),
                    NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Table_Tennis_Table_Blue.svg/440px-Table_Tennis_Table_Blue.svg.png")
                  ],
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0,3))
                  ]

                ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom: 10,left: 10),
                  child: Row(
                    children: [
                      Text("Categories",
                        style:TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ) ,),
                    ],
                  ),
                ),


                //************************CATEGORIES*********************************
                Container(
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: HomeClass.categories.length,
                      itemBuilder: (BuildContext context,int index){
                        return CategoryWidget(index:index);
                      }),
                ),

                //****************POPULAR BRANDS**********************
                Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom: 20,left: 10),
                  child: Row(
                    children: [
                      Text("Popular Brands",
                        style:TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ) ,),
                      Spacer(),

                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      height: 210,
                      width: MediaQuery.of(context).size.width *0.95,
                      child: Swiper(
                        onTap: (index){
                          Navigator.push(context,MaterialPageRoute(builder: (context){
                            return BrandNavigationRail(index: index);
                          }));
                        },
                        itemCount: swiperImages.length,
                        itemBuilder: (BuildContext context,int index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(swiperImages[index],fit: BoxFit.cover,),
                              ),
                            );
                      },),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: themeChange.darkTheme? Colors.grey.shade700 : Colors.grey.shade400,
                            spreadRadius: 2,
                            blurRadius:10 ,
                            offset: Offset(5,10)
                          )
                        ]
                      ),
                    ),
                  ),
                ),


                //*********************DISCOUNT PRODUCTS***********************
                Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom: 20,left: 10),
                  child: Row(
                    children: [
                      Text("Discount offers",
                        style:TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ) ,),
                      Spacer(),

                    ],
                  ),
                ),

                Container(
                  height: 320,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                  ),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index){
                        return ChangeNotifierProvider.value(
                            value: productsData.discountProducts[index],
                            child: DiscountProducts());
                      },
                      separatorBuilder:(context,index)=>SizedBox(width: 20,),
                      itemCount: productsData.discountProducts.length),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom: 20,left: 10),
                  child: Row(
                    children: [
                      Text("Merchant Products",
                        style:TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ) ,),

                    ],
                  ),
                ),


                StreamBuilder<QuerySnapshot>(
                    stream: fireStoreDb,
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasData){
                        print('Entered if statement*******************');
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 320,
                          width: double.infinity,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                print('Entered ListView separated*************************');
                                var wantedProduct = snapshot.data!.docs[index];
                                return ChangeNotifierProvider.value(
                                  value: Product(
                                      title: wantedProduct['productName'],
                                      id: wantedProduct['productId'],
                                      price: double.parse(wantedProduct['price']),
                                      imageUrl: wantedProduct['imageUrl'],
                                      description: wantedProduct['description'],
                                      productCategoryName: wantedProduct['category'],
                                      brand: wantedProduct['brand'],
                                      isFavorite: true,
                                      isPopular: true
                                  ),
                                  child: DiscountProducts(),

                                );
                              }, 
                              separatorBuilder: (context,index)=>SizedBox(width: 20,), 
                              itemCount: snapshot.data!.docs.length),
                        );
                      }else{
                        return CircularProgressIndicator();
                      }
                })





              ],
            ),
          )
        )
      ),
    );
  }
}