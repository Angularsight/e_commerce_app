


import 'package:badges/badges.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/network/product_api.dart';
import 'package:e_commerce_app/provider/products.dart';
import 'package:e_commerce_app/ui/feed/feed_item.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:e_commerce_app/util/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategoryFeeds extends StatelessWidget {
  
  final String category;
  const CategoryFeeds({Key? key,required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Using the MultiProvider class to get all the data
    final productProvider = Provider.of<Products>(context);
    //Code below selects all products in the products list which have the same category as the
    // category received by the CategoryFeeds class
    List<Product> categoryProducts = productProvider.products.where((element) =>
        element.productCategoryName!.toLowerCase().contains(category.toLowerCase())).toList();
    print(categoryProducts);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: Icon(Icons.toc_outlined,size: 35,),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: (){},
              child: Stack(
                children: [
                  Icon(IconClass.cart),
                  Badge(
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
          itemCount: categoryProducts.length,
          itemBuilder:(BuildContext context,int index){
            return ChangeNotifierProvider.value(
              value: categoryProducts[index],
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