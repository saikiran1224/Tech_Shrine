import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/screens/authentication/sign_up_screen.dart';
import 'package:flutterfire_samples/screens/authentication/email_verification_screen.dart';
import 'package:flutterfire_samples/screens/main_screens/dashboard_screen.dart';
import 'package:flutterfire_samples/utils/auth_utils.dart';
import 'package:flutterfire_samples/utils/auth_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_ffi/web_ffi.dart';

import '../custom_form_field.dart';

class EPSignInForm extends StatefulWidget {
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const EPSignInForm({
    Key? key,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  }) : super(key: key);
  @override
  _EPSignInFormState createState() => _EPSignInFormState();
}

class _EPSignInFormState extends State<EPSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _signInFormKey = GlobalKey<FormState>();

  bool _isSigningIn = false;



  Future<String> _checkUserAlreadyRegistered(String userEmailID) async {

    String _userDisplayName = "";

    var result = await FirebaseFirestore.instance.collection("students_data")
    .where("emailID",isEqualTo: userEmailID).get();
    
    result.docs.forEach((res) {
        print(res.data()['name']);
        _userDisplayName = res.data()['name'];
        print("User's name: $_userDisplayName");
    });

    return _userDisplayName;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              children: [
                CustomFormField(
                  controller: _emailController,
                  focusNode: widget.emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  validator: (value) => EPValidator.validateEmail(
                    email: value,
                  ),
                  label: 'Email',
                  hint: 'Enter your email',
                ),
                SizedBox(height: 16.0),
                CustomFormField(
                  controller: _passwordController,
                  focusNode: widget.passwordFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => EPValidator.validatePassword(
                    password: value,
                  ),
                  isObscure: true,
                  label: 'Password',
                  hint: 'Enter your password',
                ),
              ],
            ),
          ),
          _isSigningIn
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Palette.firebaseOrange,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Palette.firebaseOrange,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {

                        widget.emailFocusNode.unfocus();
                        widget.passwordFocusNode.unfocus();

                        setState(() {
                          _isSigningIn = true;
                        });

                        // Once the validation of the fields are done it will be sent to check for Authentication
                        if (_signInFormKey.currentState!.validate()) {

                          String userEnteredEmailID = _emailController.text.toString();
                          User? user = await EPAuthentication.signInUsingEmailPassword(context: context, email: _emailController.text, password: _passwordController.text);

                         String userDisplayName =  await _checkUserAlreadyRegistered(userEnteredEmailID);


                          // Checks user is authenticated or not
                          if (user != null) {

                            // Checks whether the userDisplayName is retrieved or not -
                            //   If retrieved - User is already registered so send him to Dashboard Screen by sending his Email ID and Display Name
                            //   else - User will be sent to User Info Screen
                            if(userDisplayName == "") {
                              print("User Display Name: $userDisplayName");
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) =>
                                    EPUserInfoScreen(user: user)),);
                            } else {

                                // initialising Shared Preferences
                                final prefs = await SharedPreferences.getInstance();

                                // setting user Registered
                                await prefs.setBool("userRegisteredStatus", true);

                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardScreen(user: user, userEmailID: _emailController.text.toString(), userDisplayName: userDisplayName as String)));

                            }

                          }
                        }

                        setState(() {
                          _isSigningIn = false;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Palette.firebaseGrey,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(height: 16.0),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => EPRegisterScreen(),
                ),
              );
            },
            child: Text(
              'Don\'t have an account? Sign up',
              style: TextStyle(
                color: Palette.firebaseGrey,
                letterSpacing: 0.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
