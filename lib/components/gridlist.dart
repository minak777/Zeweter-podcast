import 'package:flutter/material.dart';
import 'package:zeweter_app/podcast.dart';

class GridList extends StatefulWidget {
  final String imageAsset;
  final String title;
  final String description;
  final Function() callback; // Changed to Function()

  const GridList({
    super.key, // Added Key key parameter
    required this.imageAsset,
    required this.callback,
    required this.title,
    required this.description,
  }); // Added super(key: key)

  @override
  State<GridList> createState() => _GridListState();
}

class _GridListState extends State<GridList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 16,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              widget.callback(); // Using the callback function
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      widget.imageAsset,
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                  ),
                  const SizedBox(
                      height: 8), // Add spacing between the image and text
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    maxLines: 1, // Set maximum number of lines
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
