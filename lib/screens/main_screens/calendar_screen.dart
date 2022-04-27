import 'package:flutter/material.dart';
import 'package:flutterfire_samples/screens/main_screens/pdfviewer_screen.dart';

import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarTitle(
          sectionName: 'Academic Calendar',
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => PDFViewerScreen(fileName: '2nd Year Academic Calendar',url: 'http://www.gmrit.org/B.Tech_3rd_4th_Semester_Academic_Calendar_2021-22.pdf') ));
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
                                padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                                child: Text(
                                  '2nd Year',
                                  style: TextStyle(color: Palette.firebaseOrange, fontWeight: FontWeight.bold, fontSize: 33.0),
                                ),
                              )
                          ))),
                ), // 2nd Year
                SizedBox(height: 25,),
                InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  PDFViewerScreen(fileName: '3rd Year Academic Calendar',url: 'http://www.gmrit.org/B.Tech%205th%20&%206th%20Semester%20Academic%20Calendar%202021-22.pdf')));
                  },
                  child: Center(
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
                                padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                                child: Text(
                                  '3rd Year',
                                  style: TextStyle(color: Palette.firebaseOrange, fontWeight: FontWeight.bold, fontSize: 33.0),
                                ),
                              ),

                          ))),
                ), // 3rd Year
                SizedBox(height: 25,),
                InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => PDFViewerScreen(fileName: '4th Year Academic Calendar',url: 'http://www.gmrit.org/B.Tech%207th%20&%208th%20Semester%20Academic%20Calendar%202021-22.pdf')));
                  },
                  child: Center(
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
                                child: Text(
                                  '4th Year',
                                  style: TextStyle(color: Palette.firebaseOrange, fontWeight: FontWeight.bold, fontSize: 33.0),
                                ),
                              )
                          )

                      )),
                ), // 4th Year
              ],
            ),
          )),
    );
  }
}
