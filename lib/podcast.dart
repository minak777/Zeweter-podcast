import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zeweter_app/comments.dart';
import 'package:zeweter_app/player.dart';

class Podcast extends StatefulWidget {
  final String podcastId;

  const Podcast({required this.podcastId, Key? key}) : super(key: key);

  @override
  State<Podcast> createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  bool isFavorite = false;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  late String podcastImage = '';
  late String podcastTitle = '';

  @override
  void initState() {
    super.initState();
    _loadPodcastData();
    _checkIfFavorite();
  }

  Future<void> _loadPodcastData() async {
    final doc = await FirebaseFirestore.instance
        .collection('podcasts')
        .doc(widget.podcastId)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        podcastImage = data['image'] ?? '';
        podcastTitle = data['title'] ?? 'Podcast';
      });
    }
  }

  Future<void> _checkIfFavorite() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(widget.podcastId)
        .get();

    setState(() {
      isFavorite = doc.exists;
    });
  }

  Future<void> _toggleFavorite() async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final podcastRef =
        FirebaseFirestore.instance.collection('podcasts').doc(widget.podcastId);

    if (isFavorite) {
      await userRef.collection('favorites').doc(widget.podcastId).delete();
    } else {
      final podcastDoc = await podcastRef.get();
      if (podcastDoc.exists) {
        final podcastData = podcastDoc.data()!;
        await userRef.collection('favorites').doc(widget.podcastId).set({
          'title': podcastData['title'],
          'image': podcastData['image'],
        });
      }
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Future<void> _incrementViewCount(DocumentSnapshot episode) async {
    final episodeRef = episode.reference;
    final data = episode.data() as Map<String, dynamic>?;

    final currentViewCount =
        data != null && data.containsKey('viewCount') ? data['viewCount'] : 0;

    await episodeRef.update({'viewCount': currentViewCount + 1});
  }

  Future<void> _toggleLike(DocumentSnapshot episode, bool isLiked) async {
    final episodeRef = episode.reference;
    final data = episode.data() as Map<String, dynamic>?;

    List<String> likes = data?['likes']?.cast<String>() ?? [];

    if (isLiked) {
      // Remove like
      likes.remove(userId);
    } else {
      // Add like
      likes.add(userId);
    }

    await episodeRef.update({'likes': likes});
  }

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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25, top: 10),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: podcastImage.isNotEmpty
                        ? NetworkImage(podcastImage)
                        : null,
                    child: podcastImage.isEmpty
                        ? Icon(
                            Icons.podcasts,
                            size: 50,
                          )
                        : null,
                  ),
                  SizedBox(height: 10),
                  Text(
                    podcastTitle,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: Text(
                      'Episodes',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 12),
                    child: ElevatedButton(
                      onPressed: _toggleFavorite,
                      child: Text(isFavorite ? 'Favorite' : 'Add Favorite'),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

                return ListView.builder(
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
                      final viewCount = episodeData['viewCount'] ?? 0;
                      final likes = episodeData['likes']?.cast<String>() ?? [];
                      final likeCount = likes.length;

                      bool isLiked = likes.contains(userId);

                      return GestureDetector(
                        onTap: () async {
                          await _incrementViewCount(episode);
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
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10)),
                                  child: image.isNotEmpty
                                      ? Image.network(
                                          image,
                                          fit: BoxFit.cover,
                                          height: 120,
                                        )
                                      : Container(
                                          color: Colors.grey,
                                          height: 120,
                                          child: Center(
                                            child: Text(
                                              'No Image',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.thumb_up,
                                                  color: isLiked
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                ),
                                                onPressed: () async {
                                                  await _toggleLike(
                                                      episode, isLiked);
                                                },
                                              ),
                                              SizedBox(width: 4),
                                              Text(likeCount.toString()),
                                            ],
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.comment),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) =>
                                                    CommentSection(
                                                  title: title,
                                                  description: description,
                                                ),
                                              );
                                            },
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                size: 20,
                                              ),
                                              SizedBox(width: 4),
                                              Text(viewCount.toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
