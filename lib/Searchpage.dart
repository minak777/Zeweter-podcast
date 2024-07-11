import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zeweter_app/player.dart';

class SearchPage extends StatefulWidget {
  final List<Map<String, String>> episodes;

  const SearchPage({super.key, required this.episodes});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = widget.episodes; // Initially display all episodes
  }

  void _performSearch(String query) {
    final results = widget.episodes.where((episode) {
      final titleLower = episode['title']?.toLowerCase() ?? '';
      final descriptionLower = episode['description']?.toLowerCase() ?? '';
      final queryLower = query.toLowerCase();

      return titleLower.contains(queryLower) ||
          descriptionLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                suffixIcon: const Icon(Iconsax.search_normal),
                hintText: 'Search',
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 187, 187, 187)),
              ),
              onChanged: (query) {
                _performSearch(query);
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final episode = _searchResults[index];
                  return ListTile(
                    title: Text(episode['title'] ?? 'No Title'),
                    subtitle: Text(episode['description'] ?? 'No Description'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Player(
                            title: episode['title'] ?? '',
                            description: episode['description'] ?? '',
                            audioUrl: episode['audio'] ?? '',
                            image: episode['image'] ?? '',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
