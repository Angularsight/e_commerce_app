



import 'dart:convert';

import 'package:e_commerce_app/models/review_model.dart';
import 'package:http/http.dart';

class ReviewNetwork{

  Future<ReviewModel> fetchReviews(String? asin)async{
    var wantedUrl = 'https://amazon23.p.rapidapi.com/reviews?asin=$asin&sort_by=recent&country=US';

    var response = await get(
        Uri.parse(wantedUrl),
        headers:{
          'x-rapidapi-host': 'amazon23.p.rapidapi.com',
          'x-rapidapi-key': '033386e308msh79b6917e2bbc3acp18f78ajsn7b399e4613bd'
        });


    if(response.statusCode==200){
      print('Review Resonse is not Empty :${response.body.isNotEmpty}');
      print(jsonDecode(response.body));
      return ReviewModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception();
    }

  }

}