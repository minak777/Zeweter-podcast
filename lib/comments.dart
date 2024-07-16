import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  final String title; // podcastId
  final String description; // episodeId

  CommentSection({
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();
  late String _username;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _username = user.displayName ?? 'Anonymous';
      });
    }
  }

  Future<void> addComment(String podcastId, String episodeId,
      String commentText, String username) async {
    if (commentText.isEmpty) return; // Early exit if comment is empty

    try {
      final commentRef = FirebaseFirestore.instance
          .collection('podcasts')
          .doc(podcastId)
          .collection('episodes')
          .doc(episodeId)
          .collection('comments')
          .doc(); // Automatically generate a unique ID for the new comment

      await commentRef.set({
        'comment': commentText,
        'username': username,
        'timestamp': Timestamp.now(),
      });

      print('Comment added successfully');
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('podcasts')
                  .doc(widget.title) // podcastId
                  .collection('episodes')
                  .doc(widget.description) // episodeId
                  .collection('comments')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No comments yet.'));
                }

                final comments = snapshot.data!.docs;

                return ListView(
                  children: comments.map((comment) {
                    final data = comment.data() as Map<String, dynamic>;
                    final username = data['username'] ?? 'Anonymous';
                    final commentText = data['comment'] ?? '';

                    return ListTile(
                      title: Text(username),
                      subtitle: Text(commentText),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final commentText = _commentController.text;
                    if (commentText.isNotEmpty) {
                      addComment(widget.title, widget.description, commentText,
                          _username);
                      _commentController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
