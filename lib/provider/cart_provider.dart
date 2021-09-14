

import 'package:e_commerce_app/models/cart_attr.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier{

  //Creating a map which will hold the cart
  Map<String,CartAttr> _cartItems = {};

  Map<String,CartAttr> get getCartItems{
    return {..._cartItems};

  }

  double get getTotalAmount{
    double total = 0.0;
    _cartItems.forEach((key, value) {
      total+= (value.price! * value.quantity!);
    });
    return total;

  }

  void addToCart(String? productId,String? title,int? quantity,double? price, String? imageUrl){
    //Else add it into the list of _cartItems
    _cartItems.putIfAbsent(productId!, () => CartAttr(
        id: productId,
        title: title,
        quantity: 1,
        price: price,
        imageUrl: imageUrl
    ));
    print('Entered add to cart block with product ID : $productId');
  }

  void updateCart(String productId){
    _cartItems.update(productId, (value) => CartAttr(
      id: value.id,
      title: value.title,
      price: value.price,
      quantity: value.quantity! + 1,
      imageUrl: value.imageUrl
    ));
    print('Entered update cart block with product ID : $productId');
    notifyListeners();
  }

  void reduceItemByOne(String? productId,String? title,int? quantity,double? price, String? imageUrl){
    if(_cartItems.containsKey(productId)){
      //If you add an already existing item to cart everything thing remains the same except quantity(goes up by 1)
      _cartItems.update(productId!, (existingProduct) => CartAttr(
          id: existingProduct.id,
          title: existingProduct.title,
          quantity: existingProduct.quantity! - 1,
          price: existingProduct.price,
          imageUrl: existingProduct.imageUrl
      ));
    }
    print(_cartItems.length);
    notifyListeners();
  }

  void removeItemFromCart(String? productId){
    _cartItems.remove(productId);
    print(_cartItems.length);
    notifyListeners();
  }

  void clearCart(){
    _cartItems.clear();
    print(_cartItems.length);
    notifyListeners();
  }

  double get getCheckoutAmount{
    double checkoutAmount=0.0;
    _cartItems.forEach((key, value) {
      checkoutAmount+= ((value.price! - (value.price! * 0.1)) * value.quantity!);
    });
    return checkoutAmount;
  }

}