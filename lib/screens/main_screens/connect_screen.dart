import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/screens/main_screens/circulars_screen.dart';

import '../../widgets/app_bar_title.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();

}

class _ConnectScreenState extends State<ConnectScreen> {

  final _scrollController = FixedExtentScrollController();

  static const double _itemHeight = 60;
  static const int _itemCount = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Choose your Domain',
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                bottom: 20.0,
              ),
              child:,
    );
  }
}


Container(
height: 100,
decoration: BoxDecoration(
color: Palette.flutterLogoBg,
borderRadius: BorderRadius.circular(15)),
child: Center(
child: Image.asset(
'assets/images/flutter_logo.png', height: 100,
),

)
),
