import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeweter_app/homepage/hi_notify.dart';

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
          //Hi,user and notification
          const Hi_notify(),

          //for you
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
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'lib/assets/mic.jpg',
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                      SizedBox(
                          height: 8), // Add spacing between the image and text
                      Text(
                        'Sportpod',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
