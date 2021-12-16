import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/brew.dart';
import 'package:flutter_application_1/models/users.dart';

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

  //userData from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: (snapshot.data() as dynamic)['name'],
        sugars: (snapshot.data() as dynamic)['sugars'],
        strength: (snapshot.data() as dynamic)['strength']);
  }

  // get brews stream
  Stream<List<Brew>>? get brews {
    return firebaseCollection.snapshots().map(_brewListFromSnapShot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return firebaseCollection.doc(uid).snapshots().map(_userDataFromSnapShot);
  }
}
