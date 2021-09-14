



import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/models/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class ProductNetwork{

  Future<ProductModel> fetchingProductData(String searchedProduct) async{
    var baseUrl ='https://amazon23.p.rapidapi.com/product-search';
    var extendedUrl = '?keyword=$searchedProduct&country=IN';
    var wantedUrl = baseUrl+extendedUrl;

    var response = await get(
        Uri.parse('https://amazon23.p.rapidapi.com/product-search?query=$searchedProduct&country=IN'),
        headers:{
          'x-rapidapi-host': 'amazon23.p.rapidapi.com',
          'x-rapidapi-key': '033386e308msh79b6917e2bbc3acp18f78ajsn7b399e4613bd'
        });

    if(response.statusCode==200){
      print('Response is not Empty :${response.body.isNotEmpty}');
      return ProductModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception();
    }

  }

  Future<List<Result>?> get products{
    Future<ProductModel> products = ProductNetwork().fetchingProductData('apple');
    return products.then((value) => value.result);

  }

}

