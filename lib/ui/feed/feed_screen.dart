
import 'package:badges/badges.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/network/product_api.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/products.dart';
import 'package:e_commerce_app/ui/cart/cart_screen.dart';
import 'package:e_commerce_app/ui/feed/feed_item.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:e_commerce_app/util/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {


  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Using the MultiProvider class to get all the data
    final productProvider = Provider.of<Products>(context);
    //Getting a list of products
    List<Product> productList = productProvider.products;


    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: Icon(Icons.toc_outlined,size: 35,),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
              },
              child: Stack(
                children: [
                  Icon(IconClass.cart),
                  cartProvider.getCartItems.isNotEmpty? Badge(
                    position: BadgePosition.topStart(start: -5),
                  ):Badge(
                    badgeColor: Colors.transparent.withOpacity(0),
                    position: BadgePosition.topStart(start: -5),
                  )

                ],
              ),
            ),
          ),

        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 6,
            itemCount: productList.length,
            itemBuilder:(BuildContext context,int index){
              return ChangeNotifierProvider.value(
                  value: productList[index],
                  child: FeedItem(),

              );
            },
            staggeredTileBuilder: (int index)=>new StaggeredTile.count(3, index.isEven?5:6),
          mainAxisSpacing: 8,
          crossAxisSpacing: 7,
        ),
      ) ,
    );
  }
}