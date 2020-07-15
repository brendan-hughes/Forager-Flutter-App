import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forageralpha/controller/formatting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

initializeAnalyzer(_auth, _firestore) async {
  final user = await _auth.currentUser();
  String userID = user.uid;
  String sessionID = userID + "-" + "a-" + DateTime.now().toString();
  _firestore.collection('analyzerQueryData').document(sessionID).setData({
    'sessionStartTime': DateTime.now(),
    'sessionEndTime': null,
    'userID': userID,
    'sessionID': sessionID,
    'active': true,
    'submitted': false,
    'vegan': false,
    'vegetarian': false,
    'ketogenic': false,
    'paleo': false,
    'lowSalt': false,
    'lowSugar': false,
    'dairyFree': false,
    'glutenFree': false,
    'eggFree':false,
    'fishFree':false,
    'fodmapFree':false,
    'balanced':false,
    'highFiber':false,
    'highProtein':false,
    'kidneyFriendly':false,
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
    'wheatFree':false,
    'food' : [],
    'measurements' : []
  });

  _firestore.collection('userData').document(userID).updateData({
    'currentAnalyzerSessionID': sessionID,
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

submitAnalyzer(analyzerSessionID,userData,_firestore) {
  _firestore.collection('analyzerQueryData').document(analyzerSessionID).updateData({
    'sessionSubmittedTime': DateTime.now(),
    'submitted': true,
    'vegan': userData['vegan'],
    'vegetarian': userData['vegetarian'],
    'ketogenic': userData['ketogenic'],
    'paleo': userData['paleo'],
    'lowSalt': userData['lowSalt'],
    'lowSugar': userData['lowSugar'],
    'dairyFree': userData['dairyFree'],
    'glutenFree': userData['glutenFree'],
    'eggFree':userData['eggFree'],
    'fishFree':userData['fishFree'],
    'fodmapFree':userData['fodmapFree'],
    'balanced':userData['balanced'],
    'highFiber':userData['highFiber'],
    'highProtein':userData['highProtein'],
    'kidneyFriendly':userData['kidneyFriendly'],
    'lowCarb':userData['lowCarb'],
    'lowFat':userData['lowFat'],
    'pescatarian':userData['pescatarian'],
    'peanutFree':userData['peanutFree'],
    'porkFree':userData['porkFree'],
    'redMeatFree':userData['redMeatFree'],
    'sesameFree':userData['sesameFree'],
    'shellfishFree':userData['shellfishFree'],
    'soyFree':userData['soyFree'],
    'treenutFree':userData['treenutFre'],
    'wheatFree':userData['wheatFree'],
    'dailyCalories': userData['dailyCalories'],
    'activityLevel': userData['activityLevel'],
  });
}

endAnalyzerSession (_firestore,analyzerSessionID, context) {
  _firestore.collection('analyzerQueryData').document(analyzerSessionID).updateData({
'sessionEndTime': DateTime.now(),
'active': false,
});
  Navigator.pop(context);
}

addFood(userMeasurementString,dropdownValue,userFoodString) async {

  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  String analyzerSessionID = await _firestore
      .collection('userData')
      .document(userID)
      .get()
      .then((value) {
    return value.data['currentAnalyzerSessionID'];
  });

  List foodData = await _firestore
      .collection('analyzerQueryData')
      .document(analyzerSessionID)
      .get()
      .then((value) {
    return value.data['food'];
  });

  List measurementsData = await _firestore
      .collection('analyzerQueryData')
      .document(analyzerSessionID)
      .get()
      .then((value) {
    return value.data['measurements'];
  });
  foodData.add(userFoodString);
  measurementsData.add(userMeasurementString+" "+dropdownValue.toLowerCase());
  List updatedFoodList = foodData;
  List updatedMeasurementsList = measurementsData;

  _firestore.collection('analyzerQueryData').document(analyzerSessionID).updateData({
    'food' : updatedFoodList,
    'measurements' : updatedMeasurementsList,
  });
}

removeFood(analyzerSessionID,_firestore,index) async {

  List foodData = await _firestore
      .collection('analyzerQueryData')
      .document(analyzerSessionID)
      .get()
      .then((value) {
    return value.data['food'];
  });

  List measurementsData = await _firestore
      .collection('analyzerQueryData')
      .document(analyzerSessionID)
      .get()
      .then((value) {
    return value.data['measurements'];
  });
  foodData.removeAt(index);
  measurementsData.removeAt(index);
  List updatedFoodList = foodData;

  List updatedMeasurementsList = measurementsData;


  _firestore.collection('analyzerQueryData').document(analyzerSessionID).updateData({
    'food' : updatedFoodList,
    'measurements' : updatedMeasurementsList,
  });

}

openFoodDialog (context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddFoodDialog();
      });
}


class AddFoodDialog extends StatefulWidget {
  @override
  _AddFoodDialogState createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<AddFoodDialog> {
  String userMeasurementString;
  String userFoodString;
  String dropdownValue = "Cups";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        elevation: 50.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Stack(children: [
          Container(
            height:150
          ),
          Positioned(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
            top: 5,
            left: -3,
          ),
          Positioned(
            child: Container(
              width:30,
              height:50,
              child: TextField(
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
                  hintText: "2",
                  hintStyle: hintText,
                ),
                textAlign: TextAlign.center,
                onChanged: (value) => userMeasurementString = value,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
              ),
            ),
            top: 40,
            left: 10,
          ),
          Positioned(
            child: Container(
              height:50,
              width:85,
              child: DropdownButton(
                value: dropdownValue,
                dropdownColor: Color.fromRGBO(0, 0, 0, 1),
                icon: Icon(Icons.touch_app),
                iconSize: 14,
                elevation: 16,
                style: descriptionTextBoldSmall,
                onChanged: (var newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>[
                  "Cups",
                  "Gallons",
                  "Grams",
                  "Kilograms",
                  "Milliliters",
                  "Litres",
                  "Ounces",
                  "Pieces",
                  "Quarts",
                  "Tablespoons",
                  "Teaspoons",
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            top: 29,
            left: 45,
          ),
          Positioned(
            child: Container(width: 30,child: Text("of", style: descriptionTextSmall)),
            top: 47,
            left: 135,
          ),
          Positioned(
            child: Container(
              width:80,
              height: 50,
              child: TextField(
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
                  hintText: "papaya",
                  hintStyle: hintText,
                ),
                textAlign: TextAlign.center,
                onChanged: (value) => userFoodString = value,
                keyboardType: TextInputType.text,
              ),
            ),
            top: 40,
            left: 150,
          ),
          Positioned(
            child: Container(
                width: 60,
                child: RaisedButton(
                  onPressed: () {
                    addFood(userMeasurementString,dropdownValue,userFoodString);
                    Navigator.pop(context);
                  },
                  splashColor: Color.fromRGBO(255, 255, 255, 0.1),
                  elevation: 40.0,
                  color: Color.fromRGBO(33, 33, 33, 0.5),
                  child: Text("Add",
                      style: descriptionTextSmall),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.white)),
                )),
            top: 100,
            left: 85,
          ),




        ]));

  }
}