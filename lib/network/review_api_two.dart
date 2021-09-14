

import 'dart:convert';

import 'package:e_commerce_app/models/review_model_two.dart';
import 'package:http/http.dart';

class ReviewNetworkTwo{

  Future<ReviewModelTwo> fetchReviews(String? asin)async{
    var wantedUrl = 'https://amazon-product4.p.rapidapi.com/product/reviews?asin=$asin';

    var response = await get(
        Uri.parse(wantedUrl),
        headers:{
          'x-rapidapi-host': 'amazon-product4.p.rapidapi.com',
          'x-rapidapi-key': '033386e308msh79b6917e2bbc3acp18f78ajsn7b399e4613bd'
        });


    if(response.statusCode==200){
      print('Review Resonse is not Empty :${response.body.isNotEmpty}');
      print(jsonDecode(response.body));
      return ReviewModelTwo.fromJson(jsonDecode(response.body));
    }else{
      throw Exception();
    }

  }

}