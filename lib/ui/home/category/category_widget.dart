import 'package:e_commerce_app/ui/feed/feed_screen.dart';
import 'package:e_commerce_app/ui/home/category/category_feeds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home_classes.dart';


class CategoryWidget extends StatelessWidget {

  final int index;
  CategoryWidget({Key? key,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return categoryItem(context, HomeClass.categories[index]);
  }
  Widget categoryItem(BuildContext context ,var details ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                CategoryFeeds(category: details['productName'])));
            // print('${details['productName']}');
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 130,

            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(image:AssetImage('${details['productImagePath']}',),
                  fit: BoxFit.cover),
                borderRadius: BorderRadius.only(topRight:Radius.circular(10),
                    topLeft: Radius.circular(10)),

            ),
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
              border: Border.all(color:Colors.grey,width: 2.5),
          ),
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 7),
            child: Text("${details['productName']}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontStyle: FontStyle.italic
              ),),
          ),
        )
      ],
    );


  }
}





