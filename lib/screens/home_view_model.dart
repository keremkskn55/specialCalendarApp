import 'package:calender_app/database.dart';
import 'package:calender_app/models/guest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String _collectionPath = 'appointments';

  Database _database = Database();

  Stream<List<Guests>> getGuestList() {
    /// stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getGuestListFromApi(_collectionPath)
        .map((querySnapshot) => querySnapshot.docs);

    ///Stream<List<DocumentSnapshot>> --> Stream<List<Book>>
    Stream<List<Guests>> streamListBook = streamListDocument.map(
        (listOfDocSnap) => listOfDocSnap
            .map((docSnap) => Guests.fromMap(docSnap.data() as Map))
            .toList());

    return streamListBook;
  }

  Future<void> deleteGuest(String guestDocId) async {
    await _database.deleteDocument(
        referecePath: _collectionPath, docId: guestDocId);
  }
}
