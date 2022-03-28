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
    required String interests,
    required String shortIntro,
    required String yearOfStudy
  }) async {
    /*DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc();*/

    // We are doing two things
    // First we have created two collections
    // Global Student Data and students based on their Year

    DocumentReference documentReferencer0 = _firestore.collection('students_data').doc(userUid);

    DocumentReference documentReferencer1 = _firestore.collection(yearOfStudy).doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "emailID": emailID,
      "jntuNo" : jntuNo,
      "yearOfStudy": yearOfStudy,
      "interests":interests,
      "shortIntro": shortIntro
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

  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUid).collection('items');

    return notesItemCollection.snapshots();
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
