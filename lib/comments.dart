import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _username = 'Loading...'; // Set default value to 'Loading...'
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final userData =
            await _firestore.collection('users').doc(currentUser.uid).get();
        setState(() {
          _username = userData.get('username') ?? 'Anonymous';
        });
      } else {
        setState(() {
          _username = 'No User';
        });
      }
    } catch (e) {
      print('Failed to load user data: $e');
      setState(() {
        _username = 'Error';
      });
    }
  }

  Future<void> addComment(String podcastId, String episodeId,
      String commentText, String username) async {
    if (commentText.isEmpty) return; // Early exit if comment is empty

    try {
      final commentRef = FirebaseFirestore.instance
          .collection('comments')
          .doc(); // Automatically generate a unique ID for the new comment

      await commentRef.set({
        'podcastId': podcastId,
        'episodeId': episodeId,
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
                  .collection('comments')
                  .where('podcastId', isEqualTo: widget.title) // podcastId
                  .where('episodeId',
                      isEqualTo: widget.description) // episodeId
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
                          _username); // Pass the fetched username
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
