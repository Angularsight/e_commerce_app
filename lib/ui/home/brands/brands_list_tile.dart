


import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/provider/dark_theme_provider.dart';
import 'package:e_commerce_app/ui/product_details/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandsListTile extends StatelessWidget {
  const BrandsListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    //Here we fetch the
    final brandAttr = Provider.of<Product>(context);
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChangeNotifierProvider.value(
              value: brandAttr,
              child: ProductDetailsScreen(),
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 5),
        constraints: BoxConstraints(
          minHeight: 150,
          maxHeight: 180,
          minWidth: double.infinity
        ),
        child: Row(
          children: [
            Container(
              height: 160,
              width: 150
              ,
              decoration: BoxDecoration(
                  color: themeChange.darkTheme? Theme.of(context).backgroundColor : Colors.black54,
                  image: DecorationImage(
                    image: NetworkImage(brandAttr.imageUrl!),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color:themeChange.darkTheme? Theme.of(context).backgroundColor: Colors.grey,
                    offset:themeChange.darkTheme?Offset(4,3): Offset(5,7),
                    blurRadius: 10
                  )
                ]
              ),
            ),

            FittedBox(
              child: Container(
                width: 130,
                decoration: BoxDecoration(
                  color: themeChange.darkTheme? Theme.of(context).backgroundColor : Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                        color:themeChange.darkTheme? Theme.of(context).backgroundColor: Colors.grey,
                        offset:themeChange.darkTheme?Offset(0,1): Offset(5,7),
                    blurRadius: 10
                  ),],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brandAttr.title!,
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: Theme.of(context).primaryColor
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('\$ ${brandAttr.price}',
                        maxLines: 1,
                        style:TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20
                        ) ,),
                      SizedBox(height: 10,),
                      Text("${brandAttr.productCategoryName}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14
                        ),),
                      SizedBox(height:20),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

