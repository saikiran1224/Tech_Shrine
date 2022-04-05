import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/custom_colors.dart';
import '../../utils/db_queries.dart';
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

  final db = FirebaseFirestore.instance;

  Future<List<String>> _loadTechiesData() async {

    List<String> techiesList = [];

    var result = await FirebaseFirestore.instance.collection(widget._nameOfDomain).orderBy("yearOfStudy").get();
    
    result.docs.forEach((res) {
      //techiesList.add(res);
       print("List of Techies in domain of ${widget._nameOfDomain} are: ${res.data()['name']}");
    });

    return techiesList;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: "Meet our Techies in " + widget._nameOfDomain,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: Database.readTechies(widget._nameOfDomain),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              } else if (snapshot.hasData || snapshot.data != null) {
                return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 16.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {

                    var techieDetails = snapshot.data!.docs[index].data() as Map<String, dynamic>;

                    String name = techieDetails['name'];
                    String shortIntro = techieDetails['shortIntro'];
                    String jntuNo = techieDetails['jntuNo'];
                    String phoneNumber = techieDetails['phoneNumber'];
                    String emailID = techieDetails['emailID'];
                    String yearOfStudy = techieDetails['yearOfStudy'];

                    return Center(
                        child: Container(
                            height: 210,
                            decoration: BoxDecoration(
                               border: Border.all(color: Palette.firebaseYellow, width: 1.5),
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
                                color: Palette.firebaseNavy,
                                borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0,5),
                            child: Row(
                             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                SizedBox(width: 15.0),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(name,style: TextStyle(fontSize: 18.0, color: Palette.firebaseYellow, letterSpacing: 0.8, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 3.0,),
                                    Text("@$jntuNo",style: TextStyle(fontSize: 13.0, color: Palette.firebaseAmber),),
                                    SizedBox(height: 10.0,),
                                    Text(shortIntro,style: TextStyle(fontSize: 15.0, overflow: TextOverflow.visible,),maxLines: 3,),
                                    SizedBox(height: 10.0,),
                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                            onPressed: () => launch("tel://+91$phoneNumber"),
                                            icon: Icon(Icons.call),
                                            label: Text('Call'),
                                            style: ElevatedButton.styleFrom(
                                                primary: Palette.firebaseAmber //elevated Button background color
                                            ),),
                                        SizedBox(width: 10.0,),
                                        ElevatedButton.icon(
                                          onPressed: () => launch("mailto:$emailID?subject=[Tech Shrine] Request for Tech Support&body=Hi Techie ,\n\nHappy to meet you!. I am very much eager to learn and develop projects in ${widget._nameOfDomain}. Could you please help me out in learning this domain in your free time. \n\nThanks in Advance."),
                                          icon: Icon(Icons.mail),
                                          label: Text('Mail'),
                                          style: ElevatedButton.styleFrom(
                                              primary: Palette.firebaseOrange //elevated Button background color
                                          ),),
                                      ],
                                    )

                                  ],
                                ))
                              ],
                            ),
                          )));
                  },
                );
              }

              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Palette.firebaseOrange)));
            }),
      ),
    );
  }
}
