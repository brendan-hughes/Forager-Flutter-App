import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forageralpha/controller/favorite_functionality.dart';
import 'package:forageralpha/controller/formatting.dart';
import 'package:forageralpha/controller/forage_functionality.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var ID;
  var userID;
  var isLoading = true;
  var _firestore = Firestore.instance;
  var details;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetails().then((result) {
      setState(() {
        ID = result["ID"];
      });
    });
    getUserID().then((result){
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * 0.75,
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
                                  StreamBuilder<QuerySnapshot>(
                                    stream: _firestore.collection('recipeData').where('ID', isEqualTo:ID).limit(1).snapshots(),
                                    builder: (context, snapshot) {
                                      var foodName;
                                      var foodNutrition;
                                      var foodImage;
                                      var foodIngredients;
                                      var foodInstructions;
                                      var numberOfFavorites;
                                      var prepTime;
                                      var servings;
                                      var totalTime;
                                      var yield;
                                      var cookTime;

                                      if (snapshot.hasData) {
                                        final foodData = snapshot.data.documents;
                                        for (var data in foodData) {
                                          details = data.data;
                                          foodName = data.data["Title"];
                                          foodNutrition = data.data["Nutrition"];
                                          foodImage = data.data["ImageURL"];
                                          foodIngredients = data.data["Ingredients"];
                                          foodInstructions = data.data["Instructions"];
                                          numberOfFavorites = data.data["Favorites"];
                                          if (numberOfFavorites >= 1000) {
                                            final formatter = new NumberFormat.compact();
                                            numberOfFavorites = formatter.format(numberOfFavorites);
                                          }
                                          else if (numberOfFavorites < 1000) {
                                            numberOfFavorites = numberOfFavorites.toStringAsFixed(0);
                                          }
                                          prepTime = data.data["Prep Time"];
                                          servings = data.data["Servings"];
                                          totalTime = data.data["Total Time"];
                                          yield = data.data["Yield"];
                                          cookTime = data.data["Cook Time"];
                                        }}
                                      else {
                                        return isLoading
                                            ? Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
                                            ))
                                            : null;
                                      }
                                      List<Widget> ingredientWidgets = [];
                                      for (var ingredient in foodIngredients) {
                                        ingredientWidgets.add(
                                          Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(children:[Icon(Icons.fiber_manual_record,color:Colors.white,size:10),SizedBox(width:10),Text(ingredient,style: descriptionTextSmall)]),
                                          )
                                        );
                                      };

                                      List<Widget> instructionWidgets = [Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(),];
                                      var instructionCount = 0;
                                      while (instructionCount <= foodInstructions.length - 1) {
                                        int index = int.parse(foodInstructions.keys.toList()[instructionCount].toString().split(" ")[1]);

                                        instructionWidgets.insert(index,
                                            Padding(
                                              padding: const EdgeInsets.only(bottom:10),
                                              child: Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(foodInstructions.keys.toList()[instructionCount].toString(),style:descriptionTextBoldSmall),SizedBox(width:10),Text(foodInstructions.values.toList()[instructionCount].toString(),style: descriptionTextSmall)]),
                                            )
                                        );
                                        instructionCount = instructionCount+1;
                                      }
                                      instructionWidgets = List.from(instructionWidgets);

                                      List<Widget> nutritionalWidgets = [
                                        foodNutrition["Calcium"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Calcium: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Calcium"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["CalciumMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Carbohydrates"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Carbohydrates: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Carbohydrates"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["CarbohydratesMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Cholesterol"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Cholesterol: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Cholesterol"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["CholesterolMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Fat"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Fat: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Fat"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["FatMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Fiber"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Fiber: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Fiber"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["FiberMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Folate"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Folate: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Folate"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["FolateMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Iron"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Iron: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Iron"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["IronMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Magnesium"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Magnesium: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Magnesium"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["magnesiumMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["MonosaturatedFat"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Monosaturated Fat: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["MonosaturatedFat"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["MonosaturatedFatMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Phosphorus"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Phosphorus: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Phosphorus"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["PhosphorusMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["PolyunsaturatedFat"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Polyunsaturated Fat: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["PolyunsaturatedFat"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["PolyunsaturatedFatMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Potassium"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Potassium: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Potassium"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["PotassiumMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),
//
                                        foodNutrition["Protein"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Protein: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Protein"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["ProteinMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["SaturatedFat"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Saturated Fat: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["SaturatedFat"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["SaturatedFatMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Sodium"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Sodium: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Sodium"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["SodiumMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["Sugar"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Sugar: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["Sugar"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["SugarMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["TransFat"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Trans Fat: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["TransFat"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["TransFatMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["VitaminA"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Vitamin A: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["VitaminA"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["VitaminAMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["VitaminB1"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Vitamin B1: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["VitaminB1"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["VitaminB1Measure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["VitaminB2"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Vitamin B2: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["VitaminB2"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["VitaminB2Measure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["VitaminB3"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Vitamin B3: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["VitaminB3"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["VitaminB3Measure"],style:descriptionTextSmall)
                                              ]
                                              )) : Container(),

                                        foodNutrition["VitaminB6"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Vitamin B6: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["VitaminB6"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["VitaminB6Measure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["VitaminB12"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Vitamin B12: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["VitaminB12"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["VitaminB12Measure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["VitaminC"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Vitamin C: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["VitaminC"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["VitaminCMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["VitaminD"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Vitamin D: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["VitaminD"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["VitaminDMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["VitaminE"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Vitamin E: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["VitaminE"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["VitaminEMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                        foodNutrition["VitaminK"] != "null" ?
                                        Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
                                              Text("Vitamin K: ",style:descriptionTextBoldSmall),
                                              SizedBox(width:5),
                                              Text(foodNutrition["VitaminK"].toString(),style:descriptionTextSmall),
                                              Text(foodNutrition["VitaminKMeasure"],style:descriptionTextSmall)
                                            ]
                                            )) : Container(),

                                      ];
                                      isLoading = false;
                                      return Column(
                                          children: <Widget>[
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Wrap(
                                                          alignment: WrapAlignment.center,
                                                          children: <Widget>[
                                                            Text(
                                                            foodName != null ? foodName : "",
                                                            style: secondaryHeaderTextXXLarge,
                                                              textAlign: TextAlign.center,
                                                      ),
                                                          ],
                                                        ),
                                                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [Padding(
                                                          padding: const EdgeInsets.only(left:8.0,right:8.0),
                                                          child: GestureDetector(
                                                            onTap: () {share(context, foodName,foodIngredients,foodInstructions,foodNutrition);},
                                                            child: Column(children:[
                                                              Icon(Icons.share,color:Colors.white,size:35)]),
                                                          ),
                                                        ),
                                                          StreamBuilder<QuerySnapshot>(
                                                              stream: _firestore
                                                                  .collection('userData')
                                                                  .where('userID',
                                                                  isEqualTo: userID)
                                                                  .limit(1)
                                                                  .snapshots(),
                                                              builder: (context, snapshot) {
                                                                var favoritesIDs;
                                                                var isLiked;
                                                                if (snapshot.hasData) {
                                                                  final userResult = snapshot.data.documents;
                                                                  for (var user in userResult) {
                                                                    favoritesIDs = user.data['FavoritesIDs'];
                                                                    if (favoritesIDs.contains(ID)){
                                                                      isLiked = true;
                                                                    }
                                                                  }
                                                                }
                                                                if (isLiked == null) {
                                                                  isLiked = false;
                                                                }
                                                                return Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.center,
                                                                    children: [
                                                                      Stack(
                                                                          alignment: Alignment.center,
                                                                          children: [
                                                                            GestureDetector(
                                                                                onTap: () {
                                                                                  if (isLiked == true) {
                                                                                    updateLikesSimple (ID,details,false);
                                                                                  }
                                                                                  else {
                                                                                    updateLikesSimple (ID,details,true);
                                                                                  }
                                                                                },
                                                                                child: Icon(isLiked == true ? Icons.favorite:Icons.favorite_border, color: Colors.white,size:35)
                                                                            ),
                                                                            GestureDetector(onTap: () {
                                                                              if (isLiked == true) {
                                                                                updateLikesSimple (ID,details,false);
                                                                              }
                                                                              else {
                                                                                updateLikesSimple (ID,details,true);
                                                                              }
                                                                            },child: Text(numberOfFavorites.toString(),style: isLiked ? likeTextDark : likeTextLight)),
                                                                          ]
                                                                      ),
                                                                    ]
                                                                );
                                                              }
                                                          ),]),
                                                        Text("Source: allrecipes.com",style: descriptionTextExtraSmall,textAlign: TextAlign.center,),

                                                      ]
                                                    )),

                                                  Column(
                                                      children: [Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: ClipOval(
                                                          child: Container(
                                                            width: 140,
                                                            height: 140,
                                                            padding: EdgeInsets.all(5.0),
                                                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                                            child: CircleAvatar(
                                                              backgroundImage: NetworkImage(foodImage),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                        SizedBox(height:10),
                                                        Wrap(
                                                          alignment:WrapAlignment.center,
                                                            direction: Axis.horizontal,
                                                            verticalDirection: VerticalDirection.up,
                                                            children:[
                                                              prepTime != "null" ? Container(
                                                                  padding: EdgeInsets.all(2.5),
                                                                  margin: EdgeInsets.all(3.0),
                                                                  decoration:BoxDecoration(
                                                                    borderRadius:BorderRadius.circular(5),
                                                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                                                  ),
                                                                  child:Text("Prep: "+prepTime.toString(),style:descriptionTextExtraSmall)
                                                              ) : Container(),
                                                              cookTime != "null" ? Container(
                                                                  padding: EdgeInsets.all(2.5),
                                                                  margin: EdgeInsets.all(3.0),
                                                                  decoration:BoxDecoration(
                                                                    borderRadius:BorderRadius.circular(5),
                                                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                                                  ),
                                                                  child:Text("Cook: "+cookTime.toString(),style:descriptionTextExtraSmall)
                                                              ) : Container(),
                                                              servings != "null" ? Container(
                                                                  padding: EdgeInsets.all(2.5),
                                                                  margin: EdgeInsets.all(3.0),
                                                                  decoration:BoxDecoration(
                                                                    borderRadius:BorderRadius.circular(5),
                                                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                                                  ),
                                                                  child:Text("Servings: "+servings.toString(),style:descriptionTextExtraSmall)
                                                              ) : Container(),
                                                              yield != "null" ? Container(
                                                                  padding: EdgeInsets.all(2.5),
                                                                  margin: EdgeInsets.all(3.0),
                                                                  decoration:BoxDecoration(
                                                                    borderRadius:BorderRadius.circular(5),
                                                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                                                  ),
                                                                  child:Text("Yield: "+yield,style:descriptionTextExtraSmall)
                                                              ) : Container(),
                                                              totalTime != "null" ? Container(
                                                                  padding: EdgeInsets.all(2.5),
                                                                  margin: EdgeInsets.all(3.0),
                                                                  decoration:BoxDecoration(
                                                                    borderRadius:BorderRadius.circular(5),
                                                                    color: Color.fromRGBO(255, 255, 255, 0.3),
                                                                  ),
                                                                  child:Text("Total Time: "+totalTime.toString(),style:descriptionTextExtraSmall)
                                                              ) : Container(),
                                                            ]),
                                                        SizedBox(height:10),
                                                        ]
                                                  ),
                                                ]
                                              ),
                                            Container(
                                                width:MediaQuery.of(context).size.width,
                                                padding: EdgeInsets.only(
                                                    left: 20, top: 10, right: 20),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color:Color.fromRGBO(255,255,255,0.3),
                                                      border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.4),width:2)
                                                    ),
                                                    child: ExpansionTile(
                                                      trailing:Icon(Icons.arrow_drop_down_circle,color:Colors.white,size:20,),
                                                      title: Text(
                                                        "Ingredients",
                                                        style: descriptionTextSmallBold, textAlign: TextAlign.left,
                                                      ),
                                                      children: <Widget>[Container(
                                                        padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
                                                        width: MediaQuery.of(context).size.width,
                                                        child: Column(children:ingredientWidgets,mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                                        ),
                                                      )],
                                                    ),
                                                  ),]
                                                )),
                                            Container(
                                                width:MediaQuery.of(context).size.width,
                                                padding: EdgeInsets.only(
                                                    left: 20, top: 10, right: 20),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color:Color.fromRGBO(255,255,255,0.3),
                                                          border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.4),width:2)
                                                      ),
                                                      child: ExpansionTile(
                                                        trailing:Icon(Icons.arrow_drop_down_circle,color:Colors.white,size:20,),
                                                        title: Text(
                                                          "Instructions",
                                                          style: descriptionTextSmallBold, textAlign: TextAlign.left,
                                                        ),
                                                        children: <Widget>[Container(
                                                          padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
                                                          width: MediaQuery.of(context).size.width,
                                                          child: Column(children:instructionWidgets,mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                                          ),
                                                        )],
                                                      ),
                                                    ),]
                                                )),
                                            Container(
                                                width:MediaQuery.of(context).size.width,
                                                padding: EdgeInsets.only(
                                                    left: 20, top: 10, right: 20),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color:Color.fromRGBO(255,255,255,0.3),
                                                          border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.4),width:2)
                                                      ),
                                                      child: ExpansionTile(
                                                        trailing:Icon(Icons.arrow_drop_down_circle,color:Colors.white,size:20,),
                                                        title: Text(
                                                          "Nutritional Facts",
                                                          style: descriptionTextSmallBold, textAlign: TextAlign.left,
                                                        ),
                                                          children: <Widget>[Container(
                                                            padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
                                                            width: MediaQuery.of(context).size.width,
                                                            child: Column(children:nutritionalWidgets,mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                                            ),
                                                          )],
                                                      ),
                                                    ),]
                                                )),
                                          ]);
                                    }
                                  ),
                                ],
                              )))))
            ]),
          ]),
    ]));
  }
}
