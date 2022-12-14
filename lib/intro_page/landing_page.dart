


import 'package:e_commerce_app/login_page/login.dart';
import 'package:e_commerce_app/login_page/signup_page.dart';
import 'package:e_commerce_app/ui/bottom_navigation_bar.dart';
import 'package:e_commerce_app/util/needed_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  List images = [
    'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1138257321%2F960x0.jpg%3Ffit%3Dscale',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc80lzf7RJ1ZpOXAbbdF9DQhM_JQeG-M6dkAcQn2SB5saW-3MDCU1SMwBILg10aioWsn0&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFj0mpSEH89VXkK475SO98NXxlefVA5ir_gmglLcGXRSXJ54TsdIIDy3uLBE5s6fv0sOg&usqp=CAU',
    'https://acquire.io/wp-content/uploads/2017/04/8-Steps-to-Optimize-Your-Ecommerce-Shopping-Cart-Checkout-in-2020.png'
  ];

  late PageController _pageController;
  int currentIndex = 0;



  @override
  void initState() {
    _pageController = PageController();
    super.initState();

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffff66),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: PageClass.onboardingList.length,
                onPageChanged: (int index){
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_,i){
              return Column(
                children: [
                  Image.asset(PageClass.onboardingList[i]['image']!,fit: BoxFit.cover,height: 300,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(PageClass.onboardingList[i]['title']!,textAlign: TextAlign.center,style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      fontFamily: 'Acme'
                    ),),
                  ),
                  Expanded(
                    child: Text(PageClass.onboardingList[i]['description']!,
                      textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                      ),
                    maxLines: 5,),
                  ),
                  SizedBox(height: 15,)

                ],
              );
            }),
          ),

          Container(
            padding: EdgeInsets.only(bottom: 120),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(PageClass.onboardingList.length, (index){
                return createdDot(context,index);
              })
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    if(currentIndex==PageClass.onboardingList.length-1){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    }
                  });
                },
                child:Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(
                        border:currentIndex==2? Border.all(color: Colors.redAccent,width: 2):null,
                        borderRadius: BorderRadius.circular(10),
                        color:currentIndex==2? Colors.amberAccent.shade400:Colors.transparent,
                      ),
                      child:currentIndex==2?Center(child: Text('Login',style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                      ),)):null

                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    if(currentIndex==PageClass.onboardingList.length-1){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                    }
                  });
                },
                child:Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(
                        border:currentIndex==2? Border.all(color: Colors.redAccent,width: 2):null,
                        borderRadius: BorderRadius.circular(10),
                        color:currentIndex==2? Colors.amberAccent.shade400:Colors.transparent,
                      ),
                      child:currentIndex==2?Center(child: Text('Register',style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                      ),)):null

                  ),
                ),
              ),
            ],
          )

        ],
      ),
    );

  }

  Container createdDot(BuildContext context, int index) {
    return Container(
          margin: EdgeInsets.only(right: 8),
          width: currentIndex==index?20:10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade400,

            borderRadius: BorderRadius.circular(20)
          ),
        );
  }

  Widget dotWithButton(BuildContext context, int index){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        createdDot(context, index),

        InkWell(
          onTap: (){
            setState(() {
              if(currentIndex==PageClass.onboardingList.length-1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopApp()));
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width*0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent,width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amberAccent.shade400,
                ),
                child: Center(child: Text('Continue',style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                ),))

            ),
          ),
        )
      ],
    );
  }
}
