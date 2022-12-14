import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/dark_theme_provider.dart';
import 'package:e_commerce_app/ui/cart/cart_empty.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:e_commerce_app/util/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'cart_full.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    //This is the list which will hold all the items that the user has put into cart

    final cartProvider = Provider.of<CartProvider>(context);

    Future<void> _showDeleteAllDialogBox(String title,String subtitle,Function fct) async {
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
                InkWell(

                    onTap: ()=>Navigator.pop(context),
                    child: Text("Cancel",style: TextStyle(
                      color: Colors.grey
                    ),)),
                InkWell(

                    onTap: (){
                      fct();
                      Navigator.pop(context);
                    },
                    child: Text("Delete all",style: TextStyle(
                        color: Colors.red
                    ),))
              ],
            )
          ],
        );
      });
    }


    //Basically an if else statement executed using ternary operator
    return cartProvider.getCartItems.isEmpty ? Scaffold(
      body: CartEmpty(),
    ) : Scaffold(
      appBar: AppBar(
        title: Text("Cart Items : 5"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
                onTap: (){
                  _showDeleteAllDialogBox('Delete All',
                      'Are you sure you want to delete your cart?',
                      cartProvider.clearCart);
                  // cartProvider.clearCart();
                },
                child: Icon(IconClass.trash)),
          ),
        ],
        backgroundColor: themeChange.darkTheme?
        Styles.themeData(true, context).backgroundColor:Styles.themeData(true, context).accentColor ,
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 80),
        child: ListView.builder(
            itemCount: cartProvider.getCartItems.length,
            itemBuilder: (BuildContext context,int index){
              var requiredProduct = cartProvider.getCartItems.values.toList()[index];
              return ChangeNotifierProvider.value(
                  value: cartProvider.getCartItems.values.toList()[index],
                  child: CartFull()
              );
        }),
      ),
      bottomSheet: checkoutWidget(context,cartProvider),
    );
  }

  Widget checkoutWidget(BuildContext context, CartProvider cartProvider) {
    return Container(
      margin: EdgeInsets.only(bottom: 10,top: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Material(
              child: InkWell(
                onTap: (){},
                splashColor: Colors.greenAccent,
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.redAccent
                  ),
                  child: Center(
                    child: Text("Checkout",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                  ),
                ),

              ),
            ),
          ),
          Spacer(),
          Text("Total : ",
            style: TextStyle(
                fontSize: 18,
                // color: Colors.black,
                fontWeight: FontWeight.w500
            ),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("\$ ${(cartProvider.getCheckoutAmount).toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 18,
                  // color: Colors.white,
                  fontWeight: FontWeight.w500
              ),),
          )
        ],
      ),
    );
  }
}
