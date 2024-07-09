import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeweter_app/podcast.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Favorites',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Material(
                    elevation: 0.5,
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('lib/assets/mic.jpg'),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        child: Text('Unfollow'),
                      ),
                      title: Text('Sportpod'),
                      onTap: () {
                        /* Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Podcast(),
                          ),
                        );*/
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
