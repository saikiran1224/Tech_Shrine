import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';

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
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                bottom: 20.0,
              ),
              child: ListWheelScrollView(
                itemExtent: 200,
                diameterRatio: 2,
                children: [
                Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.greenAccent.withOpacity(0.2), BlendMode.dstATop),
                  child: Center(
                    child:  Image.asset(
                      'assets/images/android_logo.png',
                      height: 80,
                    ),
                  ),

                )
              ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text('Hello 1',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 50.0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text('Hello 2',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 50.0)),
                    ),
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text('Hello 3',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 50.0)),
                    ),
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text('Hello 4 ',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 50.0)),
                    ),
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text('Hello 5',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 50.0)),
                    ),
                  )
                ],
              ))),
    );
  }
}
