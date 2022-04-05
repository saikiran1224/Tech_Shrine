import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class ViewTechiesScreen extends StatefulWidget {
  const ViewTechiesScreen({Key? key, required String nameOfDomain}) :
        _nameOfDomain = nameOfDomain,
        super(key: key);

  final String _nameOfDomain;

  @override
  State<ViewTechiesScreen> createState() => _ViewTechiesScreenState();
}

class _ViewTechiesScreenState extends State<ViewTechiesScreen> {

  Future<List<Reference>> _loadTechiesData() async {

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: widget._nameOfDomain + " - Techies",
        ),
      ),
      body: ,
    );
  }
}
