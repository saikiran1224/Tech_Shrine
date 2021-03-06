import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('students_data');

class Database {
  static String? userUid;

  static Future<void> addItem({
    required String name,
    required String emailID,
    required String jntuNo,
    required String phoneNumber,
    required String shortIntro,
    required String yearOfStudy,
    required String majorDomain
  }) async {
    /*DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc();*/

    // We are doing two things
    // First we have created two collections
    // Global Student Data and students based on their Year

    DocumentReference documentReferencer0 = _firestore.collection('students_data').doc(userUid);

    DocumentReference documentReferencer1 = _firestore.collection(yearOfStudy).doc(userUid);

    DocumentReference documentReferencer2 = _firestore.collection(majorDomain).doc(userUid);


    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "emailID": emailID,
      "jntuNo" : jntuNo,
      "yearOfStudy": yearOfStudy,
      "phoneNumber":phoneNumber,
      "shortIntro": shortIntro,
      "majorDomain":majorDomain
    };

    // passing first document
    await documentReferencer0
        .set(data)
        .whenComplete(() => print("Student successfully added to the database"))
        .catchError((e) => print(e));

    // passing second document
    await documentReferencer1
        .set(data)
        .whenComplete(() => print("Student successfully added to the database"))
        .catchError((e) => print(e));

    // passing third document
    await documentReferencer2
        .set(data)
        .whenComplete(() => print("Student successfully added to the domain"))
        .catchError((e) => print(e));


  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Future<void> listAllFiles() async {
    ListResult result = await FirebaseStorage.instance.ref().listAll();

    result.items.forEach((Reference ref) {
      print('Found file: $ref');
    });

    result.prefixes.forEach((Reference ref) {
      print('Found directory: $ref');
    });

  }

  static Stream<QuerySnapshot> readTechies(String nameOfDomain) {
    var techiesCollection = FirebaseFirestore.instance.collection(nameOfDomain).orderBy("yearOfStudy");
    return techiesCollection.snapshots();
  }



  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
