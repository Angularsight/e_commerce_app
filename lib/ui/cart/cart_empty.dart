import 'package:e_commerce_app/provider/dark_theme_provider.dart';
import 'package:e_commerce_app/ui/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartEmpty extends StatelessWidget {
  const CartEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String emptyBagImage = 'https://elearningdom.com/wp-content/themes/mrtailor/images/empty_cart.png';
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          //double.infinity is same as MediaQuery.of(context).size.width
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(emptyBagImage),
                fit: BoxFit.cover)
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text("Nothing here!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.0,
              fontStyle: FontStyle.italic,
              color: themeChange.darkTheme? Colors.white : Colors.black
            ),),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text("Looks like you haven't \n added anything into your cart yet",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: themeChange.darkTheme? Colors.white : Colors.grey.shade600
            ),),
        ),

        SizedBox(height: 50,),

        Container(
          width:  MediaQuery.of(context).size.width * 0.8,
          child: RaisedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
              side: BorderSide(color: Colors.redAccent),
            ),
            color: Colors.redAccent,
            child: Text("Shop Now",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.white
              ) ,),
          ),
        )


      ],
    );
  }
}
