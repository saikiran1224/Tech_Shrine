import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';

class CircularsScreen extends StatefulWidget {
  const CircularsScreen({Key? key}) : super(key: key);

  @override
  _CircularsScreenState createState() => _CircularsScreenState();
}

class _CircularsScreenState extends State<CircularsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circulars'),
        elevation: 2,
      ),
      body: Center(
        child: Text('Hello', style: TextStyle(
          color: Palette.firebaseAmber
        ),),
      ),
    );
  }
}
