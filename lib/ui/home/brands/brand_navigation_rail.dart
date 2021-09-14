


import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/provider/products.dart';
import 'package:e_commerce_app/ui/home/brands/brands_list_tile.dart';
import 'package:e_commerce_app/util/needed_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandNavigationRail extends StatefulWidget {
  final int index;
  const BrandNavigationRail({Key? key,required this.index}) : super(key: key);

  //This is the route name that will be used when using Navigator in the swiper widget
  static const routeName = '/brand_navigation_rail';
  @override
  _BrandNavigationRailState createState() => _BrandNavigationRailState(index);
}

class _BrandNavigationRailState extends State<BrandNavigationRail> {
  final int _selectedIndex;
  _BrandNavigationRailState(this._selectedIndex);

  //This is all needed for transferring data from home screen to this screen
  int _selectedNavigationItem = 0;
  final padding = 0.0;
  // late String routeArgs;
  late String brand;


  //*******Self created**************
  @override
  void didChangeDependencies(){

    //This part is to set the brand in the navigation rail
    if(_selectedIndex ==0){
      setState(() {
        _selectedNavigationItem = 0;
        brand = 'Apple';
      });
    }else if (_selectedIndex == 1){
      setState(() {
        _selectedNavigationItem = 1;
        brand = 'Dell';
      });
    }else if (_selectedIndex == 2){
      setState(() {
        _selectedNavigationItem = 2;
        brand = 'H&M';
      });
    }else if (_selectedIndex == 3){
      setState(() {
        _selectedNavigationItem = 3;
        brand = 'Louis Vuitton';
      });
    }else if (_selectedIndex == 4){
      setState(() {
        _selectedNavigationItem = 4;
        brand = 'Nike';
      });
    }else if (_selectedIndex == 5){
      setState(() {
        _selectedNavigationItem = 5;
        brand = 'Samsung';
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LayoutBuilder(builder: (context,constraint){
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    
                      //Width of the navigation rail
                      labelType: NavigationRailLabelType.all,
                      minWidth: 56.0,
                      elevation: 5,
                      destinations: [
                        buildRotatedTextRailDestination('Apple',padding),
                        buildRotatedTextRailDestination('Dell', padding),
                        buildRotatedTextRailDestination('H&M',padding),
                        buildRotatedTextRailDestination('Louis Vuitton', padding),
                        buildRotatedTextRailDestination('Nike',padding),
                        buildRotatedTextRailDestination('Samsung', padding),

                      ],
                      selectedIndex: _selectedNavigationItem,
                      onDestinationSelected: (int index){
                        _selectedNavigationItem = index;
                        if(_selectedNavigationItem ==0){
                          setState(() {
                            brand = 'Apple';
                          });
                        }else if (_selectedNavigationItem == 1){
                          setState(() {
                            brand = 'Dell';
                          });
                        }else if (_selectedNavigationItem == 2){
                          setState(() {
                            brand = 'H&M';
                          });
                        }else if (_selectedNavigationItem == 3){
                          setState(() {
                            brand = 'Louis Vuitton';
                          });
                        }else if (_selectedNavigationItem == 4){
                          setState(() {
                            brand = 'Nike';
                          });
                        }else if (_selectedNavigationItem == 5){
                          setState(() {
                            brand = 'Samsung';
                          });
                        }
                      },

                    leading: Column(
                      children: [
                        SizedBox(height: 20,),
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage('https://i.stack.imgur.com/w2kfR.png'),
                        ),
                        SizedBox(height: 80,),

                      ],
                    ),

                    selectedLabelTextStyle: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 20,
                      letterSpacing: 1,
                      decorationThickness: 2,
                      decoration: TextDecoration.underline
                    ),

                    unselectedLabelTextStyle: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0.8
                    ),

                  ),
                ),

              ),
            );
          }),

          ContentSpace(context,brand)


        ],
      ),
    );
  }

  NavigationRailDestination buildRotatedTextRailDestination(String text, double padding) {
    return NavigationRailDestination(
        icon: SizedBox.shrink(),
        label: Padding(
          padding: EdgeInsets.symmetric(vertical: padding),
          child: RotatedBox(
              quarterTurns: -1,
              child: Text(text),
          ),
        )
    );

  }
}


class ContentSpace extends StatelessWidget {
  final String brandName;
  ContentSpace(BuildContext context,this.brandName);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    List<Product> brandData = productsData.products.where((element) =>
        element.brand!.toLowerCase().contains(brandName.toLowerCase())).toList();
    print('$brandName ${productsData.products[0].brand!.toLowerCase()}');
    print(brandData);
    //Collecting all product data among products which have brand equal to brandName


    return Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 0, 0),
          child: MediaQuery.removePadding(
              context: context,
              child: ListView.builder(
                  itemCount: brandData.length,
                  itemBuilder: (BuildContext context,int index){
                    return ChangeNotifierProvider.value(
                      //passing the brand which was clicked on the navigation rail to the feed
                        value: brandData[index],
                        child: BrandsListTile());
                  })
          ),
        )
    );
  }
}

