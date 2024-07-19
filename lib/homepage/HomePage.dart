import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zeweter_app/homepage/hi_notify.dart';
import 'package:zeweter_app/podcast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference podcastsCollection =
      FirebaseFirestore.instance.collection('podcasts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hi, user and notification
          const Hi_notify(),

          // For you
          Container(
            padding: const EdgeInsets.only(left: 25, top: 30),
            child: const Text(
              'For you',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: podcastsCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No podcasts found.'));
                }

                final podcasts = snapshot.data!.docs;

                return GridView.builder(
                  itemCount: podcasts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  ),
                  itemBuilder: (context, index) {
                    try {
                      final podcast = podcasts[index];
                      final podcastData =
                          podcast.data() as Map<String, dynamic>;

                      final podcastId = podcast.id;
                      final imageUrl = podcastData['image'] ?? '';
                      final title = podcastData['title'] ?? 'No title';
                      final description =
                          podcastData['description'] ?? 'No description';

                      return InkWell(
                        onTap: () {
                          // Navigate to the new page with podcastId
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  Podcast(podcastId: podcastId),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: imageUrl.isNotEmpty
                                    ? Image.network(imageUrl, fit: BoxFit.cover)
                                    : Container(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    } catch (e) {
                      return ListTile(
                        title: Text('Error loading podcast'),
                        subtitle: Text(e.toString()),
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
