



import 'package:e_commerce_app/login_page/forgot_password_page.dart';
import 'package:e_commerce_app/ui/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //This is for the Form widget
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocusNode = FocusNode();
  String _emailAddress = '';
  String _password = '';

  //************FIREBASE PART***************
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> _submitForm() async{
    final isValid = _formKey.currentState!.validate();
    _passwordFocusNode.unfocus();
    _formKey.currentState!.save();
    if(isValid){
      try{
        print('Entered sign in block');
        await _auth.signInWithEmailAndPassword(
            email: _emailAddress.toLowerCase().trim(), 
            password: _password.trim()); //then---> This part is for User login status(check login_logout directory)
      }catch(error) {
        _showFirebaseSignUpError('Firebase Error', '$error');
        print('Firebase Error Occured $error');
        return false;
      }
      return true;
    }
    return false;
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
                heightPercentages: [0.25, 0.27, 0.29, 0.32],
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
                          key: ValueKey('email'),
                          validator: (value){
                            if(value!.isEmpty || !value.contains('@')){
                              return 'Please enter valid email address';
                            }
                            return null;
                          },

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
                          //********FocusNodePart(Refer signup Page for more details)**************
                          focusNode: _passwordFocusNode,
                          onEditingComplete: _submitForm,

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
                            onPressed: ()async{
                              if(await _submitForm()){
                                print('Entered');
                                Navigator.push(context, MaterialPageRoute(builder:(context)=>ShopApp()));
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Login',style: TextStyle(
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
                      TextButton(
                          onPressed:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            =>ForgotPassword()));
                          },
                          child: Text("Forgot password?",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue.shade700
                            ),
                          )
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
