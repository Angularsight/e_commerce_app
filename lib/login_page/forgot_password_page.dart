


import 'package:e_commerce_app/login_page/login.dart';
import 'package:e_commerce_app/util/icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
class ForgotPassword extends StatefulWidget {

  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  String _resetEmail ='';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> _submitForm() async{
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
      try{
        await _auth.sendPasswordResetEmail(email: _resetEmail.toLowerCase().trim());
        return true;
      }catch(error){
        print('Error occured in password reset $error');
        return false;
      }
    }
    return false;
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
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text("Forgot Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 35,
                          fontFamily: 'Acme'
                      ),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      key: ValueKey('resetEmail'),
                      validator: (value) {
                        if (value!.isEmpty|| !value.contains('@')) {
                          return 'Reset email id needed';
                        }
                        return null;
                      },

                      //***********Shows next button in the keypad in place of enter button
                      textInputAction: TextInputAction.done,
                      //***************Once the user hits enter(or next) It will direct the focus to the next field ie password in our case

                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).backgroundColor,
                          prefixIcon: Icon(IconClass.gmail),
                          hintText: 'Email address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0, style: BorderStyle.none))),

                      //***************WILL USE THIS IN FIREBASE*************
                      onSaved: (email) {
                        _resetEmail = email!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent
                      ),
                      child: InkWell(
                        onTap: ()async{
                          bool enter  = await _submitForm();
                          setState(() {
                            if(enter){
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Rest password',style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18

                            ),),
                            SizedBox(width: 12,),
                            Icon(Icons.password,color: Colors.amberAccent,)
                          ],
                        ),
                      ),
                    ),
                  ),

                ],

              )
              ),
            ),
          )
        ],
      ),
    );
  }
}
