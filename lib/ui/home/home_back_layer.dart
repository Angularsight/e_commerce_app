

import 'package:e_commerce_app/util/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackHomeLayer extends StatelessWidget {
  const BackHomeLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black87,
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(3,3))
                  ],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                ),
                image: DecorationImage(
                    image: NetworkImage('https://images.pexels.com/photos/258109/pexels-photo-258109.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                    fit: BoxFit.cover)
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10),
            child: Text("Hello, Vishnu Pranav R",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Acme',
                fontStyle: FontStyle.normal
              ),),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                child: Text("Language A/a",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Acme',
                      fontStyle: FontStyle.normal
                  ),),
              ),
              Icon(Icons.navigate_next,size: 20,color: Colors.white,)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                child: Text("Settings",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Acme',
                      fontStyle: FontStyle.normal
                  ),),
              ),
              Icon(Icons.navigate_next,size: 20,color: Colors.white,)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                child: Text("Notifications",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Acme',
                      fontStyle: FontStyle.normal
                  ),),
              ),
              Icon(Icons.navigate_next,size: 20,color: Colors.white,)
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                child: Text("Customer service",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Acme',
                      fontStyle: FontStyle.normal
                  ),),
              ),
              Icon(Icons.navigate_next,size: 20,color: Colors.white,)
            ],
          ),



        ],
      ),
    );
  }
}
