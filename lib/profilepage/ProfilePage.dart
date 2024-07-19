import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import 'package:zeweter_app/components/ProfilePic.dart';
import 'package:zeweter_app/profilepage/Proflist.dart';
import 'package:zeweter_app/profilepage/editprof.dart';
// Import the new page

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    GoRouter.of(context).go('/login');
  }

  void _showSettingsDrawer() {
    // Dismiss any existing bottom sheets or dialogs
    Navigator.of(context).popUntil((route) => route.isFirst);

    // Show the settings drawer with a delete account option
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  'Delete Account',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  // Navigate to authentication page before deleting account
                  GoRouter.of(context).go('/AuthConfirmPage');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 70,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ProfilePic(),
            ),
            ProfList(
              plist: 'Settings',
              callback: _showSettingsDrawer,
            ),
            ProfList(
              plist: 'Logout',
              callback: _logout,
            ),
          ],
        ),
      ),
    );
  }
}
