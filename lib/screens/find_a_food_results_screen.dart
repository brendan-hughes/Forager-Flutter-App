import 'package:flutter/material.dart';
import 'package:forageralpha/controller/formatting.dart';
import 'package:forageralpha/controller/find_food_functionality.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forageralpha/controller/forage_functionality.dart';
import 'package:forageralpha/controller/ad_function.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:intl/intl.dart';

Color individualFoodsBtn = Color.fromRGBO(255, 255, 255, 0.4);
Color recipesBtn = Colors.transparent;
final _auth = FirebaseAuth.instance;

final _firestore = Firestore.instance;
var queryID;
var userID;
var favorites;
var appID;
var isLoading = true;
enum ringColor { red, blue, green }

BannerAd _bannerAd;

class FindAFoodResultScreen extends StatefulWidget {
  @override
  _FindAFoodResultScreenState createState() => _FindAFoodResultScreenState();
}

class _FindAFoodResultScreenState extends State<FindAFoodResultScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkQueryID().then((result) {
      setState(() {
        queryID = result;
      });
    });
    var ams = AdMobService();
    appID = ams.getAdMobAppId();
    FirebaseAdMob.instance.initialize(appId: appID);
    _bannerAd = createBannerAd()
      ..load().then((loaded) {
        if (loaded && this.mounted) {
          _bannerAd..show();
        }
      });
    getUserData().then((result) {
      setState(() {
        userID = result['userID'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/images/forager2.png'), fit: BoxFit.cover),
        ),
      ),
      Positioned(
        top: 50,
        left: -10,
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
              width: 60,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.arrow_back, color: Colors.white),
                Text(" Back", style: descriptionTextSmall)
              ])),
        ),
      ),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(children: [
              SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * 0.80,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromRGBO(33, 33, 33, 0.6),
                          ),
                          child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView(
                                children: [
                                  SizedBox(height: 12),
                                  Column(children: <Widget>[
                                    Text("FIND FOOD", style: headerText),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "These foods matched your conditions",
                                              style: descriptionText,
                                              textAlign: TextAlign.left),
                                          Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          )
                                        ]),
                                    StreamBuilder<QuerySnapshot>(
                                        stream: _firestore
                                            .collection('findFoodQueryResults')
                                            .where('QueryID',
                                                isEqualTo: queryID)
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
                                                if (recipe == "R-24305") {
                                                }

                                                var numberOfFavorites = details["Favorites"];

                                                if (numberOfFavorites >= 1000) {
                                                  final formatter = new NumberFormat.compact();
                                                  numberOfFavorites = formatter.format(numberOfFavorites);
                                                }
                                                else if (numberOfFavorites < 1000) {
                                                  numberOfFavorites = numberOfFavorites.toStringAsFixed(0);
                                                }

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

                                                var calories =
                                                    details["Nutrition"]
                                                        ["Calories"];
                                                var carbohydrates =
                                                    details["Nutrition"]
                                                        ["Carbohydrates"];
                                                var protein =
                                                    details["Nutrition"]
                                                        ["Protein"];
                                                var fat =
                                                    details["Nutrition"]["Fat"];

                                                var name = details["Title"];
                                                var image = details["Image"];

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
                                                                                45,
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
                                                                                              width:225,
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
                                                                                                  40,
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
                                                                                                SizedBox(width: 10),
                                                                                                Column(children:[
                                                                                                  GestureDetector(
                                                                                                      onTap: () => openDetails(false, true, recipe,context),
                                                                                                      child: Icon(Icons.subject, color: Colors.white,size:25)),
                                                                                                ]),
                                                                                          ]),
                                                                                        ),
                                                                                        ]
                                                                                      ),
                                                                                      Column(children:[
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: ClipOval(
                                                                                            child: Container(
                                                                                                width: 78,
                                                                                                height: 78,
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
                                                resultWidgets.add(recipeWidget);
                                              });
//                                              foods.forEach((
//                                                food,
//                                                details,
//                                              ) {
//                                                var calories =
//                                                    details["Nutrition"]
//                                                        ["Calories"];
//                                                var carbohydrates =
//                                                    details["Nutrition"]
//                                                        ["Carbohydrates"];
//                                                var protein =
//                                                    details["Nutrition"]
//                                                        ["Protein"];
//                                                var fat =
//                                                    details["Nutrition"]["Fat"];
//                                                var name = details["Name"];
//                                                var foodWidget = Padding(
//                                                    padding:
//                                                        EdgeInsets.all(12.0),
//                                                    child: Container(
//                                                      color: Colors.transparent,
//                                                      width:
//                                                          MediaQuery.of(context)
//                                                              .size
//                                                              .width,
//                                                      child: Container(
//                                                        padding:
//                                                            EdgeInsets.only(
//                                                                top: 5,
//                                                                bottom: 5),
//                                                        decoration: BoxDecoration(
//                                                            borderRadius:
//                                                                BorderRadius
//                                                                    .all(Radius
//                                                                        .circular(
//                                                                            20)),
//                                                            color:
//                                                                Color.fromRGBO(
//                                                                    255,
//                                                                    255,
//                                                                    255,
//                                                                    0.3)),
//                                                        child: Row(
//                                                          mainAxisAlignment:
//                                                              MainAxisAlignment
//                                                                  .spaceAround,
//                                                          children: <Widget>[
//                                                            SizedBox(width: 10),
//                                                            if (name != null)
//                                                              Container(
//                                                                  width: 80,
//                                                                  child: Column(
//                                                                      mainAxisAlignment:
//                                                                          MainAxisAlignment
//                                                                              .center,
//                                                                      crossAxisAlignment:
//                                                                          CrossAxisAlignment
//                                                                              .start,
//                                                                      children: [
//                                                                        Text(
//                                                                            "Name",
//                                                                            style:
//                                                                                descriptionTextExtraSmall),
//                                                                        Wrap(
//                                                                            children: [
//                                                                              Text(name, style: secondaryHeaderText)
//                                                                            ])
//                                                                      ])),
//                                                            if (calories !=
//                                                                null)
//                                                              Container(
//                                                                  width: 40,
//                                                                  child: Column(
//                                                                      mainAxisAlignment:
//                                                                          MainAxisAlignment
//                                                                              .center,
//                                                                      children: [
//                                                                        Text(
//                                                                            "Calories",
//                                                                            style:
//                                                                                descriptionTextExtraSmall),
//                                                                        Text(
//                                                                            calories,
//                                                                            style:
//                                                                                secondaryHeaderText)
//                                                                      ])),
//                                                            if (carbohydrates !=
//                                                                null)
//                                                              Container(
//                                                                  width: 40,
//                                                                  child: Column(
//                                                                      mainAxisAlignment:
//                                                                          MainAxisAlignment
//                                                                              .center,
//                                                                      children: [
//                                                                        Text(
//                                                                            "Carbs",
//                                                                            style:
//                                                                                descriptionTextExtraSmall),
//                                                                        Text(
//                                                                            carbohydrates,
//                                                                            style:
//                                                                                secondaryHeaderText)
//                                                                      ])),
//                                                            if (protein != null)
//                                                              Container(
//                                                                  width: 40,
//                                                                  child: Column(
//                                                                      mainAxisAlignment:
//                                                                          MainAxisAlignment
//                                                                              .center,
//                                                                      children: [
//                                                                        Text(
//                                                                            "Protein",
//                                                                            style:
//                                                                                descriptionTextExtraSmall),
//                                                                        Text(
//                                                                            protein,
//                                                                            style:
//                                                                                secondaryHeaderText)
//                                                                      ])),
//                                                            if (fat != null)
//                                                              Container(
//                                                                  width: 40,
//                                                                  child: Column(
//                                                                      mainAxisAlignment:
//                                                                          MainAxisAlignment
//                                                                              .center,
//                                                                      children: [
//                                                                        Text(
//                                                                            "Fat",
//                                                                            style:
//                                                                                descriptionTextExtraSmall),
//                                                                        Text(
//                                                                            fat,
//                                                                            style:
//                                                                                secondaryHeaderText)
//                                                                      ])),
//                                                            Column(
//                                                                mainAxisAlignment:
//                                                                MainAxisAlignment.center,
//                                                                children: [
//                                                                  GestureDetector(
//                                                                      onTap: () => openDetails(false, true, food,context),
//                                                                      child: Icon(Icons.subject, color: Colors.white,size:35)),
//                                                                  Text(
//                                                                      "Details",
//                                                                      style: descriptionTextExtraSmall)
//                                                                ]),
//                                                            SizedBox(width: 10),
//                                                          ],
//                                                        ),
//                                                      ),
//                                                    ));
//                                                resultWidgets.add(foodWidget);
//                                              });
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
                                  ])
                                ],
                              )))))
            ])
          ]),
    ]));
  }
}
