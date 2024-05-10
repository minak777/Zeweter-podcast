import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      // Get the current user's ID from Firebase Authentication
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Retrieve the user's additional data from Firestore based on their ID
        final userData =
            await _firestore.collection('users').doc(currentUser.uid).get();
        setState(() {
          // Update the username
          _userName = userData.get('username');
        });
      }
    } catch (e) {
      print('Failed to load user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print('Tapped on profile picture');
            },
            borderRadius: BorderRadius.circular(100),
            child: CircleAvatar(
              radius: 80,
              foregroundImage: AssetImage(
                  'lib/assets/mic.jpg'), // Add your profile picture image here
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _userName, // Display username or 'Loading...' if not available yet
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
    );
  }
}
