import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:forageralpha/screens/find_a_food_screen.dart';
import 'package:flutter/material.dart';
import 'formatting.dart';

initializeFindFood(_auth, _firestore) async {
  final user = await _auth.currentUser();
  String userID = user.uid;
  String sessionID = userID + "-SESSIONSTARTAT-" + DateTime.now().toString();
  _firestore.collection('findFoodQueryData').document(sessionID).setData({
    'sessionStartTime': DateTime.now(),
    'sessionEndTime': null,
    'userID': userID,
    'sessionID': sessionID,
    'active': true,
    'calorie': null,
    'ingredient': null,
    'calcium': null,
    'cholesterol': null,
    'monounsaturated': null,
    'polyunsaturated': null,
    'saturated': null,
    'trans': null,
    'iron': null,
    'fiber': null,
    'folate': null,
    'potassium': null,
    'magnesium': null,
    'sodium': null,
    'niacinb3': null,
    'phosphorus': null,
    'riboflavinb2': null,
    'sugars': null,
    'thiaminb1': null,
    'vitamine': null,
    'vitamina': null,
    'vitaminb12': null,
    'vitaminb6': null,
    'vitaminc': null,
    'vitamind': null,
    'vitamink': null,
    'breakfast': false,
    'lunch': false,
    'dinner': false,
    'snack': false,
    'teatime': false,

    'breads': false,
    'cakes': false,
    'candyFudge': false,
    'casseroles': false,
    'cocktails': false,
    'cookies': false,
    'macCheese': false,
    'mainDishes': false,
    'pastaSalads': false,
    'pasta': false,
    'pies': false,
    'pizzas': false,
    'sandwiches': false,
    'saucesCondiments': false,
    'smoothies': false,
    'soups': false,
    'bbq': false,
    'kids': false,
    'two': false,
    'budgetCooking': false,
    'pressureCooker': false,
    'quickEasy': false,
    'slowCooker': false,

    'american': false,
    'asian': false,
    'british': false,
    'caribbean': false,
    'centralEurope': false,
    'chinese': false,
    'easternEurope': false,
    'french': false,
    'indian': false,
    'italian': false,
    'japanese': false,
    'cleanEating': false,
    'mediterranean': false,
    'mexican': false,
    'middleEastern': false,
    'nordic': false,
    'southAmerican': false,
    'southEastAsian': false,
    'carbohydrates': null,
    'fat': null,
    'protein': null,
    'submitted': false,
    'vegan': false,
    'vegetarian': false,
    'ketogenic': false,
    'paleo': false,
    'lowSalt': false,
    'lowSugar': false,
    'dairyFree': false,
    'glutenFree': false,
    'individualFoods': true,
    'recipes': false,
    'eggFree':false,
    'fishFree':false,
    'fodmapFree':false,
    'balanced':false,
    'highFiber':false,
    'highProtein':false,
    'diabeticFriendly':false,
    'lowCarb':false,
    'lowFat':false,
    'pescatarian':false,
    'peanutFree':false,
    'porkFree':false,
    'redMeatFree':false,
    'sesameFree':false,
    'shellfishFree':false,
    'soyFree':false,
    'treenutFree':false,
    'heartHealthy':false,
  });

  _firestore.collection('userData').document(userID).updateData({
    'currentFindFoodSessionID': sessionID,
  });
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

addCondition(context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddConditionDialog();
      });
}

addCalorieCondition(context) {
  Navigator.pop(context);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CalorieDialog();
      });
}

addCarbohydrateCondition(context) {
  Navigator.pop(context);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CarbohydrateDialog();
      });
}

addFatCondition(context) {
  Navigator.pop(context);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return FatDialog();
      });
}

addProteinCondition(context) {
  Navigator.pop(context);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProteinDialog();
      });
}

addDietaryCondition(context,type) {
  if (type == "recipes")
    {Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DietaryDialog();
        });}
  if (type == "foods") {
    {Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DietaryDialogFoods();
        });}
  }
}

addMealTypeCondition(context) {
  Navigator.pop(context);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return MealTypeDialog();
      });
}

addDishTypeCondition(context) {
  Navigator.pop(context);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return DishTypeDialog();
      });
}

addVitaminCondition(context) {
  Navigator.pop(context);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return VitaminDialog();
      });
}

addCuisineCondition(context) {
  Navigator.pop(context);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CuisineDialog();
      });
}

addIngredientCondition(context) {
  Navigator.pop(context);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return IngredientDialog();
      });
}

submitCondition(conditionTypeString, conditionStatementString) async {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  String sessionID = await _firestore
      .collection('userData')
      .document(userID)
      .get()
      .then((value) {
    return value.data['currentFindFoodSessionID'];
  });
  await _firestore
      .collection('findFoodQueryData')
      .document(sessionID)
      .updateData({
    conditionTypeString: conditionStatementString,
  });
}

removeCondition(conditionTypeString) async {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  String sessionID = await _firestore
      .collection('userData')
      .document(userID)
      .get()
      .then((value) {
    return value.data['currentFindFoodSessionID'];
  });

    await _firestore
        .collection('findFoodQueryData')
        .document(sessionID)
        .updateData({
      conditionTypeString: null,
    });
}

checkSessionID() async {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  var sessionData =
      await _firestore.collection('userData').document(userID).get();
  String sessionID = sessionData.data['currentFindFoodSessionID'];
  return sessionID;
}

checkQueryID() async {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  var sessionData = await _firestore.collection('userData').document(userID).get();
  String queryID = sessionData.data['currentQueryID'];
  return queryID;
}

checkDietaryConditions() async {
  //This function is used to initialize the Dietary dialog alert.
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  var sessionData =
      await _firestore.collection('userData').document(userID).get();
  String sessionID = await sessionData.data['currentFindFoodSessionID'];
  var queryData = await _firestore
      .collection('findFoodQueryData')
      .document(sessionID)
      .get();
  bool vegan = queryData.data['vegan'];
  bool vegetarian = queryData.data['vegetarian'];
  bool ketogenic = queryData.data['ketogenic'];
  bool paleo = queryData.data['paleo'];
  bool lowSalt = queryData.data['lowSalt'];
  bool lowSugar = queryData.data['lowSugar'];
  bool dairyFree = queryData.data['dairyFree'];
  bool glutenFree = queryData.data['glutenFree'];
  bool balanced = queryData.data['balanced'];
  bool cleanEating = queryData.data['cleanEating'];
  bool pescatarian = queryData.data['pescatarian'];
  bool highFiber = queryData.data['highFiber'];
  bool highProtein = queryData.data['highProtein'];
  bool lowCarb = queryData.data['lowCarb'];
  bool lowFat = queryData.data['lowFat'];
  bool diabeticFriendly = queryData.data['diabeticFriendly'];
  bool eggFree = queryData.data['eggFree'];
  bool fishFree = queryData.data['fishFree'];
  bool fodmapFree = queryData.data['fodmapFree'];
  bool porkFree = queryData.data['porkFree'];
  bool redMeatFree = queryData.data['redMeatFree'];
  bool sesameFree = queryData.data['sesameFree'];
  bool shellfishFree = queryData.data['shellfishFree'];
  bool soyFree = queryData.data['soyFree'];
  bool treenutFree = queryData.data['treenutFree'];
  bool heartHealthy = queryData.data['heartHealthy'];
  bool peanutFree = queryData.data['peanutFree'];
  List conditions = [
    vegan,
    vegetarian,
    ketogenic,
    paleo,
    lowSalt,
    lowSugar,
    dairyFree,
    glutenFree,
    balanced,
    cleanEating,
    pescatarian,
    highFiber,
    highProtein,
    lowCarb,
    lowFat,
    diabeticFriendly,
    eggFree,
    fishFree,
    fodmapFree,
    porkFree,
    redMeatFree,
    sesameFree,
    shellfishFree,
    soyFree,
    treenutFree,
    heartHealthy,
    peanutFree
  ];

  return conditions;
}

endSession(sessionID, context) async {
  //This function is used when pressing Back to Menu, or refreshing profile conditions to end the session.
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  String sessionID = await _firestore
      .collection('userData')
      .document(userID)
      .get()
      .then((value) {
    return value.data['currentFindFoodSessionID'];
  });
  await _firestore
      .collection('findFoodQueryData')
      .document(sessionID)
      .updateData({
    "active": false,
    "sessionEndTime": DateTime.now(),
  });
  Navigator.pop(context);
}


class AddConditionDialog extends StatefulWidget {
  @override
  _AddConditionDialogState createState() => _AddConditionDialogState();
}

class _AddConditionDialogState extends State<AddConditionDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0,1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(onTap:() {Navigator.pop(context);},child: Icon(Icons.close, color: Colors.white)),
            top: 0,
            left: -5,
          ),
          Container(
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                    Text("SELECT CONDITION TYPE:", style: descriptionTextBold),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          child: RaisedButton(
                            onPressed: () => addCalorieCondition(context),
                            splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                            color: Color.fromRGBO(33, 33, 33, 0.5),
                            child:
                                Text("Calories", style: descriptionTextSmall),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Colors.white)),
                          ),
                        ),
                        Container(
                          width: 150,
                          child: RaisedButton(
                            onPressed: () => addVitaminCondition(context),
                            splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                            color: Color.fromRGBO(33, 33, 33, 0.5),
                            child: Text("Vitamins & Nutrients",
                                style: descriptionTextSmall),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Colors.white)),
                          ),
                        ),
                      ]),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 110,
                            child: RaisedButton(
                              onPressed: () =>
                                  addCarbohydrateCondition(context),
                              splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                              color: Color.fromRGBO(33, 33, 33, 0.5),
                              child: Text("Carbohydrates",
                                  style: descriptionTextSmall),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white)),
                            ),
                          ),
                          SizedBox(width: 7),
                          Container(
                            width: 50,
                            child: RaisedButton(
                              onPressed: () => addFatCondition(context),
                              splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                              color: Color.fromRGBO(33, 33, 33, 0.5),
                              child: Text("Fat", style: descriptionTextSmall),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white)),
                            ),
                          ),
                          SizedBox(width: 7),
                          Container(
                            width: 70,
                            child: RaisedButton(
                              onPressed: () => addProteinCondition(context),
                              splashColor: Color.fromRGBO(255, 255, 255, 0.1),

                              color: Color.fromRGBO(33, 33, 33, 0.5),
                              child:
                                  Text("Protein", style: descriptionTextSmall),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ]),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (selectedRecipes)
                        RaisedButton(
                          onPressed: () => addDietaryCondition(context,"recipes"),
                          splashColor: Color.fromRGBO(255, 255, 255, 0.1),

                          color: Color.fromRGBO(33, 33, 33, 0.5),
                          child: Text("Dietary Preferences",
                              style: descriptionTextSmall),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.white)),
                        ) else RaisedButton(
    onPressed: () => addDietaryCondition(context,"foods"),
    splashColor: Color.fromRGBO(255, 255, 255, 0.1),

    color: Color.fromRGBO(33, 33, 33, 0.5),
    child: Text("Dietary Preferences",
    style: descriptionTextSmall),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
    side: BorderSide(color: Colors.white)),
    ),
//                        if (selectedRecipes)
//                          Container(
//                            width: 100,
//                            child: RaisedButton(
//                              onPressed: () => addIngredientCondition(context),
//                              splashColor: Color.fromRGBO(255, 255, 255, 0.1),
//
//                              color: Color.fromRGBO(33, 33, 33, 0.5),
//                              child: Text("Ingredient",
//                                  style: descriptionTextSmall),
//                              shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20.0),
//                                  side: BorderSide(color: Colors.white)),
//                            ),
//                          ),
                      ]),
                  if (selectedRecipes)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 84,
                            child: RaisedButton(
                              onPressed: () => addMealTypeCondition(context),
                              splashColor: Color.fromRGBO(255, 255, 255, 0.1),

                              color: Color.fromRGBO(33, 33, 33, 0.5),
                              child: Text("Meal Type",
                                  style: descriptionTextSmall),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white)),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 80,
                            child: RaisedButton(
                              onPressed: () => addDishTypeCondition(context),
                              splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                              color: Color.fromRGBO(33, 33, 33, 0.5),
                              child: Text("Dish Type",
                                  style: descriptionTextSmall),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white)),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 70,
                            child: RaisedButton(
                              onPressed: () => addCuisineCondition(context),
                              splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                              color: Color.fromRGBO(33, 33, 33, 0.5),
                              child:
                                  Text("Cuisine", style: descriptionTextSmall),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ]),
                ],
              )),
        ]));

  }
}

class CalorieDialog extends StatefulWidget {
  @override
  _CalorieDialogState createState() => _CalorieDialogState();
}

class _CalorieDialogState extends State<CalorieDialog> {
  var selectedRange = RangeValues(100, 500);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  addCondition(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: 5,
            left: -3,
          ),
          Container(
            height: 125,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Set calorie range:", style: descriptionText),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(selectedRange.start.round().toString(),
                          style: descriptionTextBold),
                      Text(" to ", style: descriptionTextSmall),
                      Text(selectedRange.end.round().toString(),
                          style: descriptionTextBold),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  RangeSlider(
                    values: selectedRange,
                    min: 0,
                    max: 2000,
                    divisions: 200,
                    onChanged: (RangeValues newRange) {
                      setState(() {
                        selectedRange = newRange;
                      });
                    },
//                      labels: RangeLabels('${selectedRange.start.round()}','${selectedRange.end.round()}'),
                    inactiveColor: Color.fromRGBO(255, 255, 255, 0.2),
                    activeColor: Color.fromRGBO(255, 255, 255, 0.8),
                  ),
                  Container(
                    height: 25,
                    width: 55,
                    child: RaisedButton(
                      onPressed: () {
                        String conditionStatementString =
                            selectedRange.start.round().toString() +
                                " to " +
                                selectedRange.end.round().toString();
                        submitCondition('calorie', conditionStatementString);
                        Navigator.pop(context);
                      },
                      splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                      elevation: 40.0,
                      color: Color.fromRGBO(33, 33, 33, 0.5),
                      child: Text("Add", style: descriptionTextSmall),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  )
                ]),
          ),
        ]));

  }
}

class CarbohydrateDialog extends StatefulWidget {
  @override
  _CarbohydrateDialogState createState() => _CarbohydrateDialogState();
}

class _CarbohydrateDialogState extends State<CarbohydrateDialog> {
  var selectedRange = RangeValues(20, 50);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  addCondition(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: 5,
            left: -3,
          ),
          Container(
            height: 125,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Set carbohydrate range (g):", style: descriptionText),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(selectedRange.start.round().toString(),
                          style: descriptionTextBold),
                      Text(" to ", style: descriptionTextSmall),
                      Text(selectedRange.end.round().toString(),
                          style: descriptionTextBold),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  RangeSlider(
                    values: selectedRange,
                    min: 0,
                    max: 250,
                    divisions: 250,
                    onChanged: (RangeValues newRange) {
                      setState(() {
                        selectedRange = newRange;
                      });
                    },
//                      labels: RangeLabels('${selectedRange.start.round()}','${selectedRange.end.round()}'),
                    inactiveColor: Color.fromRGBO(255, 255, 255, 0.2),
                    activeColor: Color.fromRGBO(255, 255, 255, 0.8),
                  ),
                  Container(
                    height: 25,
                    width: 55,
                    child: RaisedButton(
                      onPressed: () {
                        String conditionStatementString =
                            selectedRange.start.round().toString() +
                                " to " +
                                selectedRange.end.round().toString();
                        submitCondition(
                            'carbohydrates', conditionStatementString);
                        Navigator.pop(context);
                      },
                      splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                      elevation: 40.0,
                      color: Color.fromRGBO(33, 33, 33, 0.5),
                      child: Text("Add", style: descriptionTextSmall),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  )
                ]),
          ),
        ]));

  }
}

class FatDialog extends StatefulWidget {
  @override
  _FatDialogState createState() => _FatDialogState();
}

class _FatDialogState extends State<FatDialog> {
  var selectedRange = RangeValues(10, 25);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  addCondition(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: 5,
            left: -3,
          ),
          Container(
            height: 125,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Set fat range (g):", style: descriptionText),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(selectedRange.start.round().toString(),
                          style: descriptionTextBold),
                      Text(" to ", style: descriptionTextSmall),
                      Text(selectedRange.end.round().toString(),
                          style: descriptionTextBold),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  RangeSlider(
                    values: selectedRange,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    onChanged: (RangeValues newRange) {
                      setState(() {
                        selectedRange = newRange;
                      });
                    },
//                      labels: RangeLabels('${selectedRange.start.round()}','${selectedRange.end.round()}'),
                    inactiveColor: Color.fromRGBO(255, 255, 255, 0.2),
                    activeColor: Color.fromRGBO(255, 255, 255, 0.8),
                  ),
                  Container(
                    height: 25,
                    width: 55,
                    child: RaisedButton(
                      onPressed: () {
                        String conditionStatementString =
                            selectedRange.start.round().toString() +
                                " to " +
                                selectedRange.end.round().toString();
                        submitCondition('fat', conditionStatementString);
                        Navigator.pop(context);
                      },
                      splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                      elevation: 40.0,
                      color: Color.fromRGBO(33, 33, 33, 0.5),
                      child: Text("Add", style: descriptionTextSmall),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  )
                ]),
          ),
        ]));

  }
}

class ProteinDialog extends StatefulWidget {
  @override
  _ProteinDialogState createState() => _ProteinDialogState();
}

class _ProteinDialogState extends State<ProteinDialog> {
  var selectedRange = RangeValues(10, 25);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  addCondition(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: 5,
            left: -3,
          ),
          Container(
            height: 125,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Set protein range (g):", style: descriptionText),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(selectedRange.start.round().toString(),
                          style: descriptionTextBold),
                      Text(" to ", style: descriptionTextSmall),
                      Text(selectedRange.end.round().toString(),
                          style: descriptionTextBold),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  RangeSlider(
                    values: selectedRange,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    onChanged: (RangeValues newRange) {
                      setState(() {
                        selectedRange = newRange;
                      });
                    },
//                      labels: RangeLabels('${selectedRange.start.round()}','${selectedRange.end.round()}'),
                    inactiveColor: Color.fromRGBO(255, 255, 255, 0.2),
                    activeColor: Color.fromRGBO(255, 255, 255, 0.8),
                  ),
                  Container(
                    height: 25,
                    width: 55,
                    child: RaisedButton(
                      onPressed: () {
                        String conditionStatementString =
                            selectedRange.start.round().toString() +
                                " to " +
                                selectedRange.end.round().toString();
                        submitCondition('protein', conditionStatementString);
                        Navigator.pop(context);
                      },
                      splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                      elevation: 40.0,
                      color: Color.fromRGBO(33, 33, 33, 0.5),
                      child: Text("Add", style: descriptionTextSmall),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  )
                ]),
          ),
        ]));

  }
}

class _DietaryDialogState extends State<DietaryDialog> {
  bool vegan;
  bool vegetarian;
  bool ketogenic;
  bool paleo;
  bool lowSalt;
  bool lowSugar;
  bool dairyFree;
  bool glutenFree;
  bool eggFree;
  bool fishFree;
  bool fodmapFree;
  bool balanced;
  bool highFiber;
  bool highProtein;
  bool diabeticFriendly;
  bool lowCarb;
  bool lowFat;
  bool pescatarian;
  bool cleanEating;
  bool peanutFree;
  bool porkFree;
  bool redMeatFree;
  bool sesameFree;
  bool shellfishFree;
  bool soyFree;
  bool treenutFree;
  bool heartHealthy;
  var dropdownValue;
  List dropdownOptions;

  var dietaryToFirebaseDictionary = {
    'Vegan': 'vegan',
    'Vegetarian': 'vegetarian',
    "Ketogenic": 'ketogenic',
    "Paleo": 'paleo',
    "Low Salt": 'lowSalt',
    "Low Sugar": "lowSugar",
    "Dairy Free": "dairyFree",
    "Gluten Free": "glutenFree",
    'Egg Free': 'eggFree',
    'Fish Free': 'fishFree',
    'Low FODMAP': 'lowFODMAP',
    'High Fiber': 'highFiber',
    'High Protein': 'highProtein',
    'Diabetic Friendly': 'diabeticFriendly',
    'Low Carb': 'lowCarb',
    'Low Fat': 'lowFat',
    'Peanut Free': 'peanutFree',
    'Pork Free': 'porkFree',
    'Red Meat Free': 'redMeatFree',
    'Sesame Free': 'sesameFree',
    'Shellfish Free': 'shellfishFree',
    'Soy Free': 'soyFree',
    'Tree Nut Free': 'treenutFree',
    'Wheat Free': 'heartHealthy',
    'Balanced': 'balanced',
    'Clean Eating': 'cleanEating'
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDietaryConditions().then((conditions) {
      setState(() {
        vegan = conditions[0];
        vegetarian = conditions[1];
        ketogenic = conditions[2];
        paleo = conditions[3];
        lowSalt = conditions[4];
        lowSugar = conditions[5];
        dairyFree = conditions[6];
        glutenFree = conditions[7];
        eggFree = conditions[8];
        fishFree = conditions[9];
        fodmapFree = conditions[10];
        balanced = conditions[11];
        highFiber = conditions[12];
        highProtein = conditions[13];
        diabeticFriendly = conditions[14];
        lowCarb = conditions[15];
        lowFat = conditions[16];
        pescatarian = conditions[17];
        cleanEating = conditions[18];
        peanutFree = conditions[19];
        porkFree = conditions[20];
        redMeatFree = conditions[21];
        sesameFree = conditions[22];
        shellfishFree = conditions[23];
        soyFree = conditions[23];
        treenutFree = conditions[24];
        heartHealthy = conditions[25];
        dropdownValue = "Vegan";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  addCondition(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: -5,
            left: -3,
          ),
          Container(
              height: 200,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(" Select preference from dropdown:",
                        style: descriptionText),
                    DropdownButton(
                      value: dropdownValue,
                      dropdownColor: Color.fromRGBO(0, 0, 0, 1),
                      icon: Icon(Icons.touch_app),
                      iconSize: 15,
                      elevation: 16,
                      style: descriptionTextBoldSmall,
                      onChanged: (var newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        "Vegan",
                        "Vegetarian",
                        "Ketogenic",
                        "Paleo",
                        "Clean Eating",
                        "Low Salt",
                        "Low Sugar",
                        "Dairy Free",
                        "Gluten Free",
                        'Egg Free',
                        'Fish Free',
                        'Low FODMAP',
                        'High Fiber',
                        'High Protein',
                        'Diabetic Friendly',
                        'Low Carb',
                        'Low Fat',
                        'Peanut Free',
                        'Pork Free',
                        'Red Meat Free',
                        'Sesame Free',
                        'Shellfish Free',
                        'Soy Free',
                        'Tree Nut Free',
                        'Wheat Free'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Container(
                      height: 25,
                      width: 55,
                      child: RaisedButton(
                        onPressed: () {
                          submitCondition(
                              dietaryToFirebaseDictionary[dropdownValue], true);
                          Navigator.pop(context);
                        },
                        splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                        elevation: 40.0,
                        color: Color.fromRGBO(33, 33, 33, 0.5),
                        child: Text("Add", style: descriptionTextSmall),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.white)),
                      ),
                    )
                  ]))
        ]));
  }
}

class DietaryDialog extends StatefulWidget {
  @override
  _DietaryDialogState createState() => _DietaryDialogState();
}

class _DietaryDialogFoodsState extends State<DietaryDialogFoods> {
  bool vegan;
  bool vegetarian;
  bool ketogenic;
  bool paleo;
  bool lowSalt;
  bool lowSugar;
  bool dairyFree;
  bool glutenFree;
  bool eggFree;
  bool fishFree;
  bool fodmapFree;
  bool balanced;
  bool highFiber;
  bool highProtein;
  bool diabeticFriendly;
  bool lowCarb;
  bool lowFat;
  bool pescatarian;
  bool cleanEating;
  bool peanutFree;
  bool porkFree;
  bool redMeatFree;
  bool sesameFree;
  bool shellfishFree;
  bool soyFree;
  bool treenutFree;
  bool heartHealthy;
  var dropdownValue;
  List dropdownOptions;

  var dietaryToFirebaseDictionary = {
    'Vegan': 'vegan',
    'Vegetarian': 'vegetarian',
    "Ketogenic": 'ketogenic',
    "Paleo": 'paleo',
    "Low Salt": 'lowSalt',
    "Low Sugar": "lowSugar",
    "Dairy Free": "dairyFree",
    "Gluten Free": "glutenFree",
    'Egg Free': 'eggFree',
    'Fish Free': 'fishFree',
    'Low FODMAP': 'lowFODMAP',
    'High Fiber': 'highFiber',
    'High Protein': 'highProtein',
    'Diabetic Friendly': 'diabeticFriendly',
    'Low Carb': 'lowCarb',
    'Low Fat': 'lowFat',
    'Peanut Free': 'peanutFree',
    'Pork Free': 'porkFree',
    'Red Meat Free': 'redMeatFree',
    'Sesame Free': 'sesameFree',
    'Shellfish Free': 'shellfishFree',
    'Soy Free': 'soyFree',
    'Tree Nut Free': 'treenutFree',
    'Wheat Free': 'heartHealthy',
    'Balanced': 'balanced',
    'Clean Eating': 'cleanEating'
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDietaryConditions().then((conditions) {
      setState(() {
        vegan = conditions[0];
        vegetarian = conditions[1];
        ketogenic = conditions[2];
        paleo = conditions[3];
        lowSalt = conditions[4];
        lowSugar = conditions[5];
        dairyFree = conditions[6];
        glutenFree = conditions[7];
        eggFree = conditions[8];
        fishFree = conditions[9];
        fodmapFree = conditions[10];
        balanced = conditions[11];
        highFiber = conditions[12];
        highProtein = conditions[13];
//        diabeticFriendly = conditions[14];
        lowCarb = conditions[15];
        lowFat = conditions[16];
        pescatarian = conditions[17];
//        cleanEating = conditions[18];
        peanutFree = conditions[19];
        porkFree = conditions[20];
        redMeatFree = conditions[21];
        sesameFree = conditions[22];
        shellfishFree = conditions[23];
        soyFree = conditions[23];
        treenutFree = conditions[24];
        heartHealthy = conditions[25];
        dropdownValue = "Vegan";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  addCondition(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: -5,
            left: -3,
          ),
          Container(
              height: 200,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(" Select preference from dropdown:",
                        style: descriptionText),
                    DropdownButton(
                      value: dropdownValue,
                      dropdownColor: Color.fromRGBO(0, 0, 0, 1),
                      icon: Icon(Icons.touch_app),
                      iconSize: 15,
                      elevation: 16,
                      style: descriptionTextBoldSmall,
                      onChanged: (var newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        "Vegan",
                        "Vegetarian",
                        "Ketogenic",
                        "Paleo",
                        "Low Salt",
                        "Low Sugar",
                        "Dairy Free",
                        "Gluten Free",
                        'Egg Free',
                        'Fish Free',
                        'Low FODMAP',
                        'High Fiber',
                        'High Protein',
                        'Low Carb',
                        'Low Fat',
                        'Peanut Free',
                        'Pork Free',
                        'Red Meat Free',
                        'Sesame Free',
                        'Shellfish Free',
                        'Soy Free',
                        'Tree Nut Free',
                        'Wheat Free'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Container(
                      height: 25,
                      width: 55,
                      child: RaisedButton(
                        onPressed: () {
                          submitCondition(
                              dietaryToFirebaseDictionary[dropdownValue], true);
                          Navigator.pop(context);
                        },
                        splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                        elevation: 40.0,
                        color: Color.fromRGBO(33, 33, 33, 0.5),
                        child: Text("Add", style: descriptionTextSmall),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.white)),
                      ),
                    )
                  ]))
        ]));
  }
}

class DietaryDialogFoods extends StatefulWidget {
  @override
  _DietaryDialogFoodsState createState() => _DietaryDialogFoodsState();
}

class VitaminDialog extends StatefulWidget {
  @override
  _VitaminDialogState createState() => _VitaminDialogState();
}

class _VitaminDialogState extends State<VitaminDialog> {
  var selectedRange = RangeValues(10, 25);
  var dropdownValue = "Calcium (mg)";
  var mgOptions = [
    'Calcium (mg)',
    'Cholesterol (mg)',
    'Iron (mg)',
    'Potassium (mg)',
    'Magnesium (mg)',
    'Sodium (mg)',
    'Niacin (B3) (mg)',
    'Phosphorus (mg)',
    'Riboflavin (B2) (mg)',
    'Thiamin (B1) (mg)',
    'Vitamin E (mg)',
    'Vitamin B6 (mg)',
    'Vitamin C (mg)'
  ];
  var gOptions = [
    'Sugars (g)',
    'Monounsaturated Fats (g)',
    'Polyunsaturated Fats (g)',
    'Saturated Fats (g)',
    'Trans Fats (g)',
    'Fiber (g)'
  ];
  var ugOptions = [
    'Vitamin D (μg)',
    'Vitamin K (μg)',
    'Vitamin A (μg)',
    'Vitamin B12 (μg)',
    'Folate (μg)'
  ];
  var minRange = 0;
  var maxRange = 100;
  var rangeDivisions = 100;

  var vitaminToFirebaseDictionary = {
    'Calcium (mg)': 'calcium',
    'Cholesterol (mg)': 'cholesterol',
    'Monounsaturated Fats (g)': 'monounsaturated',
    'Polyunsaturated Fats (g)': 'polyunsaturated',
    'Saturated Fats (g)': 'saturated',
    'Trans Fats (g)': 'trans',
    'Iron (mg)': 'iron',
    'Fiber (g)': 'fiber',
    'Folate (μg)': 'folate',
    'Potassium (mg)': 'potassium',
    'Magnesium (mg)': 'magnesium',
    'Sodium (mg)': 'sodium',
    'Niacin (B3) (mg)': 'niacinb3',
    'Phosphorus (mg)': 'phosphorus',
    'Riboflavin (B2) (mg)': 'riboflavinb2',
    'Sugars (g)': 'sugars',
    'Thiamin (B1) (mg)': 'thiaminb1',
    'Vitamin E (mg)': 'vitamine',
    'Vitamin A (μg)': 'vitamina',
    'Vitamin B12 (μg)': 'vitaminb12',
    'Vitamin B6 (mg)': 'vitaminb6',
    'Vitamin C (mg)': 'vitaminc',
    'Vitamin D (μg)': 'vitamind',
    'Vitamin K (μg)': 'vitamink'
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  addCondition(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: -5,
            left: -3,
          ),
          Container(
            height: 200,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text("Select from dropdown and set range:",
                      style: descriptionText),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    DropdownButton(
                      value: dropdownValue,
                      dropdownColor: Color.fromRGBO(0, 0, 0, 1),
                      icon: Icon(Icons.touch_app),
                      iconSize: 15,
                      elevation: 16,
                      style: descriptionTextBoldSmall,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          if (gOptions.contains(dropdownValue)) {
                            setState(() {
                              minRange = 0;
                              maxRange = 100;
                              rangeDivisions = 100;
                              selectedRange = RangeValues(10, 25);
                            });
                          } else if (mgOptions.contains(dropdownValue) ||
                              ugOptions.contains(dropdownValue)) {
                            setState(() {
                              minRange = 0;
                              maxRange = 2000;
                              rangeDivisions = 200;
                              selectedRange = RangeValues(200, 500);
                            });
                          }
                        });
                      },
                      items: <String>[
                        'Calcium (mg)',
                        'Cholesterol (mg)',
                        'Monounsaturated Fats (g)',
                        'Polyunsaturated Fats (g)',
                        'Saturated Fats (g)',
                        'Trans Fats (g)',
                        'Iron (mg)',
                        'Fiber (g)',
                        'Folate (μg)',
                        'Potassium (mg)',
                        'Magnesium (mg)',
                        'Sodium (mg)',
                        'Niacin (B3) (mg)',
                        'Phosphorus (mg)',
                        'Riboflavin (B2) (mg)',
                        'Sugars (g)',
                        'Thiamin (B1) (mg)',
                        'Vitamin E (mg)',
                        'Vitamin A (μg)',
                        'Vitamin B12 (μg)',
                        'Vitamin B6 (mg)',
                        'Vitamin C (mg)',
                        'Vitamin D (μg)',
                        'Vitamin K (μg)'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(selectedRange.start.round().toString(),
                          style: descriptionTextBold),
                      Text(" to ", style: descriptionTextSmall),
                      Text(selectedRange.end.round().toString(),
                          style: descriptionTextBold),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  RangeSlider(
                    values: selectedRange,
                    min: minRange.toDouble(),
                    max: maxRange.toDouble(),
                    divisions: rangeDivisions,
                    onChanged: (RangeValues newRange) {
                      setState(() {
                        selectedRange = newRange;
                      });
                    },
//                      labels: RangeLabels('${selectedRange.start.round()}','${selectedRange.end.round()}'),
                    inactiveColor: Color.fromRGBO(255, 255, 255, 0.2),
                    activeColor: Color.fromRGBO(255, 255, 255, 0.8),
                  ),
                  Container(
                    height: 25,
                    width: 55,
                    child: RaisedButton(
                      onPressed: () {
                        final conditionType =
                            vitaminToFirebaseDictionary[dropdownValue];

                        String conditionStatementString =
                            selectedRange.start.round().toString() +
                                " to " +
                                selectedRange.end.round().toString();
                        submitCondition(
                            vitaminToFirebaseDictionary[dropdownValue],
                            conditionStatementString);
                        Navigator.pop(context);
                      },
                      splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                      elevation: 40.0,
                      color: Color.fromRGBO(33, 33, 33, 0.5),
                      child: Text("Add", style: descriptionTextSmall),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  )
                ]),
          ),
        ]));

  }
}

class CuisineDialog extends StatefulWidget {
  @override
  _CuisineDialogState createState() => _CuisineDialogState();
}

class _CuisineDialogState extends State<CuisineDialog> {
  var dropdownValue = "African";
  var cuisineToFirebaseDictionary = {
    'African':'african',
    'American':'american',
    'Aregentinian':'aregentinian',
    'Australian':'australian',
    'Austrian':'austrian',
    'Bangladeshi':'bangladeshi',
    'Belgian':'belgian',
    'Brazilian':'brazilian',
    'Canadian':'canadian',
    'Chilean':'chilean',
    'Chinese':'chinese',
    'Colombian':'colombian',
    'Cuban':'cuban',
    'Dutch':'dutch',
    'Eastern European':'easternEuropean',
    'Filipino':'filipino',
    'French':'french',
    'German':'german',
    'Greek':'greek',
    'Indian':'indian',
    'Indonesian':'indonesian',
    'Israeli':'israeli',
    'Italian':'italian',
    'Jamaican':'jamaican',
    'Japanese':'japanese',
    'Korean':'korean',
    'Lebanese':'lebanese',
    'Malaysian':'malaysian',
    'Mediterranean':'mediterranean',
    'Mexican':'mexican',
    'Pakistani':'pakistani',
    'Persian':'persian',
    'Peruvian':'peruvian',
    'Portuguese':'portuguese',
    'Puerto Rican':'puertoRican',
    'Scandinavian':'scandinavian',
    'Southern':'southern',
    'Spanish':'spanish',
    'Swiss':'swiss',
    'Thai':'thai',
    'Turkish':'turkish',
    'UK & Irish':'ukIrish',
    'Vietnamese':'vietnamese',
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  addCondition(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: 0,
            left: -3,
          ),
          Container(
            height: 125,
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    "Select cuisine from dropdown:",
                    style: descriptionText,
                    textAlign: TextAlign.center,
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    dropdownColor: Color.fromRGBO(0, 0, 0, 1),
                    icon: Icon(Icons.touch_app),
                    iconSize: 15,
                    elevation: 16,
                    style: descriptionTextBoldSmall,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'African',
                      'American',
                      'Aregentinian',
                      'Australian',
                      'Austrian',
                      'Bangladeshi',
                      'Belgian',
                      'Brazilian',
                      'Canadian',
                      'Chilean',
                      'Chinese',
                      'Colombian',
                      'Cuban',
                      'Dutch',
                      'Eastern European',
                      'Filipino',
                      'French',
                      'German',
                      'Greek',
                      'Indian',
                      'Indonesian',
                      'Israeli',
                      'Italian',
                      'Jamaican',
                      'Japanese',
                      'Korean',
                      'Lebanese',
                      'Malaysian',
                      'Mediterranean',
                      'Mexican',
                      'Pakistani',
                      'Persian',
                      'Peruvian',
                      'Portuguese',
                      'Puerto Rican',
                      'Scandinavian',
                      'Southern',
                      'Spanish',
                      'Swiss',
                      'Thai',
                      'Turkish',
                      'UK & Irish',
                      'Vietnamese'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 25,
                    width: 55,
                    child: RaisedButton(
                      onPressed: () {
                        submitCondition(
                            cuisineToFirebaseDictionary[dropdownValue], true);
                        Navigator.pop(context);
                      },
                      splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                      elevation: 40.0,
                      color: Color.fromRGBO(33, 33, 33, 0.5),
                      child: Text("Add", style: descriptionTextSmall),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  )
                ]),
          ),
        ]));
  }
}

class MealTypeDialog extends StatefulWidget {
  @override
  _MealTypeDialogState createState() => _MealTypeDialogState();
}

class _MealTypeDialogState extends State<MealTypeDialog> {
  var dropdownValue = "Breakfast & Brunch";
  var mealTypeToFirebaseDictionary = {
    "Breakfast & Brunch": 'breakfastAndBrunch',
    "Desserts":'desserts',
    "Dinners":'dinners',
    "Lunch":'lunch',
    "Appetizers & Snacks":'appetizersSnacks',
    "Entertaining & Dinner Parties":'entertainingParties'
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  addCondition(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: 0,
            left: -3,
          ),
          Container(
            height: 125,
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    "Select meal type from dropdown:",
                    style: descriptionText,
                    textAlign: TextAlign.center,
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    dropdownColor: Color.fromRGBO(0, 0, 0, 1),
                    icon: Icon(Icons.touch_app),
                    iconSize: 15,
                    elevation: 16,
                    style: descriptionTextBoldSmall,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      "Breakfast & Brunch",
                      "Desserts",
                      "Dinners",
                      "Lunch",
                      "Appetizers & Snacks",
                      "Entertaining & Dinner Parties"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 25,
                    width: 55,
                    child: RaisedButton(
                      onPressed: () {
                        submitCondition(
                            mealTypeToFirebaseDictionary[dropdownValue], true);
                        Navigator.pop(context);
                      },
                      splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                      elevation: 40.0,
                      color: Color.fromRGBO(33, 33, 33, 0.5),
                      child: Text("Add", style: descriptionTextSmall),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  )
                ]),
          ),
        ]));
  }
}

class DishTypeDialog extends StatefulWidget {
  @override
  _DishTypeDialogState createState() => _DishTypeDialogState();
}

class _DishTypeDialogState extends State<DishTypeDialog> {
  var dropdownValue = "Breads";
  var dishTypeToFirebaseDictionary = {
    'Breads':'breads',
    'Cakes':'cakes',
    'Candy & Fudge':'candyFudge',
    'Casseroles':'casseroles',
    'Cocktails':'cocktails',
    'Cookies':'cookies',
    'Mac & Cheese':'macCheese',
    'Main Dishes':'mainDishes',
    'Pasta Salads':'pastaSalads',
    'Pasta':'pasta',
    'Pies':'pies',
    'Pizzas':'pizzas',
    'Sandwiches':'sandwiches',
    'Sauces & Condiments':'saucesCondiments',
    'Smoothies':'smoothies',
    'Soups, Stews, & Chilis':'soups',
    'BBQ & Grilling':'bbq',
    'For Kids':'kids',
    'For Two':'two',
    'Budget Cooking':'budgetCooking',
    'Pressure Cooker':'pressureCooker',
    'Quick & Easy':'quickEasy',
    'Slow Cooker':'slowCooker',
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  addCondition(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: 0,
            left: -3,
          ),
          Container(
            height: 125,
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    "Select dish type from dropdown:",
                    style: descriptionText,
                    textAlign: TextAlign.center,
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    dropdownColor: Color.fromRGBO(0, 0, 0, 1),
                    icon: Icon(Icons.touch_app),
                    iconSize: 15,
                    elevation: 16,
                    style: descriptionTextBoldSmall,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Breads',
                      'Cakes',
                      'Candy & Fudge',
                      'Casseroles',
                      'Cocktails',
                      'Cookies',
                      'Mac & Cheese',
                      'Main Dishes',
                      'Pasta Salads',
                      'Pasta',
                      'Pies',
                      'Pizzas',
                      'Sandwiches',
                      'Sauces & Condiments',
                      'Smoothies',
                      'Soups, Stews, & Chilis',
                      'BBQ & Grilling',
                      'For Kids',
                      'For Two',
                      'Budget Cooking',
                      'Pressure Cooker',
                      'Quick & Easy',
                      'Slow Cooker',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 25,
                    width: 55,
                    child: RaisedButton(
                      onPressed: () {
                        submitCondition(
                            dishTypeToFirebaseDictionary[dropdownValue], true);
                        Navigator.pop(context);
                      },
                      splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                      elevation: 40.0,
                      color: Color.fromRGBO(33, 33, 33, 0.5),
                      child: Text("Add", style: descriptionTextSmall),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white)),
                    ),
                  )
                ]),
          ),
        ]));
  }
}

class IngredientDialog extends StatefulWidget {
  @override
  _IngredientDialogState createState() => _IngredientDialogState();
}

class _IngredientDialogState extends State<IngredientDialog> {
  var ingredientString;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
      elevation: 50.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      content: Stack(children: [
        Positioned(
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                addCondition(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.white)),
          top: 0,
          left: -3,
        ),
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                "Type ingredients below:",
                style: descriptionText,
                textAlign: TextAlign.center,
              ),
              TextField(
                cursorColor: Color.fromRGBO(255, 255, 255, 0.5),
                maxLength: 20,
                style: fieldText,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Enter ingredients seperated by a comma.",
                  hintStyle: hintText,
                ),
                textAlign: TextAlign.center,
                onChanged: (value) => ingredientString = value,
              ),
              SizedBox(height: 10),
              Container(
                height: 25,
                width: 55,
                child: RaisedButton(
                  onPressed: () {
                    submitCondition("ingredient", ingredientString);
                    Navigator.pop(context);
                  },
                  splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                  elevation: 40.0,
                  color: Color.fromRGBO(33, 33, 33, 0.5),
                  child: Text("Add", style: descriptionTextSmall),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
