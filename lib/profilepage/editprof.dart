import 'package:flutter/material.dart';
import 'package:zeweter_app/components/input_fields.dart';
import 'package:zeweter_app/profilepage/Proflist.dart';

class EditProf extends StatefulWidget {
  const EditProf({super.key});

  @override
  State<EditProf> createState() => _EditProfState();
}

class _EditProfState extends State<EditProf> {
  TextEditingController UsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProfList(
        plist: 'Edit Profile',
        callback: () {
          _showEditDialog(context);
        });
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InputBox(HintTxt: 'User name', controller: UsernameController),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform save operation here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
