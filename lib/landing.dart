import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Map<String, String>> _episodes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEpisodes();
  }

  Future<void> _fetchEpisodes() async {
    try {
      QuerySnapshot podcastSnapshot =
          await FirebaseFirestore.instance.collection('podcasts').get();
      List<Map<String, String>> episodes = [];

      for (var doc in podcastSnapshot.docs) {
        CollectionReference episodesRef = doc.reference.collection('episodes');
        QuerySnapshot episodesSnapshot = await episodesRef.get();

        for (var episodeDoc in episodesSnapshot.docs) {
          episodes.add({
            'title': episodeDoc['title'],
            'description': episodeDoc['description'],
            'audio': episodeDoc['audio'],
            'image': episodeDoc['image'],
          });
        }
      }

      setState(() {
        _episodes = episodes;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching episodes: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 50),
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  const HomePage(),
                  SearchPage(episodes: _episodes),
                  const FavPage(),
                  const ProfilePage(),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.search_normal), label: 'Search'),
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
