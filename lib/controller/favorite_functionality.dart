import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


initializeFavorites(_auth, _firestore) async {
  final user = await _auth.currentUser();
  String userID = user.uid;
  await for (var snapshot in _firestore.collection('userData').where('userID', isEqualTo: userID).limit(1).snapshots()){
    for (var user in snapshot.documents) {
      return user.data;
    }
  }
}


getUserID () async {
  final _auth = FirebaseAuth.instance;
  final user = await _auth.currentUser();
  return user.uid;
}

getFavoritesData(id) async {
  final _firestore = Firestore.instance;
  await for (var snapshot in _firestore.collection("recipeData").where(
      "ID", isEqualTo: id).limit(1).snapshots()) {
    for (var recipe in snapshot.documents) {
      return recipe.data;
    }
  }
}

getFavorites() async {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final user = await _auth.currentUser();
  String userID = user.uid;
  await for (var snapshot in _firestore.collection("userData").where(
      "userID", isEqualTo: userID).limit(1).snapshots()) {
    for (var user in snapshot.documents) {
      return user.data['favorites'];
    }
  }
}
