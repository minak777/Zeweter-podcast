import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/components/ProfilePic.dart';
import 'package:zeweter_app/components/TitleText.dart';
import 'package:zeweter_app/components/gridlist.dart';
import 'package:zeweter_app/components/userpic.dart';
import 'package:zeweter_app/profilepage/ProfilePage.dart';

class Podcast extends StatefulWidget {
  const Podcast({super.key});

  @override
  State<Podcast> createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: ProfilePic()),
            TitleText(title: 'Episodes'),
            GridList(
                imageAsset: 'lib/assets/mic.jpg',
                callback: () {},
                title: 'Episode 1',
                description: 'Eolution of Ethiopian football')
          ],
        ));
  }
}
