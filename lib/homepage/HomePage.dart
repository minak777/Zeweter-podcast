import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeweter_app/homepage/hi_notify.dart';
import 'package:zeweter_app/podcast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hi,user and notification
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
            child: GridView.builder(
              itemCount: 16,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Navigate to the new page
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Podcast(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            'lib/assets/mic.jpg',
                            fit: BoxFit.cover, // Adjust the fit as needed
                          ),
                        ),
                        const SizedBox(
                            height:
                                8), // Add spacing between the image and text
                        const Text(
                          'Sportpod',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Ethiopian premium league review',
                          style: TextStyle(
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
          ),
        ],
      ),
    );
  }
}
