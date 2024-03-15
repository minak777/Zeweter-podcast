import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Hi_notify extends StatefulWidget {
  const Hi_notify({super.key});

  @override
  State<Hi_notify> createState() => _Hi_notifyState();
}

class _Hi_notifyState extends State<Hi_notify> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 20, 87, 141)),
                    color: const Color.fromARGB(255, 207, 233, 253),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.user),
                      color: const Color.fromARGB(255, 20, 87, 141)),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Hi,user!',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          //notification
          Container(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.notification),
              iconSize: 30,
              color: const Color.fromARGB(255, 20, 87, 141),
            ),
          )
        ],
      ),
    );
  }
}
