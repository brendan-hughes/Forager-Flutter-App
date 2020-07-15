import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forageralpha/controller/formatting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:forageralpha/controller/favorite_functionality.dart';
import 'package:forageralpha/controller/forage_functionality.dart';

bool isLoading = true;
enum ringColor { red, blue, green }
var _firestore = Firestore.instance;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleLoggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userID;
    getUserID().then((result) {
      setState(() {
        userID = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/images/forager3.png'), fit: BoxFit.cover),
        ),
      ),
      SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                            child: Text(
                          "F O R A G E R",
                          style: headerText,
                        )))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromRGBO(33, 33, 33, 0.6),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("FIND FOOD", style: headerText),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Text(
                                "Quickly find recipes that fit specific caloric, nutritional, and dietary requirements.",
                                style: descriptionText,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            RaisedButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/findafood'),
                              elevation: 40.0,
                              splashColor: Color.fromRGBO(75, 77, 94,1),
                              color: Color.fromRGBO(33, 33, 33, 0.5),
                              child: Text("CLICK TO FORAGE",
                                  style: descriptionTextSmallBold),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white)),
                            )
                          ],
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromRGBO(33, 33, 33, 0.6),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("FEATURED RECIPE", style: headerText),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: _firestore
                                      .collection('featuredRecipes')
                                      .where('Date',
                                      isEqualTo: "Today")
                                      .limit(1)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final queryResults =
                                          snapshot.data.documents;
                                      List<Widget> resultWidgets = [];
                                      for (var query in queryResults) {
                                        //Going into queryResults
                                        final recipes = query
                                            .data["Results"];
                                        var ringColors = ringColor.blue;
                                        recipes.forEach((
                                            recipe,
                                            details,
                                            ) {
                                          var ringColorCurrent;

                                          switch (ringColors) {
                                            case ringColor.blue:
                                              {
                                                ringColorCurrent =
                                                    Color.fromRGBO(
                                                        149, 188, 220, 1);
                                                ringColors =
                                                    ringColor.green;
                                              }
                                              break;

                                            case ringColor.green:
                                              {
                                                ringColorCurrent =
                                                    Color.fromRGBO(
                                                        147, 220, 172, 1);
                                                ringColors =
                                                    ringColor.red;
                                              }
                                              break;

                                            case ringColor.red:
                                              {
                                                ringColorCurrent =
                                                    Color.fromRGBO(
                                                        220, 150, 150, 1);
                                                ringColors =
                                                    ringColor.blue;
                                              }
                                              break;
                                          }


                                          var carbohydrates =
                                          36.5;
                                          var protein =
                                          29.7;
                                          var fat =
                                        21.3;
                                          var calories = ((protein + carbohydrates)*4) + (fat*9);

                                          var name = "Worlds Best Lasagna";
                                          var image = "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F3359675.jpg";

                                          var recipeWidget = Padding(
                                              padding:
                                              EdgeInsets.all(12.0),
                                              child: Container(
                                                color: Colors.transparent,
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                    padding:
                                                    EdgeInsets.only(
                                                        top: 5,
                                                        bottom: 5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Color.fromRGBO(255,255,255,0.4),
                                                          width:2,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            20)),
                                                        color: Color
                                                            .fromRGBO(
                                                            255,
                                                            255,
                                                            255,
                                                            0.3)),
                                                    child: Column(
                                                        children: [
                                                          Row(
                                                              children: [
                                                                Container(
                                                                    width: MediaQuery.of(context).size.width -
                                                                        80,
                                                                    child:
                                                                    Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: [
                                                                          Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left:10.0,top:10),
                                                                                  child: Container(
                                                                                    width:200,
                                                                                    child: Text(
                                                                                      name.toString(),
                                                                                      style: secondaryHeaderTextExtraLarge,
                                                                                      textAlign: TextAlign.left,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(height:15),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(bottom:8.0),
                                                                                  child: Row(
                                                                                      children: [
                                                                                        SizedBox(
                                                                                            width:
                                                                                            10),
                                                                                        if (calories !=
                                                                                            null)
                                                                                          Container(
                                                                                              width:
                                                                                              36,
                                                                                              child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text("Calories", style: descriptionTextExtraSmall),
                                                                                                    Text(calories.toString(), style: secondaryHeaderText)
                                                                                                  ])),
                                                                                        SizedBox(
                                                                                            width:
                                                                                            10),
                                                                                        if (carbohydrates !=
                                                                                            null)
                                                                                          Container(
                                                                                              width:
                                                                                              40,
                                                                                              child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text("Carbs", style: descriptionTextExtraSmall),
                                                                                                    Text(carbohydrates.toString(), style: secondaryHeaderText)
                                                                                                  ])),
                                                                                        SizedBox(
                                                                                            width:
                                                                                            10),
                                                                                        if (protein !=
                                                                                            null)
                                                                                          Container(
                                                                                              width:
                                                                                              40,
                                                                                              child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text("Protein", style: descriptionTextExtraSmall),
                                                                                                    Text(protein.toString(), style: secondaryHeaderText)
                                                                                                  ])),
                                                                                        SizedBox(
                                                                                            width:
                                                                                            10),
                                                                                        if (fat !=
                                                                                            null)
                                                                                          Container(
                                                                                              width:
                                                                                              40,
                                                                                              child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text("Fat", style: descriptionTextExtraSmall),
                                                                                                    Text(fat.toString(), style: secondaryHeaderText)
                                                                                                  ])),
                                                                                      ]),
                                                                                ),
                                                                              ]
                                                                          ),
                                                                          Column(children:[
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: ClipOval(
                                                                                child: Container(
                                                                                    width: 69,
                                                                                    height: 69,
                                                                                    decoration: BoxDecoration(color: ringColorCurrent, shape: BoxShape.circle),
                                                                                    padding: EdgeInsets.all(3),
                                                                                    child: CircleAvatar(
                                                                                      backgroundImage: NetworkImage(image),
                                                                                      foregroundColor: Colors.white,
                                                                                    )),
                                                                              ),
                                                                            ),

                                                                          ])
                                                                        ],
                                                                      ),
                                                                    ]))
                                                              ]),
                                                        ])),
                                              ));
                                          if (resultWidgets.length < 1) {
                                            resultWidgets.add(recipeWidget);
                                          }

                                        });
//
                                      }
                                      isLoading = true;
                                      return Column(
                                          children: resultWidgets);
                                    } else {
                                      return isLoading
                                          ? Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
                                          ))
                                          : null;
                                    }
                                  }),
                            ),
                            RaisedButton(
                              onPressed: () =>
                                  openDetails(false,true,"R-16794",context),
                              elevation: 40.0,
                              color: Color.fromRGBO(33, 33, 33, 0.5),
                              splashColor: Color.fromRGBO(58, 92, 78,1),
                              child: Text("VIEW RECIPE",
                                  style: descriptionTextSmallBold),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white)),
                            )
                          ],
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RaisedButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/profile'),
                                elevation: 40.0,
                                splashColor: Color.fromRGBO(84, 131, 138,1),
                                color: Color.fromRGBO(33, 33, 33, 0.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.person, color: Colors.white),
                                    Text(
                                      " PROFILE",
                                      style: descriptionTextExtraSmallBold,
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.white)),
                              ),
                              RaisedButton(
                                onPressed: () {Navigator.pushNamed(context, '/favorites');},
                                elevation: 40.0,
                                color: Color.fromRGBO(33, 33, 33, 0.5),
                                splashColor:Color.fromRGBO(138, 85, 85, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.white)),
                                child: Container(
                                  width: 80,
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.favorite,
                                            color: Colors.white, size: 20.0),
                                        Text(" FAVORITES",
                                            style: descriptionTextExtraSmallBold),
                                      ]),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  //To do: Add logic for specific log out according to sign in type.
                                  _auth.signOut();
                                  _googleSignIn.signOut();
                                  Navigator.popAndPushNamed(context, '/login');
                                },
                                elevation: 40.0,
                                color: Color.fromRGBO(33, 33, 33, 0.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.exit_to_app, color: Colors.white),
                                    Text(
                                      "SIGN OUT",
                                      style: descriptionTextExtraSmallBold,
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.white)),
                              ),
                            ]))),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/feedback');
                  },
                  color: Colors.transparent,
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.add_comment,
                              color: Colors.white, size: 20.0),
                          Text(" QUESTIONS OR FEEDBACK?",
                              style: descriptionTextExtraSmallBold),
                        ]),
                  ),
                ),
                SizedBox(width:20),
               FlatButton(
                  onPressed: () {
                    _launchURL();
                  },
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(image:AssetImage('lib/images/instagram_social.png'),width:20),
                      Text(
                        " FOLLOW US",
                        style: descriptionTextExtraSmallBold,
                      ),
                    ],
                  ),
                ),
              ]),
            ]),
      ),
    ]));
  }
}

_launchURL() async {
  const url = 'https://www.instagram.com/forager.app/?hl=en';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}