import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/screens/authentication/student_details_screen.dart';
import 'package:flutterfire_samples/utils/auth_utils.dart';
import 'package:flutterfire_samples/widgets/app_bar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import 'sign_in_screen.dart';

class EPUserInfoScreen extends StatefulWidget {
  const EPUserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _EPUserInfoScreenState createState() => _EPUserInfoScreenState();
}


class _EPUserInfoScreenState extends State<EPUserInfoScreen> {
  late bool _isEmailVerified;
  late User _user;

  bool _verificationEmailBeingSent = false;
  bool _isSigningOut = false;

  bool _isFinished = false;

  String userProfileUrl = "";

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EPSignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;
    _isEmailVerified = _user.emailVerified;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    //var isFinished = false;

    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Welcome!',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              ClipOval(
                child: Material(
                  color: Palette.firebaseGrey.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person,
                      size: 42,
                      color: Palette.firebaseGrey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Hello',
                style: TextStyle(
                  color: Palette.firebaseGrey,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                widget._user.displayName!,
                style: TextStyle(
                  color: Palette.firebaseYellow,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 24.0),
              _isEmailVerified
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.greenAccent.withOpacity(0.6),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.check,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Email is verified',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 20,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.redAccent.withOpacity(0.8),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Email is not verified',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 40.0),
              Visibility(
                visible: !_isEmailVerified,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _verificationEmailBeingSent
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Palette.firebaseGrey,
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Palette.firebaseGrey,
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                _verificationEmailBeingSent = true;
                              });
                              await _user.sendEmailVerification();
                              setState(() {
                                _verificationEmailBeingSent = false;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                'Verify',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.firebaseNavy,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(width: 16.0),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () async {
                        User? user = await EPAuthentication.refreshUser(_user);

                        if (user != null) {
                          setState(() {
                            _user = user;
                            _isEmailVerified = user.emailVerified;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Visibility(
                  visible: _isEmailVerified,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Congratulations! You are one step ahead to enter into our application',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Palette.firebaseGrey.withOpacity(0.8),
                              fontSize: 14,
                              letterSpacing: 0.2),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      /*ToggleSwitch(
                initialLabelIndex: 0,
                totalSwitches: 3,
                minWidth: 95.0,
                activeBgColor: [Palette.firebaseAmber],
                labels: ["2nd Year", "3rd Year", "4th Year"],
                onToggle: (index){
                  print('Switched to $index');
                },
              ),*/
                      SwipeableButtonView(
                        buttonText: 'SLIDE TO REGISTER',
                        buttonWidget: Container(
                          child: Icon(Icons.arrow_forward_ios_rounded,
                            color: Palette.firebaseNavy,
                          ),),
                        activeColor: Palette.firebaseAmber,
                        onWaitingProcess: () {
                          Future.delayed(Duration(seconds: 2), () {
                            setState(() {
                              _isFinished = true;
                            });
                          });
                        },
                        isFinished: _isFinished,
                        onFinish: () async {
                          await Navigator.push(context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: StudentDetailsScreen(user: _user,userDisplayName: _user.displayName.toString(), userEmailID: _user.email.toString())));

                          //TODO: For reverse ripple effect animation
                          setState(() {
                            _isFinished = false;
                          });
                        },
                      ),
                    ],
                  )),

              SizedBox(height: 120.0),
              _isSigningOut
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.redAccent,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _isSigningOut = true;
                        });
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                          _isSigningOut = false;
                        });
                        Navigator.of(context)
                            .pushReplacement(_routeToSignInScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
