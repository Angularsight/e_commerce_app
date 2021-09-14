


import 'package:badges/badges.dart';
import 'package:e_commerce_app/models/ProductModel.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/network/product_api.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/dark_theme_provider.dart';
import 'package:e_commerce_app/ui/feed/feeds_dialog.dart';
import 'package:e_commerce_app/ui/product_details/product_details_screen.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:e_commerce_app/util/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class FeedItem extends StatefulWidget {
  const FeedItem({Key? key}) : super(key: key);

  @override
  _FeedItemState createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {


  //String productUrl = "https://static.langimg.com/thumb/msid-82028507,imgsize-63684,width-700,height-525,resizemode-75/navbharat-times.jpg";
  //String passingImage = 'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F23%2F2018%2F04%2F06%2Fzappos-floral-sneakers.jpg&q=85';
  @override
  Widget build(BuildContext context) {
    //This is the product passed from the staggered list view..Hence the class we use in the provider is Product and not products
    final productAttr = Provider.of<Product>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    Future<void> _showDialogBox(IconData cartIcon,IconData viewIcon) async {
      showDialog(
          context: context, builder: (context){
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          content: Container(
            constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: MediaQuery.of(context).size.height*0.4
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor
            ),
            child: Image.network(productAttr.imageUrl!,fit: BoxFit.cover,),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: (){
                            cartProvider.addToCart(productAttr.id, productAttr.title,
                                productAttr.quantity, productAttr.price, productAttr.imageUrl);
                            setState(() {
                              cartIcon = Icons.shopping_cart;
                            });
                            // Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: Icon(cartIcon,),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Add to cart",style: TextStyle(fontSize: 12)),
                        )
                      ],
                    ),

                    Column(
                      children: [
                        InkWell(

                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return ChangeNotifierProvider.value(
                                  value: productAttr,
                                  child: ProductDetailsScreen(),
                                );
                              }));
                            },
                          child:CircleAvatar(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: Icon(viewIcon,),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("View product",style: TextStyle(fontSize: 12)),
                        )
                      ],
                    ),

                  Column(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: Icon(Feather.share,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Share",style: TextStyle(fontSize: 12)),
                      )
                    ],
                  ),



                ],
              ),
            )
          ],
        );
      });
    }

    return Stack(
      children: [
        Container(
        height: 400,
        width: 250,
        decoration: BoxDecoration(
          border: Border.all(color:!themeChange.darkTheme? Styles.themeData(false, context).accentColor
              : Colors.blue,
              width: themeChange.darkTheme? 3:2),

          color: Styles.themeData(false, context).backgroundColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ChangeNotifierProvider.value(
                      value: productAttr,
                      child: ProductDetailsScreen());
                }));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  // constraints: BoxConstraints(
                  //   minHeight: 100,
                  //   maxHeight: MediaQuery.of(context).size.height * 0.3
                  // ),
                  child: Image.network(productAttr.imageUrl!,fit: BoxFit.contain,),
                  ),
                ),
            ),

            Container(
              padding: EdgeInsets.only(left: 5),
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4,),
                  Text("${productAttr.title}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color : Colors.black
                    ),),
                  SizedBox(height: 8,),
                  Text("Price : \$ ${productAttr.price}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color : Colors.black87
                    ),),
                  SizedBox(height: 8,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity: ${productAttr.quantity}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color : Colors.grey.shade600
                        ),),

                      InkWell(
                        onTap: (){
                          _showDialogBox(Icons.shopping_cart_outlined,Feather.eye);
                        },
                        child: Icon(IconClass.more,color: Colors.grey,),
                      )

                    ],
                  )
                ],
              ),
            )
          ],
        ),
        ),

        Positioned(
          top: 0,
          child: Badge(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
            badgeColor: themeChange.darkTheme? Colors.deepPurple:Colors.blue,
            shape: BadgeShape.square,
            toAnimate: true,
            animationDuration: Duration(milliseconds: 2000),
            animationType: BadgeAnimationType.slide,
            badgeContent: Text("New"),
          ),
        )


      ],
    );
  }
}

