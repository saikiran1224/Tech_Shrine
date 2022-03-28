import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/screens/authentication/sign_in_screen.dart';
import 'package:flutterfire_samples/screens/main_screens/circulars_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key,required User user,required String userEmailID, required String userDisplayName}) :
        _userEMailID = userEmailID,
        _userDisplayName = userDisplayName,
        super(key: key);

  final String _userEMailID;
  final String _userDisplayName;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {

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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String name = widget._userDisplayName;
    String emailID = widget._userEMailID;

    return Scaffold(
        backgroundColor: Palette.firebaseNavy,
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.menu, color: Colors.white,size: 50.0,),
                      Image.asset("assets/images/firebase_logo.png",width: 35.0)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Welcome, $name !",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Wrap(
                      spacing:10,
                      runSpacing: 10.0,
                      children: <Widget>[
                        SizedBox(
                          width:160.0,
                          height: 160.0,
                          child: Card(
                            color: Color.fromARGB(255,21, 21, 21),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            child:Center(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CircularsScreen()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset("assets/images/note.png",width: 64.0,),
                                        SizedBox(height: 12.0,),
                                        Text(
                                          "Circulars",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0
                                          ),
                                        ),

                                      ],
                                    ),
                                  )
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          width:160.0,
                          height: 160.0,
                          child: Card(
                            color: Color.fromARGB(255,21, 21, 21),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            child:Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset("assets/images/connect_image.png",width: 64.0,),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Text(
                                        "Connect",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          width:160.0,
                          height: 160.0,
                          child: Card(

                            color: Color.fromARGB(255,21, 21, 21),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            child:Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset("assets/images/calendar.png",width: 64.0,),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Text(
                                        "Calendar",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          width:160.0,
                          height: 160.0,
                          child: Card(
                            color: Color.fromARGB(255,21, 21, 21),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            child:Center(
                                child: InkWell(
                                  onTap: () async {
                                    // Signing out User
                                    await FirebaseAuth.instance.signOut();

                                    // Change the status in Shared Preferences
                                    final prefs = await SharedPreferences.getInstance();

                                    await prefs.setBool("userRegisteredStatus", false);

                                    Navigator.of(context).pushReplacement(_routeToSignInScreen());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset("assets/images/logout_2.png",width: 64.0,),
                                        SizedBox(
                                          height: 12.0,
                                        ),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}
