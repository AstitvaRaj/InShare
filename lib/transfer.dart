import 'package:flutter/material.dart';
class trans extends StatefulWidget {
  trans({Key key,this.filepathss}):super(key:key);
  String filepathss = "";
  @override
  _transState createState() => _transState();
}

class _transState extends State<trans> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('transferring'+widget.filepathss),
      ),
    );
  }
}
