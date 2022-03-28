import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/widgets/forms/sign_in_form.dart';
import 'email_verification_screen.dart';

class EPSignInScreen extends StatefulWidget {
  @override
  _EPSignInScreenState createState() => _EPSignInScreenState();
}

class _EPSignInScreenState extends State<EPSignInScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => EPUserInfoScreen(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 20.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Image.asset(
                              'assets/images/firebase_logo.png',
                              height: 160,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Tech Shrine',
                            style: TextStyle(
                              color: Palette.firebaseYellow,
                              fontSize: 40,
                            ),
                          ),
                          Text(
                            'Hearty Welcome!',
                            style: TextStyle(
                              color: Palette.firebaseOrange,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: _initializeFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error initializing Firebase');
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return EPSignInForm(
                            emailFocusNode: _emailFocusNode,
                            passwordFocusNode: _passwordFocusNode,
                          );
                        }
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Palette.firebaseOrange,
                          ),
                        );
                      },
                    )
                    // SignInForm(
                    //   emailFocusNode: _emailFocusNode,
                    //   passwordFocusNode: _passwordFocusNode,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
