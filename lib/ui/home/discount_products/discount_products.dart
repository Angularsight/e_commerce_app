



import 'package:badges/badges.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/ui/home/home_classes.dart';
import 'package:e_commerce_app/ui/product_details/product_details_screen.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class DiscountProducts extends StatefulWidget {
  const DiscountProducts({Key? key,}) : super(key: key);

  @override
  _DiscountProductsState createState() => _DiscountProductsState();
}

class _DiscountProductsState extends State<DiscountProducts> {
  IconData cartIcon = IconClass.cart;
  @override
  Widget build(BuildContext context) {

    //Using the ChangeNotifierProvider.value() we receive the changes in the productList which we will display here
    final discountProductDetails = Provider.of<Product>(context);


    return Column(
      children: [
        Stack(
          children: [
            Material(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ChangeNotifierProvider.value(
                        value: discountProductDetails,
                        child: ProductDetailsScreen());
                  }));
                },
                child: Container(
                  height: 180,
                  width: 200
                  ,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                    image: DecorationImage(image: NetworkImage('${discountProductDetails.imageUrl}'),
                        fit: BoxFit.cover)
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 2,
              right: 0,
              child: Badge(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                shape: BadgeShape.square,
                badgeContent: Text("10% off",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                badgeColor: Colors.redAccent,
                toAnimate: true,
                animationType: BadgeAnimationType.slide,
                animationDuration: Duration(milliseconds: 2000),
              ),
            ),


          ],
        ),

        discountOfferBottomPart(context,discountProductDetails)

      ],
    );
  }

  Container discountOfferBottomPart(BuildContext context,Product discountProductDetails) {
    final cartProvider = Provider.of<CartProvider>(context);


    return Container(
        height: 120,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)
          ),
          border: Border.all(color: Colors.grey.shade800,width: 2)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("MRP",
                      style: TextStyle(
                        fontFamily: 'Acme',
                        fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),),
                    Text("\$ ${discountProductDetails.price}",
                      style: TextStyle(
                          fontFamily: 'Acme',
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),)
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("After Discount",
                      style: TextStyle(
                          fontFamily: 'Acme',
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),),
                    Text("\$ ${(discountProductDetails.price!.toDouble() - (0.1*discountProductDetails.price!.toDouble())).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                          fontFamily: 'Acme',
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add to cart",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500
                      ),),
                    Material(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            cartIcon = Icons.check;
                          });
                          cartProvider.addToCart(discountProductDetails.id, discountProductDetails.title,
                              discountProductDetails.quantity,
                              discountProductDetails.price, discountProductDetails.imageUrl);
                        },
                        child: Icon(cartIcon),
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      );
  }
}
