import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/widgets/app_bar_title.dart';
import 'package:flutterfire_samples/widgets/database/crud/db_item_list.dart';

import 'db_add_screen.dart';

class DbDashboardScreen extends StatefulWidget {
  @override
  _DbDashboardScreenState createState() => _DbDashboardScreenState();
}

class _DbDashboardScreenState extends State<DbDashboardScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'CRUD',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
/*
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DbAddScreen(),
            ),
          );
*/
        },
        backgroundColor: Palette.firebaseOrange,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: DbItemList(),
        ),
      ),
    );
  }
}
