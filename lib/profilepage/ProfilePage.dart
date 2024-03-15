import 'package:flutter/material.dart';
import 'package:zeweter_app/profilepage/ProfilePic.dart';
import 'package:zeweter_app/profilepage/Proflist.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ProfilePic(),
          ProfList(
            plist: 'Edit Profile',
            callback: () {},
          ),
          ProfList(
            plist: 'Subscription',
            callback: () {},
          ),
          ProfList(
            plist: 'Settings',
            callback: () {},
          ),
          ProfList(
            plist: 'Logout',
            callback: () {},
          ),
        ],
      ),
    );
  }
}
