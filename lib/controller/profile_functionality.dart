import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


initializeProfile(_auth, _firestore) async {
  final user = await _auth.currentUser();
  String userID = user.uid;
   await for (var snapshot in _firestore.collection('userData').where('userID', isEqualTo: userID).limit(1).snapshots()){
     for (var user in snapshot.documents) {
       return user.data;
     }
   }
}

saveProfile(
    _auth,
    context,
    heightCM,
    heightIN,
    heightValue,
    weightKG,
    weightLB,
    weightValue,
    birthDate,
    male,
    female,
    vegetarian,
    vegan,
    ketogenic,
    paleo,
    lowSalt,
    dairyFree,
    lowSugar,
    glutenFree,
    eggFree,
    fishFree,
    lowFODMAP,
    highFiber,
    highProtein,
    diabeticFriendly,
    lowCarb,
    lowFat,
    cleanEating,
    balanced,
    peanutFree,
    porkFree,
    redMeatFree,
    sesameFree,
    shellfishFree,
    soyFree,
    treenutFree,
    heartHealthy,
    activityLevel
    ) async {
  final user = await _auth.currentUser();
  String userID = user.uid;
  double dailyCalories;
  double age = (DateTime.now().difference(DateFormat('M/d/yyyy').parse(birthDate)).inDays / 365);
  if (heightIN) {
    heightValue = heightValue * 2.54;
  }
  if (weightLB) {
    weightValue = weightValue * 0.453592;
  }
  if (male == true) {
    dailyCalories = (66.4730 + (13.7516 * weightValue) + (5.0033 * heightValue) - (6.7550 * age)) * activityLevel;
  }
  if (female == true) {
    dailyCalories = (655.0955 + (9.5634 * weightValue) + (1.8496 * heightValue) - (4.6756 * age)) * activityLevel;
  }
  Firestore.instance.collection('userData').document(userID).updateData({
    'heightCM': heightCM,
    'heightIN': heightIN,
    'heightValue': heightValue,
    'weightKG': weightKG,
    'weightLB': weightLB,
    'weightValue': weightValue,
    'birthDate': birthDate,
    'male': male,
    'female': female,
    'vegetarian': vegetarian,
    'vegan': vegan,
    'ketogenic': ketogenic,
    'paleo': paleo,
    'lowSalt': lowSalt,
    'dairyFree': dairyFree,
    'lowSugar': lowSugar,
    'glutenFree': glutenFree,
    'eggFree':eggFree,
    'fishFree':fishFree,
    'lowFODMAP':lowFODMAP,
    'balanced':balanced,
    'highFiber':highFiber,
    'highProtein':highProtein,
    'diabeticFriendly':diabeticFriendly,
    'lowCarb':lowCarb,
    'lowFat':lowFat,
    'cleanEating':cleanEating,
    'peanutFree':peanutFree,
    'porkFree':porkFree,
    'redMeatFree':redMeatFree,
    'sesameFree':sesameFree,
    'shellfishFree':shellfishFree,
    'soyFree':soyFree,
    'treenutFree':treenutFree,
    'heartHealthy':heartHealthy,
    'activityLevel':activityLevel,
    'dailyCalories':dailyCalories,
    'creationDate': DateTime.now(),
    'ageInYears':age,
  });
  Navigator.popAndPushNamed(context, '/main');
}