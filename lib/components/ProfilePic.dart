import 'package:flutter/material.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print('tapped');
            },
            borderRadius: BorderRadius.circular(100),
            child: CircleAvatar(
              radius: 80,
              foregroundImage: AssetImage('lib/assets/mic.jpg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Sportpod',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
    );
  }
}
