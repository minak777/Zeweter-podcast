import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  late String _userName = '';
  late String _profilePicUrl = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final userData =
            await _firestore.collection('users').doc(currentUser.uid).get();
        setState(() {
          _userName = userData.get('username');
          _profilePicUrl = userData.get('profilePicUrl') ?? '';
        });
      }
    } catch (e) {
      print('Failed to load user data: $e');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final storageRef =
          _storage.ref().child('profile_pics/${_auth.currentUser!.uid}');
      final uploadTask = storageRef.putFile(file);

      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'profilePicUrl': downloadUrl,
      });

      setState(() {
        _profilePicUrl = downloadUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: _pickImage,
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[200],
                  foregroundImage: _profilePicUrl.isNotEmpty
                      ? NetworkImage(_profilePicUrl)
                      : null,
                  child: _profilePicUrl.isEmpty
                      ? Text(
                          _userName.isNotEmpty ? _userName[0] : '',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w900),
                        )
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.add_a_photo, color: Colors.blue),
                  onPressed: _pickImage,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _userName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
