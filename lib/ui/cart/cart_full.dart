

import 'package:e_commerce_app/models/cart_attr.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/dark_theme_provider.dart';
import 'package:e_commerce_app/provider/products.dart';
import 'package:e_commerce_app/ui/product_details/product_details_screen.dart';
import 'package:e_commerce_app/util/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class CartFull extends StatefulWidget {
  CartFull({Key? key,});

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {


  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    final cartAttr = Provider.of<CartAttr>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);

    double discount = (cartAttr.price! - (0.1 * cartAttr.price!.toDouble()));

    
    return Container(

      margin: EdgeInsets.only(right: 10,top: 10),
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        // color: themeChange.darkTheme? Colors.transparent: Color(0xffC2C2C2),
        gradient: themeChange.darkTheme? LinearGradient(colors: [Colors.grey,Colors.black])
            : LinearGradient(colors: [Color(0xffBBB9B9),Colors.white],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight ),
        borderRadius: BorderRadius.only(
          bottomRight: const Radius.circular(22),
            topRight: const Radius.circular(22)),
        border: Border.all(color: Styles.themeData(false, context).accentColor,width: 2.5)
      ),

      child: Row(
        children: [
          Container(
            height:MediaQuery.of(context).size.height * 0.25,
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(cartAttr.imageUrl!),
                  fit: BoxFit.cover)
            ),
          ),

          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text("${cartAttr.title}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeChange.darkTheme ? Colors.white : Colors.black
                          ) ,),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: InkWell(
                          onTap: (){
                            cartProvider.removeItemFromCart(cartAttr.id);
                          },
                          child: Icon(MaterialCommunityIcons.cart_remove,color: Styles.themeData(false, context).accentColor),
                        ),
                      )

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("MRP :",
                        style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: themeChange.darkTheme ? Colors.white : Colors.black
                        ) ,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("\$ ${cartAttr.price}",
                          style: TextStyle(
                            fontStyle: FontStyle.italic
                          ),),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Discount :",
                        style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: themeChange.darkTheme ? Colors.white : Colors.black
                        ) ,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("\$ ${discount.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sub total :",
                        style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: themeChange.darkTheme ? Colors.white : Colors.black
                        ) ,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("\$ ${(discount * cartAttr.quantity!).toStringAsFixed(2)}",
                            style:TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity",
                          style:TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: themeChange.darkTheme ? Colors.white : Colors.black
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(

                              onTap: cartAttr.quantity!<2 ?null:(){
                                cartProvider.reduceItemByOne(cartAttr.id, cartAttr.title,
                                    cartAttr.quantity, cartAttr.price,
                                    cartAttr.imageUrl);
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                    gradient: themeChange.darkTheme? LinearGradient(colors: [Colors.white70,Colors.white])
                                        : LinearGradient(colors: [Colors.white,Colors.grey.shade300],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Icon(Feather.minus,size: 18,color:themeChange.darkTheme? Colors.black: Colors.blue,),
                              ),
                            ),
                          ),
                          Text("${cartAttr.quantity}",
                            style: TextStyle(
                              fontSize: 17
                            ),),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: (){
                                cartProvider.updateCart(cartAttr.id!);

                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                    gradient: themeChange.darkTheme? LinearGradient(colors: [Colors.white70,Colors.white])
                                        : LinearGradient(colors: [Colors.white,Colors.grey.shade300],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Icon(Feather.plus,size: 20,color:themeChange.darkTheme? Colors.black: Colors.blue,),
                              ),
                            ),
                          ),
                        ],
                      )


                    ],
                  )

                ],
              ),
            ),
          )

        ],
      )
    );
  }
}
