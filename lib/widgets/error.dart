import 'package:flutter/material.dart';

import '../theme.dart';

// ignore: must_be_immutable
class CustomDialogBox extends StatefulWidget {
  String? message;
  // final String title, descriptions, text;
  // final Image img;

  CustomDialogBox({Key? key, required this.message
      //     required this.title,
      //     required this.descriptions,
      //     required this.text,
      //     required this.img
      })
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: SizedBox(
          height: 100.0,
          width: 200.0,
          // child: Padding(
          //   padding: const EdgeInsets.all(.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Center(
              // child:
              IconButton(
                  iconSize: 14,
                  icon: const Icon(Icons.cancel, color: Colors.red, size: 50),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              //),
              Center(
                  child: Text(
                widget.message!,
                style: const TextStyle(color: Colors.red),
              ))
            ],
          ),
          // ),
        ));
  }
}