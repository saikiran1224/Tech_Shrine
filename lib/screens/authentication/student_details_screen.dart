import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/widgets/app_bar_title.dart';

import 'package:flutterfire_samples/widgets/forms/student_details_form.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({Key? key, required User user,required String userDisplayName, required String userEmailID}) :
         _user = user,
        _userDisplayName = userDisplayName,
        _userEmailID = userEmailID,
        super(key: key);

  final String _userDisplayName;
  final String _userEmailID;
  final User _user;

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _jntuFocusNode = FocusNode();
  final FocusNode _interestsFocusNode = FocusNode();
  final FocusNode _shortIntroFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _emailFocusNode.unfocus();
        _jntuFocusNode.unfocus();
        _interestsFocusNode.unfocus();
        _shortIntroFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Register Student',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: DbAddItemForm(
                user: widget._user,
                userDisplayName: widget._userDisplayName,
                userEmailID: widget._userEmailID,
                nameFocusNode: _nameFocusNode,
                emailFocusNode: _emailFocusNode,
                jntuFocusNode: _jntuFocusNode,
                interestsFocusNode: _interestsFocusNode,
                shortIntroFocusNode: _shortIntroFocusNode
            ),
          ),
        ),
      ),
    );
  }
}



/*class DbAddScreen extends StatelessWidget {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _jntuFocusNode = FocusNode();
  final FocusNode _interestsFocusNode = FocusNode();
  final FocusNode _shortIntroFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _emailFocusNode.unfocus();
        _jntuFocusNode.unfocus();
        _interestsFocusNode.unfocus();
        _shortIntroFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Register Student',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: DbAddItemForm(
              nameFocusNode: _nameFocusNode,
              emailFocusNode: _emailFocusNode,
              jntuFocusNode: _jntuFocusNode,
              interestsFocusNode: _interestsFocusNode,
              shortIntroFocusNode: _shortIntroFocusNode
            ),
          ),
        ),
      ),
    );
  }
}*/
