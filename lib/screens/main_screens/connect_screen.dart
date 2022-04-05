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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CircularsScreen()));
                  },
                  child: Center(
                      child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.lightBlueAccent.withOpacity(.5),
                                  blurRadius: 30.0, // soften the shadow
                                  spreadRadius: 5.0, //extend the shadow
                                  offset: Offset(
                                    5.0, // Move to right 10  horizontally
                                    5.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(25, 30, 40, 30),
                                child: Image.asset('assets/images/flutter_logo.png',
                                    height: 100),
                              )))),
                ), // Flutter
                SizedBox(height: 25,),
                Center(
                    child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.greenAccent.withOpacity(.5),
                                blurRadius: 30.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 10  horizontally
                                  5.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                              child: Image.asset('assets/images/android_logo.png',
                                  height: 100),
                            )))), // Android
                SizedBox(height: 25,),
                Center(
                    child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                blurRadius: 30.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 10  horizontally
                                  5.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                              child: Image.asset('assets/images/mern_logo.png',
                                  height: 100),
                            )))), // MERN Stack
                SizedBox(height: 25,),
                Center(
                    child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orangeAccent.withOpacity(.5),
                                blurRadius: 30.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 10  horizontally
                                  5.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
                              child: Image.asset('assets/images/html_css_js_logo.png',
                                  height: 100),
                            )))), // HTML, CSS and JS
                SizedBox(height: 25,),
                Center(
                    child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pinkAccent.withOpacity(.5),
                                blurRadius: 30.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 10  horizontally
                                  5.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Image.asset('assets/images/ml_logo.png',
                                  height: 100),
                            )))), // Machine Learning
                SizedBox(height: 25,),
                Center(
                    child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(.5),
                                blurRadius: 30.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 10  horizontally
                                  5.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Image.asset('assets/images/data_science_logo.png',
                                  height: 100),
                            )))), // Data Science
              ],
            ),
          )),
    );
  }
}
