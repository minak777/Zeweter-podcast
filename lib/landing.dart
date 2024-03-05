import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zeweter_app/AddPage.dart';
import 'package:zeweter_app/Favpage.dart';
import 'package:zeweter_app/homepage/HomePage.dart';
import 'package:zeweter_app/ProfilePage.dart';
import 'package:zeweter_app/Searchpage.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;

  final List<Widget> _bodyWidgets = [
    HomePage(), // Replace with your Home widget
    SearchPage(), // Replace with your Search widget
    AddPage(), // Replace with your Add widget
    FavPage(), // Replace with your Favorites widget
    ProfilePage(), // Replace with your Profile widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 50), // Add padding to the top
        child: _bodyWidgets[_selectedIndex], // Display the selected widget
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.search_normal), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.add_circle,
                size: 45,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.heart), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
