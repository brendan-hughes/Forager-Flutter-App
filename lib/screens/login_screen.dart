import 'package:flutter/material.dart';
import 'package:forageralpha/controller/login_functionality.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forageralpha/controller/processing_functions.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool _saving = false;
  int num = 1;
  var showTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showTitle = true;
//    loadAsset();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      opacity: 0.1,
      color: Colors.white,
      inAsyncCall: _saving,
      child: Scaffold(
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/images/forager2.png'),
                  fit: BoxFit.cover),
            ),
          ),
          AnimatedCrossFade(
            crossFadeState: showTitle ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 800),
            firstChild:Container(),
            secondChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text("FORAGER",
                      style: TextStyle(
                        fontFamily: 'GlacialBold',
                        color: Colors.white,
                        letterSpacing: MediaQuery.of(context).size.width * 0.05,
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? MediaQuery.of(context).size.width * 0.07
                            : MediaQuery.of(context).size.width * 0.125,
                      )),
                  Text("find food that fits",
                      style: TextStyle(
                        fontFamily: 'GlacialRegular',
                        color: Colors.white,
                        letterSpacing: MediaQuery.of(context).size.width * 0.01,
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? MediaQuery.of(context).size.width * 0.03
                            : MediaQuery.of(context).size.width * 0.05,
                      )),
                ]),
          ),
          Align(
              alignment:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? Alignment(0, 0.58)
                      : Alignment(0, 0.5),
              child: Text("Register / Sign In",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'GlacialRegular'))),
          Align(
              alignment:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? Alignment(0, 0.8)
                      : Alignment(0, 0.6),
              child: Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => loginWithGoogle(context, _saving, _auth, setState),
                      child: Image(
                        image: AssetImage('lib/images/google_icon.png'),
                        width: 35,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => loginWithFacebook(context,_saving,_auth,setState),
                      child: Image(
                        image: AssetImage('lib/images/facebook_icon.png'),
                        width: 35,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/email'),
                      child: Image(
                        image: AssetImage('lib/images/email_icon.png'),
                        width: 35,
                      ),
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
