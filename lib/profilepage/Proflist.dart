import 'package:flutter/material.dart';

class ProfList extends StatelessWidget {
  final String plist;
  final Function() callback;

  const ProfList({
    Key? key,
    required this.plist,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Material(
        elevation: 0.5,
        child: ListTile(
          onTap: callback,
          leading: Text(
            plist,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
