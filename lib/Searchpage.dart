import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
      child: TextField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color:
                  Colors.grey, // You can specify the color of the border here
            ),
          ),
          suffixIcon: const Icon(Iconsax.search_normal),
          hintText: 'Search',
          hintStyle: const TextStyle(color: Color.fromARGB(255, 187, 187, 187)),
        ),
      ),
    );
  }
}
