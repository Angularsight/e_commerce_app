



import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/ui/home/home_classes.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class FeedsDialog extends StatelessWidget {
  final String productId;
  const FeedsDialog({Key? key,required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Container();
    //   backgroundColor:Colors.transparent,
    //   elevation: 5,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(20)
    //   ),
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Container(
    //           constraints: BoxConstraints(
    //             minHeight: 150,
    //             maxHeight: MediaQuery.of(context).size.height*0.5
    //           ),
    //           width: double.infinity,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor
    //             ),
    //           child: Image.network(productData.imageUrl!),
    //           ),
    //
    //         Container(
    //           color: Theme.of(context).backgroundColor,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Flexible(
    //                   child: InkWell(
    //                     onTap: (){},
    //                     child: CircleAvatar(
    //                       backgroundColor: Theme.of(context).backgroundColor,
    //                       child: Icon(IconClass.cart),
    //                 ),
    //               )),
    //               Flexible(
    //                   child: InkWell(
    //                     onTap: (){},
    //                     child: CircleAvatar(
    //                       backgroundColor: Theme.of(context).backgroundColor,
    //                       child: Icon(Feather.eye),
    //                     ),
    //                   )),
    //               Flexible(
    //                   child: InkWell(
    //                     onTap: (){},
    //                     child: CircleAvatar(
    //                       backgroundColor: Theme.of(context).backgroundColor,
    //                       child: Icon(Feather.share),
    //                     ),
    //                   )),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  //cartProvider.addToCart(productId, productData.title, productData.quantity, productData.price, productData.imageUrl)



}
