import 'package:calender_app/models/guest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Firestore servisinden kitapların verisini stream olarak alıp sağlamak
  Stream<QuerySnapshot> getGuestListFromApi(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  /// firestore'a yeni veri ekleme ve güncelleme hizmeti
  Future<void> setGuestData(
      {required String collectionPath,
      required Map<String, dynamic> guestAsMap}) async {
    await _firestore
        .collection(collectionPath)
        .doc(Guests.fromMap(guestAsMap).docId)
        .set(guestAsMap);
  }

  /// Firestore üzerindeki bir veriyi silme hizmeti
  Future<void> deleteDocument(
      {required String referecePath, required String docId}) async {
    await _firestore.collection(referecePath).doc(docId).delete();
  }
}
