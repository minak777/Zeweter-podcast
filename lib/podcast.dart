import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zeweter_app/components/ProfilePic.dart';
import 'package:zeweter_app/components/TitleText.dart';
import 'package:zeweter_app/player.dart';

class Podcast extends StatefulWidget {
  final String podcastId;

  const Podcast({required this.podcastId, Key? key}) : super(key: key);

  @override
  State<Podcast> createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  @override
  Widget build(BuildContext context) {
    final episodesCollection = FirebaseFirestore.instance
        .collection('podcasts')
        .doc(widget.podcastId)
        .collection('episodes');

    return Scaffold(
      appBar: AppBar(
        title: Text('Podcast'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: ProfilePic()),
          TitleText(title: 'Episodes'),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: episodesCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No episodes found.'));
                }

                final episodes = snapshot.data!.docs;

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: episodes.length,
                  itemBuilder: (context, index) {
                    try {
                      final episode = episodes[index];
                      final episodeData =
                          episode.data() as Map<String, dynamic>;

                      final title = episodeData['title'] ?? 'No title';
                      final description =
                          episodeData['description'] ?? 'No description';
                      final audioUrl = episodeData['audio'] ?? '';
                      final image = episodeData['image'] ?? 'No image';

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Player(
                                title: title,
                                description: description,
                                audioUrl: audioUrl,
                                image: image,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: image.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10)),
                                        child: Image.network(
                                          image,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        color: Colors.grey,
                                        child: Center(
                                          child: Text(
                                            'No Image',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } catch (e) {
                      return Card(
                        child: Center(
                          child: Text('Error loading episode'),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
