



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/ui/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  //This focusNode basically takes the focus or control from the email box to password box
  //once the user hits enter in the email block(So basically it transfers control from one box to another)
  //Used in password block
  final FocusNode _phoneNoFocusNode= FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();


  //This is for the Form widget
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  late String _phoneNo;
  String _emailAddress = '';
  String _password = '';
  //***********FIREBASE PART*****************
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //Used in the password field to save or submit the form we filled
  //Method is Future since Firebase is being used
  Future<bool> _submitForm() async{
    final isValid = _formKey.currentState!.validate();

    //For saving date in format of DD-MM-YY in firebase
    var dateTime = DateTime.now().toString();
    var dateFormat = DateTime.parse(dateTime);
    var wantedDate = '${dateFormat.day}-${dateFormat.month}-${dateFormat.year}';

    //*******If the user try to submit the form without entering the password
    // we will just unfocus the _passwordFocusNode
    FocusScope.of(context).unfocus();
    if(isValid){
      //If the entries are valid we save the fields
      _formKey.currentState!.save();

      //*********FIREBASE PART WITH ERROR HANDLING****************
      //If all fields are proper we create a firebase account using firebase auth
      try{
        await _auth.createUserWithEmailAndPassword(email: _emailAddress.toLowerCase().trim(), password: _password.trim());
        //Storing all fields in firebase
        final User user = _auth.currentUser!;
        final _uid = user.uid;
        await FirebaseFirestore.instance.collection('user').doc(_uid).set({
          'id':_uid,
          'name': _name,
          'Phone No':_phoneNo,
          'Email':_emailAddress,
          'password':_password,
          'imageUrl':'',
          'joinedAt': wantedDate,
          'createdAt': Timestamp.now()
        });
        //This statement is such that the UserStatus class handles where our page will be according to login status
        Navigator.canPop(context)? Navigator.pop(context): null;
      }catch(error){
        _showFirebaseSignUpError('Firebase Error', '$error');
        print('Firebase error occured $error');
      }finally{
      }
      return true;
    }
    return false;
  }


  //*****************GOOGLE SIGN IN**********************
  Future<void> _googleSignIn() async{
    //Signing in via google
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    //Checking if the account is not null
    if(googleAccount!=null){
      //Getting credentials ie(accessToken and idToken)
      final googleCredentials = await googleAccount.authentication;
      if(googleCredentials.accessToken!=null && googleCredentials.idToken!=null){
        try{
          final authResult = await _auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  accessToken: googleCredentials.accessToken,
                  idToken: googleCredentials.idToken));
        }catch(error){
          _showFirebaseSignUpError('Google signin error', 'Google account wrong');
        }

      }
    }
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailFocusNode.dispose();
    _phoneNoFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: WaveWidget(
              config: CustomConfig(
                gradients: [
                  [Colors.red, Color(0xEEF44336)],
                  [Colors.red[800]!, Color(0x77E57373)],
                  [Colors.orange, Color(0x66FF9800)],
                  [Colors.yellow, Color(0x55FFEB3B)]
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.1, 0.12, 0.14, 0.16],
                blur: MaskFilter.blur(BlurStyle.solid, 10),
                gradientBegin: Alignment.topCenter,
                gradientEnd: Alignment.bottomRight,
              ),
              waveAmplitude: 2,
              // heightPercentages: [0.25, 0.26, 0.28, 0.31],
              size: Size(
                double.infinity,
                double.infinity,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 170.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          key: ValueKey('name'),
                          validator: (value){
                            if(value!.isEmpty ){
                              return 'Please enter valid name';
                            }
                            return null;
                          },


                          //***********Shows next button in the keypad in place of enter button
                          textInputAction: TextInputAction.next,
                          //***************Once the user hits enter(or next) It will direct the focus to the next field ie password in our case
                          onEditingComplete: ()=>FocusScope.of(context).requestFocus(_phoneNoFocusNode),

                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              hintText: 'Name',
                              prefixIcon: Icon(Feather.user),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none
                                  )
                              )
                          ),

                          //***************WILL USE THIS IN FIREBASE*************
                          onSaved: (name){
                            _name = name!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          key: ValueKey('phoneNo'),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please enter valid phone number';
                            }
                            return null;
                          },

                          //***********Assigning the focus node for the phoneNo field---->Used in the name field
                          focusNode: _phoneNoFocusNode,
                          //***********Shows next button in the keypad in place of enter button
                          textInputAction: TextInputAction.next,
                          //***************Once the user hits enter(or next) It will direct the focus to the next field ie email in our case
                          onEditingComplete: ()=>FocusScope.of(context).requestFocus(_emailFocusNode),


                          //*********This attribute makes sure that the input is only numbers so that user cannot enter alphabets for phone no
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              hintText: 'Phone No.',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none
                                  )
                              )
                          ),

                          //***************WILL USE THIS IN FIREBASE*************
                          onSaved: (number){
                            _phoneNo = number!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          key: ValueKey('email'),
                          validator: (value){
                            if(value!.isEmpty || !value.contains('@')){
                              return 'Please enter valid email address';
                            }
                            return null;
                          },

                          //***********Assigning the focus node for the email field---->Used in the phoneNo field
                          focusNode: _emailFocusNode,
                          //***********Shows next button in the keypad in place of enter button
                          textInputAction: TextInputAction.next,
                          //***************Once the user hits enter(or next) It will direct the focus to the next field ie password in our case
                          onEditingComplete: ()=>FocusScope.of(context).requestFocus(_passwordFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none
                                  )
                              )
                          ),

                          //***************WILL USE THIS IN FIREBASE*************
                          onSaved: (email){
                            _emailAddress = email!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          obscureText: _obscureText,
                          key: ValueKey('Password'),
                          validator: (value){
                            if(value!.isEmpty || value.length<7){
                              return 'Incorrect Password';
                            }
                            return null;
                          },

                          keyboardType: TextInputType.emailAddress,

                          //***********Assigning the focus Node this is used in email field*********
                          focusNode: _passwordFocusNode,
                          //********This is shown in the keypad in place of enter button*****
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye_outlined),
                                onPressed: (){
                                  setState(() {
                                    _obscureText=!_obscureText;
                                  });
                                },
                              ),
                              fillColor: Theme.of(context).backgroundColor,
                              hintText: 'password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none
                                  )
                              )
                          ),

                          //*********Making sure we have entered fields properly
                          onEditingComplete: _submitForm,

                          //***************WILL USE THIS IN FIREBASE*************
                          onSaved: (password){
                            _password = password!;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.redAccent
                          ),
                          child: TextButton(
                            onPressed: _submitForm,
                            // onPressed: () async{
                            //   if(await _submitForm()){
                            //     print('Entered');
                            //     Navigator.push(context, MaterialPageRoute(builder:(context)=>ShopApp()));
                            //   }
                            // },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Sign up',style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18

                                ),),
                                SizedBox(width: 12,),
                                Icon(Feather.user_plus,color: Colors.amberAccent,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 100,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Sign in using other fields'),],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey
                                ),
                                child: TextButton(
                                  onPressed: _googleSignIn,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Google',style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18

                                      ),),
                                      SizedBox(width: 12,),
                                      Icon(Icons.add,color: Colors.amberAccent,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue
                                ),
                                child: TextButton(
                                  onPressed: (){},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Facebook',style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18

                                      ),),
                                      SizedBox(width: 12,),
                                      Icon(Feather.facebook,color: Colors.amberAccent,)
                                    ],
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      )

                    ],

                  ),
                )
            ),
          )
        ],
      ),
    );
  }
  Future<void> _showFirebaseSignUpError(String title,String subtitle) async {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.info_outline,color: Colors.red,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(subtitle),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(

                  onPressed: ()=>Navigator.pop(context),
                  child: Text("Ok",style: TextStyle(
                      color: Colors.grey
                  ),)),
            ],
          )
        ],
      );
    });
  }
}
