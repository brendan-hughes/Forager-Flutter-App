import 'package:flutter/material.dart';
import 'package:forageralpha/controller/formatting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:forageralpha/controller/login_functionality.dart';

String email;
String password;
Color errorTextColor = Colors.transparent;
bool _saving = false;
bool fail = false;

class EmailLoginScreen extends StatefulWidget {
  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        opacity: 0.1,
        color: Colors.white,
        inAsyncCall: _saving,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/images/forager2.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 50,
            left: -10,
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  errorTextColor = Colors.transparent;
                });
                Navigator.pop(context);
                }
              ,
              elevation: 0,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                  width: 110,
                  child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.arrow_back, color: Colors.white),
                    Text(" Go Back", style: descriptionTextSmall)
                  ])),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 350,
              height: 300,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(33, 33, 33, 0.6),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text("Register / Sign In",
                            style: emailHeaderText),
                        Container(
                          width: 275,
                          child: TextField(
                            cursorColor: Color.fromRGBO(255, 255, 255, 0.5),
                            style: fieldText,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: "Enter your email address.",
                              hintStyle: hintText,
                              labelText: "Email Address",
                              alignLabelWithHint: true,
                              labelStyle: fieldText,
                            ),

                            textAlign: TextAlign.left,
                            onChanged: (value) => email = value,
                            keyboardType: TextInputType.emailAddress,

                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          width: 275,
                          child: TextField(
                            cursorColor: Color.fromRGBO(255, 255, 255, 0.5),
                            style: fieldText,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: "Enter your password.",
                              hintStyle: hintText,
                              labelText: "Password",
                              alignLabelWithHint: true,
                              labelStyle: fieldText,
                            ),
                            textAlign: TextAlign.left,
                            onChanged: (value) => password = value,
                            obscureText: true,
                          ),
                        ),
                        SizedBox(height:10),
                        GestureDetector(child: Text("Forgot Password?",style: hintText),onTap: () {Navigator.pushNamed(context,'/forgot');}),
                        fail ? Text("Invalid login, please try again or reset password.", textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'GlacialBold',
                            fontSize: 12.0,
                            color: Colors.red,
                          ),
                        ) : Container(),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              _saving = true;
                            });
                            emailLogIn(context, _auth, email, password).then((result) {
                              if (result == true) {
                                setState(() {
                                  _saving = false;
                                  fail = false;
                                });
                                directUserFlow(context);
                              }
                              else {
                                setState(() {
                                  _saving = false;
                                  fail = true;
                                });
                              }
                            });
                          },
                          elevation: 40.0,
                          color: Color.fromRGBO(33, 33, 33, 0.5),
                          child: Text("SUBMIT", style: descriptionTextSmallBold),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.white)
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
