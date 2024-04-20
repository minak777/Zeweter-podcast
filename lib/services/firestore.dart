import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  //get collection
  final CollectionReference userName =
      FirebaseFirestore.instance.collection('UserName');
  //Create new user name
  Future<void> addUserNAme(String Name) {
    return userName.add({'UseName': Name});
  }
}
