import 'package:flutter/material.dart';
import 'package:zeweter_app/components/ProfilePic.dart';
import 'package:zeweter_app/profilepage/Proflist.dart';
import 'package:zeweter_app/profilepage/editprof.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 70,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ProfilePic(),
            ),
            EditProf(),
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
      ),
    );
  }
}
