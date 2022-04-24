import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/screens/main_screens/dashboard_screen.dart';
import 'package:flutterfire_samples/utils/db_queries.dart';
import 'package:flutterfire_samples/screens/main_screens/pdfviewer_screen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../widgets/app_bar_title.dart';

class CircularsScreen extends StatefulWidget {
  const CircularsScreen({Key? key}) : super(key: key);

  @override
  _CircularsScreenState createState() => _CircularsScreenState();
}

class _CircularsScreenState extends State<CircularsScreen> {

  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = FirebaseStorage.instance.ref("circulars");
  List<Reference> files = [];

  Future<List<Reference>> _loadAllCirculars() async {
    ListResult result = await ref.listAll();

    result.items.forEach((Reference ref) {
      // Adding the list of all the files available
      files.add(ref);
      print('Found file: $ref');
    });

    result.prefixes.forEach((Reference ref) {
      print('Found directory: $ref');
    });
    return files;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Circulars',
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 20.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: _loadAllCirculars(),
                    builder: (BuildContext context, AsyncSnapshot<List<Reference>> snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context,index) {
                              final Reference ref = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Card(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    leading: Image.asset("assets/images/pdf_image.png", width: 60.0,),
                                    dense: false,
                                    textColor: Colors.green,
                                    title: Text(ref.name.toString()),
                                    onTap: () async {
                                      String downloadUrl = "";
                                      ref.getDownloadURL().then((value) {
                                        print("Downloaded $value");
                                        downloadUrl = value;
                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                            PDFViewerScreen(fileName: ref.name.toString(),url: downloadUrl)));
                                        print(downloadUrl);
                                      });

                                      // print(downloadUrl);
                                      //await SfPdfViewer.network(downloadUrl);
                                      //print(ref.getDownloadURL().toString() + " Download URL: " + downloadUrl);
                                    },
                                  ),
                                ),

                              );
                            });
                      }

                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Palette.firebaseOrange,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )
        ),
      ),
    );


  }
}
