import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zeweter_app/services/firestore.dart';

class Hi_notify extends StatefulWidget {
  const Hi_notify({Key? key}) : super(key: key);

  @override
  State<Hi_notify> createState() => _Hi_notifyState();
}

class _Hi_notifyState extends State<Hi_notify> {
  final FirestoreService _firestoreService = FirestoreService();
  String _username = 'Loading...';
  String _profilePicUrl = '';
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('No user is logged in');
      }

      final userData = await _firestoreService.getUser(userId);
      setState(() {
        _username = userData['username'] ?? 'User';
        _profilePicUrl = userData['profilePicUrl'] ?? '';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print('Failed to fetch user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    // Display profile picture or user icon
                    _isLoading
                        ? CircularProgressIndicator()
                        : _hasError
                            ? Icon(Icons.error, color: Colors.red)
                            : _profilePicUrl.isNotEmpty
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(_profilePicUrl),
                                    radius: 20,
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            255, 20, 87, 141),
                                      ),
                                      color: const Color.fromARGB(
                                          255, 207, 233, 253),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Iconsax.user),
                                      color: const Color.fromARGB(
                                          255, 20, 87, 141),
                                    ),
                                  ),
                    // Display username
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Hi, $_username!',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              // Placeholder for notification icon
            ],
          ),
        ],
      ),
    );
  }
}
