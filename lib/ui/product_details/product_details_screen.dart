import 'package:badges/badges.dart';
import 'package:e_commerce_app/models/ProductModel.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/models/review_model.dart';
import 'package:e_commerce_app/models/review_model_two.dart';
import 'package:e_commerce_app/network/product_api.dart';
import 'package:e_commerce_app/network/review_api.dart';
import 'package:e_commerce_app/network/review_api_two.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/products.dart';
import 'package:e_commerce_app/ui/home/discount_products/discount_products.dart';
import 'package:e_commerce_app/ui/home/home_classes.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  // late final Future<ProductModel> productDetails;
  // late final Future<ReviewModelTwo> reviews;

  ProductDetailsScreen({Key? key})
      : super(key: key);
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  TextStyle text1 =
      TextStyle(color: Colors.grey.shade700, fontSize: 18, fontFamily: 'Acme');

  TextStyle text2 =
      TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Acme');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //*******************REQUIRED STUFF IS RIGHT HERE******************
    final aboutProduct = Provider.of<Product>(context);

    return Scaffold(
      body: buildStack(context,aboutProduct),
      bottomSheet: productDetailsBottomSheet(context,aboutProduct),
    );
  }

  Stack buildStack(BuildContext context, Product aboutProduct,) {
    return Stack(
      children: [
        imagePart(context,aboutProduct.imageUrl ),
        Padding(
            padding: EdgeInsets.only(top: 200),
            child: productDetails(context, aboutProduct)),
      ],
    );
  }

  Widget productDetailsBottomSheet(BuildContext context, Product aboutProduct) {

    //****************We will be using the addToCart function inside cartProvider to add products to cart
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0)
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Colors.yellowAccent.shade200,
                    Colors.grey.shade300
                  ])),
              child: Text(
                'Buy Now',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              //*****************ADDING PRODUCT TO CART USING CART PROVIDER********************
              setState(() {
                cartProvider.getCartItems.containsKey(aboutProduct.id)?null:
                cartProvider.addToCart(
                    aboutProduct.id, aboutProduct.title,aboutProduct.quantity,
                    aboutProduct.price, aboutProduct.imageUrl);
              });

            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Colors.yellowAccent.shade700,
                    Colors.grey.shade300
                  ])),
              child: Text(
                cartProvider.getCartItems.containsKey(aboutProduct.id)?'Added to cart ':'Add to cart',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container imagePart(BuildContext context, String? productImage) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(productImage.toString()), fit: BoxFit.cover)),
    );
  }

  Widget productDetails(BuildContext context, Product aboutProduct, ) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.symmetric(vertical: 50),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              productDetailRow('ProductName',aboutProduct.title),
              productDetailRow('MRP ',aboutProduct.price.toString()),
              productDetailRow('Current Price',(aboutProduct.price!.toDouble() - 5.0).toString()),
              productDetailRow('Description', aboutProduct.description),
              productDetailRow('Quantity', aboutProduct.quantity.toString()),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 8.0),
        //   child: commentSection(context),
        // ),
        suggestedSection()
      ],
    ));
  }

  Row productDetailRow(String text,String? productName) {
    return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:Text(
                      "$text ",
                      style:text1
                      )
                  )
                ),
                Expanded(
                  flex: 2,
                  child: text=='MRP '|| text=='Current Price'?Text(
                    "\$ $productName ",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: text1,
                  ):Text(
                    "$productName ",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: text1,
                  )
                ),
              ],
            );
  }

  Widget suggestedSection() {
    final discountProduct = Provider.of<Products>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Suggestions",
              style: text2,
            ),
          ),
          Container(
            height: 320,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return ChangeNotifierProvider.value(
                      value: discountProduct.discountProducts[index],
                      child: DiscountProducts());
                },
                separatorBuilder: (context, index) => SizedBox(
                      width: 20,
                    ),
                itemCount: discountProduct.discountProducts.length),
          )
        ],
      ),
    );
  }


}
