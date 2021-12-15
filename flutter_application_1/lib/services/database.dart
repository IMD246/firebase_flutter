import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/brew.dart';

class DatabaseSerVice {
  final String uid;
  DatabaseSerVice({required this.uid});
  // collection reference
  final CollectionReference firebaseCollection =
      FirebaseFirestore.instance.collection('firebases');

  Future updateUserData(String sugars, String name, int strength) async {
    return await firebaseCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapShot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Brew(
        name: (doc.data() as dynamic)['name'] ?? '',
        sugars: (doc.data() as dynamic)['sugars'] ?? '',
        strength: (doc.data() as dynamic)['strength'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Brew>>? get brews {
    return firebaseCollection.snapshots().map(_brewListFromSnapShot);
  }
}
