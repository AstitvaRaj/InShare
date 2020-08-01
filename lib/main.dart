import 'package:filetransfer/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Transfer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
