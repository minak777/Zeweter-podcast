import 'package:flutter/material.dart';

class UserPic extends StatelessWidget {
  const UserPic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black, // Border color
          width: 2.0, // Border width
        ),
        borderRadius:
            BorderRadius.circular(100), // Adjust border radius as needed
      ),
      padding: EdgeInsets.all(14),
      child: const ImageIcon(
        AssetImage("lib/assets/icons/user.png"),
        color: Colors.black,
        size: 50,
      ),
    );
  }
}
