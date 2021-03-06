
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/screens/authentication/sign_in_screen.dart';
import 'package:flutterfire_samples/screens/authentication/email_verification_screen.dart';
import 'package:flutterfire_samples/screens/main_screens/dashboard_screen.dart';
import 'package:flutterfire_samples/screens/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    MyApp()
    /*DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),*/
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterFire Samples',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
    // locale: DevicePreview.locale(context), // Comment this
     //builder: DevicePreview.appBuilder, // Comment this
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        fontFamily: 'OpenSans',
      ),
      // home: SignInScreen(),
      home: MyHomePage(), // changed from HomeScreen()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isUserSignedIn = false;
  late User _user;

  bool _isUserRegisteredStatus = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    _user = FirebaseAuth.instance.currentUser!;

    if (_user!=null) {

      // setting the isUserSignedIn value as True since user is already signed in
      _isUserSignedIn = true;

      final prefs = await SharedPreferences.getInstance();

      // setting the User Data
      await prefs.setString("userEmail", _user.email.toString());
      await prefs.setString("userDisplayName",_user.displayName.toString());

    }

    return firebaseApp;
  }

  Future<bool> _checkUserRegisteredStatus() async {

    // initialising Cloud Firestore and checking whether the Name is


    // initialise Shared Preferences
    final prefs = await SharedPreferences.getInstance();

    _isUserRegisteredStatus = prefs.getBool("userRegisteredStatus")!;

    return _isUserRegisteredStatus;
  }

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 3), () {

        if(_isUserSignedIn == true) {

          if(_isUserRegisteredStatus)
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(user: _user,userEmailID: _user.email.toString(), userDisplayName: _user.displayName.toString(),)));
          else
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EPUserInfoScreen(user: _user)));
        }
        else
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
    });

  }


  @override
  Widget build(BuildContext context) {

    return Container(
      color: Palette.firebaseNavy,
      child: Stack(
        children: [
          Padding(
           padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 0.0,
          ),
           child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width:80.0,height: 150.0,),
              Center(
                child: Image(
                  image: AssetImage(
                    'assets/images/tech_shrine_logo.png',
                  ),
                  height: 400.0,
                  width: 300.0,
                ),
              ),
              SizedBox(height: 50.0,),
              FutureBuilder(
                future: _initializeFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    //return Text('Error initializing Firebase');
                  } /*else if (snapshot.connectionState ==
                  ConnectionState.done) {
                return null;
              }*/
                  return  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Palette.firebaseOrange,
                    ),
                  );
                },
              ),
              FutureBuilder(
                  future: _checkUserRegisteredStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      //return Text('Error initializing Firebase');
                    } /*else if (snapshot.connectionState ==
                  ConnectionState.done) {
                return null;
              }*/
                    return  Text('');
                  },)
            ],
          ),
          )
        ],
      )
    );

  }
}
