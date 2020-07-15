import 'package:flutter/material.dart';
import 'package:forageralpha/controller/formatting.dart';
import 'package:forageralpha/controller/find_food_functionality.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forageralpha/controller/forage_functionality.dart';
import 'package:intl/intl.dart';
import 'package:forageralpha/controller/favorite_functionality.dart';

final _auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;
var favoritesList;
var appID;
enum ringColor { red, blue, green }
bool resultsShowed;
var userID;
List<Widget> favoriteWidgets = [];
bool isLoading = true;

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getUserID().then((result) {
      setState(() {
        userID = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
              ))
            : null,
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
                                    Text("FAVORITES", style: headerText),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                        children:[StreamBuilder<QuerySnapshot>(
                                            stream: _firestore
                                                .collection('userData')
                                                .where('userID',
                                                isEqualTo: userID)
                                                .limit(1)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                final queryResults =
                                                    snapshot.data.documents;
                                                List<Widget> resultWidgets = [];
                                                for (var query in queryResults) {
                                                  final recipes = query
                                                      .data["Favorites"];

                                                  var ringColors = ringColor.blue;
                                                  if (recipes == null) {
                                                    isLoading = false;
                                                    return Text("\nNo favorites found. \n\n Go back to Forage and find new faves!", style: descriptionText,textAlign: TextAlign.center,);
                                                  }

                                                  if (recipes.length != 0)
                                                  {recipes.forEach((
                                                      details
                                                      ) {
                                                    var recipe = details["ID"];
                                                    var ringColorCurrent;
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
                                                    if (image == null) {
                                                      image = details["ImageURL"];
                                                    }


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
                                                                                          Row(
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
                                                                                              ])
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

                                                                                      Row(children:[
                                                                                        Column(children:[
                                                                                          Text("Details",style:descriptionTextExtraSmall),
                                                                                          GestureDetector(
                                                                                              onTap: () => openDetails(false, true, recipe,context),
                                                                                              child: Icon(Icons.subject, color: Colors.white,size:35)),
                                                                                        ]),

                                                                                        SizedBox(width:10),
                                                                                        StreamBuilder<QuerySnapshot>(
                                                                                            stream: _firestore
                                                                                                .collection('userData')
                                                                                                .where('userID',
                                                                                                isEqualTo: userID)
                                                                                                .limit(1)
                                                                                                .snapshots(),
                                                                                            builder: (context, snapshot) {
                                                                                              var isLiked;
                                                                                              var favoritesIDs;
                                                                                              if (snapshot.hasData) {
                                                                                                final userResult = snapshot.data.documents;
                                                                                                for (var user in userResult) {
                                                                                                    favoritesIDs = user.data['FavoritesIDs'];
                                                                                                  }
                                                                                                  if (favoritesIDs.contains(recipe)) {
                                                                                                    isLiked = true;
                                                                                                  } else if (!favoritesIDs.contains(recipe)) {
                                                                                                    isLiked = false;
                                                                                                  }
                                                                                                }
                                                                                              if (isLiked == null) {
                                                                                                isLiked = false;
                                                                                              }
                                                                                              return Column(
                                                                                                  mainAxisAlignment:
                                                                                                  MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text("Favorites",style:descriptionTextExtraSmall),
                                                                                                    Stack(
                                                                                                        alignment: Alignment.center,
                                                                                                        children: [
                                                                                                          GestureDetector(
                                                                                                              onTap: () {
                                                                                                                if (isLiked == true) {
                                                                                                                  updateLikesSimple (recipe,details,false);
                                                                                                                  if (double.parse(numberOfFavorites) < 1000) {
                                                                                                                    numberOfFavorites =
                                                                                                                        (double
                                                                                                                            .parse(
                                                                                                                            numberOfFavorites) -
                                                                                                                            1)
                                                                                                                            .toStringAsFixed(
                                                                                                                            0);
                                                                                                                  }
                                                                                                                }
                                                                                                                else {
                                                                                                                  updateLikesSimple (recipe,details,true);
                                                                                                                  if (double.parse(numberOfFavorites) < 1000) {
                                                                                                                    numberOfFavorites =
                                                                                                                        (double
                                                                                                                            .parse(
                                                                                                                            numberOfFavorites) +
                                                                                                                            1)
                                                                                                                            .toStringAsFixed(
                                                                                                                            0);
                                                                                                                  }
                                                                                                                }
                                                                                                              },
                                                                                                              child: Icon(isLiked == true ? Icons.favorite:Icons.favorite_border, color: Colors.white,size:35)
                                                                                                          ),
                                                                                                          GestureDetector(onTap: () {
                                                                                                            if (isLiked == true) {
                                                                                                              updateLikesSimple (recipe,details,false);
                                                                                                            }
                                                                                                            else {
                                                                                                              updateLikesSimple (recipe,details,true);
                                                                                                            }
                                                                                                          },child: Text(numberOfFavorites.toString(),style: isLiked ? likeTextDark : likeTextLight)),
                                                                                                        ]
                                                                                                    ),
                                                                                                  ]
                                                                                              );
                                                                                            }
                                                                                        ),
                                                                                      ]
                                                                                      )
                                                                                    ])
                                                                                  ],
                                                                                ),
                                                                              ]))
                                                                        ]),
                                                                  ])),
                                                        ));
                                                    resultWidgets.add(recipeWidget);
                                                  });}
                                                  else {

                                                    return Text("\nNo favorites found. \n\n Go back to Forage and find new faves!", style: descriptionText,textAlign: TextAlign.center,);
                                                  }
                                                }
                                                isLoading = false;
                                                return Column(
                                                    children: resultWidgets);
                                              } else {
                                                return Center(child:CircularProgressIndicator());
                                              }
                                            }),])
                                  ])
                                ],
                              )))))
            ])
          ]),
    ]));
  }
}
