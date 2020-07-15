import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:forageralpha/controller/mongo.dart';

updateLikesSimple (foodID,rawDetails,isLiked) async {

  final details = {
    "Instructions": rawDetails["Instructions"],
    "Total Time": rawDetails["Total Tiem"],
    "ID":rawDetails["ID"],
    "Ingredients":rawDetails["Ingredients"],
    "ImageURL":rawDetails["ImageURL"],
    "Favorites":rawDetails["Favorites"],
    "Nutrition":rawDetails["Nutrition"],
    "Servings":rawDetails["Servings"],
    "Yield":rawDetails["Yield"],
    "Title":rawDetails["Title"],
    "Cook Time":rawDetails["Cook Time"],
    "Prep Time":rawDetails["Prep Time"]
  };
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;

  if (isLiked == true){
    await _firestore
        .collection('userData')
        .document(userID).updateData({"FavoritesIDs": FieldValue.arrayUnion([details["ID"]])});
    await _firestore
        .collection('recipeData')
        .document(foodID).updateData({"Favorites":FieldValue.increment(1)});
    await _firestore
      .collection('userData')
      .document(userID).updateData({"Favorites": FieldValue.arrayUnion([details])});
  }
  else if (isLiked != true) {
    await _firestore
        .collection('userData')
        .document(userID).updateData({"FavoritesIDs": FieldValue.arrayRemove([details["ID"]])});
    await _firestore
        .collection('recipeData')
        .document(foodID).updateData({"Favorites":FieldValue.increment(-1)});
    await _firestore
        .collection('userData')
        .document(userID).updateData({"Favorites": FieldValue.arrayRemove([details])});
  }
  await updateLikesInMongo(foodID,isLiked);
}

getQueryID () async {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;

  await for (var snapshot in _firestore.collection('userData').where(
      'userID', isEqualTo: userID).limit(1).snapshots()) {
    for (var result in snapshot.documents) {
      return result.data["currentQueryID"];
    }
  }
}

getQueryResults() async {
  final _firestore = Firestore.instance;
  var queryID = await getQueryID();
  await for (var snapshot in _firestore
      .collection('findFoodQueryResults')
      .where('queryID', isEqualTo: queryID)
      .limit(1)
      .snapshots()) {
    for (var results in snapshot.documents) {
      return results.data;
    }
  }
}

getUserData() async  {
  final _auth = FirebaseAuth.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  final _firestore = Firestore.instance;
  await for (var snapshot in _firestore
      .collection('userData')
      .where('userID', isEqualTo: userID)
      .limit(1)
      .snapshots()) {
    for (var user in snapshot.documents) {
      return user.data;
    }
  }
}

getFoodData(foodID) async  {
  final _firestore = Firestore.instance;
  await for (var snapshot in _firestore
      .collection('recipeData')
      .where('ID', isEqualTo: foodID)
      .limit(1)
      .snapshots()) {
    for (var recipe in snapshot.documents) {
      return recipe.data;
    }
  }
}

getResults(queryID) async {
  final _firestore = Firestore.instance;
   await for (var snapshot in _firestore
        .collection('findFoodQueryResults')
        .where('currentQueryID', isEqualTo: queryID)
        .limit(1)
        .snapshots()) {
      for (var result in snapshot.documents) {
        return result.data;
      }
    }
}

openDetails(isFood,isRecipe,id,context) async {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  await _firestore
      .collection('userData')
      .document(userID)
      .updateData({
    "currentFoodSelected": id,
  });
  Navigator.pushNamed(context,'/details');
}

loadDetails() async {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  final userData = await getSessionID(_firestore, userID).then((result) {
    return result;
  });
  var currentFoodID = userData["currentFoodSelected"];
  final foodData = await getFoodDetails(currentFoodID);
  return foodData;
}

sendToResults(context) {
  Navigator.pushNamed(context, '/findafoodresults');
}

getFoodDetails(foodID) async {
  final _firestore = Firestore.instance;
  await for (var snapshot in _firestore
      .collection('recipeData')
      .where('ID', isEqualTo: foodID)
      .limit(1)
      .snapshots()) {
    for (var food in snapshot.documents) {
      return food.data;
    }
}
}

getSessionID(_firestore, userID) async {
  await for (var snapshot in _firestore
      .collection('userData')
      .where('userID', isEqualTo: userID)
      .limit(1)
      .snapshots()) {
    for (var user in snapshot.documents) {
      return user.data;
    }
  }
}

getSessionData(_firestore, sessionID) async {
  await for (var snapshot in _firestore
      .collection('findFoodQueryData')
      .where('sessionID', isEqualTo: sessionID)
      .limit(1)
      .snapshots()) {
    for (var session in snapshot.documents) {
      return session.data;
    }
  }
}

share (context, foodName,foodIngredients,foodInstructions,foodNutrition) {
  final RenderBox box = context.findRenderObject();
  var text = "Do you Forage? I found this recipe on the Forager app... \n\nRecipe Name: ${foodName}\n\nIngredients:\n";
  for (var ingredient in foodIngredients) {
    text = text + "- "+ingredient + "\n";
  }
  text = text + "\nInstructions: \n";

  foodInstructions = Map.fromEntries(foodInstructions.entries.toList().reversed);
  foodInstructions.forEach((k,v) {
    text = text + k + ": " + v.toString() +"\n";
  });
  text = text + "\nNutritional Facts: \n";
  foodNutrition.forEach((k,v) {
    text = text + k + ": " + v.toString() +"\n";
  });

  final String subject = "Do you Forage? Check out this recipe.";

  Share.share(text,subject: subject,sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}