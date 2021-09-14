

import 'package:badges/badges.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/products.dart';
import 'package:e_commerce_app/ui/feed/feed_item.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  final FocusNode _node = FocusNode();
  late ScrollController _scrollController;
  List<Product> searchResultList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Initializing the search bar so that it listens to every input and change made in it
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
      });
    });

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)
                  )
                ),
                backgroundColor: Colors.deepPurple.shade600,
                pinned: false,
                shadowColor: Colors.grey,
                toolbarHeight: kToolbarHeight * 3,
                leading: Padding(
                  padding: const EdgeInsets.only(bottom: 110.0),
                  child: Icon(Icons.toc_outlined,size: 35,),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: (){

                      },
                      child: Stack(
                        children: [
                          Icon(IconClass.cart),
                          cartProvider.getCartItems.isNotEmpty? Badge(
                            position: BadgePosition.topStart(start: -5),
                          ):Badge(
                            badgeColor: Colors.transparent.withOpacity(0),
                            position: BadgePosition.topStart(start: -5),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GridView.count(
                      crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    childAspectRatio: 240/420,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15,
                    children: List.generate(
                        searchResultList.length, (index){
                          return ChangeNotifierProvider.value(
                              value: searchResultList[index],
                              child: FeedItem(),
                          );
                    }),
                  ),
                ),
              )
            ],
          ),
          _buildSearchBar(),
        ],
      )
    );
  }

  Widget _buildSearchBar() {
    final productsData = Provider.of<Products>(context);
    //This is the list that will be displayed after searching for a particular item

    //*****************************For moving the search bar along with the toolbar(ANIMATION)***********************
    final double defaultTopMargin = kToolbarHeight*3.5;

    double top = defaultTopMargin;

    if(_scrollController.hasClients && top>30){
      setState(() {
        print(top);
      });
      double offset = _scrollController.offset;
      top -=offset;
      if(offset > defaultTopMargin - offset){
        top = 20;
      }
    }

    return Positioned(
      top: top,
      right: 40,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(18)
        ),
        child: TextField(
          controller: _searchController,
          minLines: 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none
              )
            ),
            prefixIcon: Icon(Icons.search,color: Colors.grey.withOpacity(0.5),),
            hintText: 'Clothes,shoes,watches,laptops...',
            hintStyle: TextStyle(
              color: Colors.black54
            ),
            filled: true,
            suffixIcon: IconButton(
              icon: Icon(Icons.clear,
                color: _searchController.text.isEmpty? Colors.grey:Colors.redAccent,),
              onPressed: (){
                _searchController.clear();
                _node.unfocus();
              },
            )
          ),
          onChanged: (text){
            _searchController.text.toLowerCase();
            setState(() {
              searchResultList = productsData.searchedProducts(text);
            });
          },
        ),
      ),
    );
  }
}