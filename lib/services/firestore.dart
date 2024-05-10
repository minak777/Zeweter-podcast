import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(Map<String, dynamic> userData) async {
    await _firestore.collection('users').doc(userData['userId']).set(userData);
  }

  Future<Map<String, dynamic>> getUser(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(userId).get();

    return snapshot.data()!;
  }
}
