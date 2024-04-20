import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zeweter_app/AddPage.dart';
import 'package:zeweter_app/favpages/favpage.dart';
import 'package:zeweter_app/homepage/HomePage.dart';
import 'package:zeweter_app/profilepage/ProfilePage.dart';
import 'package:zeweter_app/Searchpage.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;

  final List<Widget> _bodyWidgets = [
    const HomePage(), // Replace with your Home widget
    const SearchPage(), // Replace with your Search widget
    const AddPage(), // Replace with your Add widget
    const FavPage(), // Replace with your Favorites widget
    const ProfilePage(), // Replace with your Profile widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 50), // Add padding to the top
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
