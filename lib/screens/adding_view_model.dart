import 'package:calender_app/models/guest.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../database.dart';

class AddingViewModel extends ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'appointments';

  String docId = Uuid().v1();

  Future<void> addNewGuest({
    required String id,
    required String category,
    required int start,
    required int end,
    required String date,
    required String title,
    required String detail,
    required String dateForOrder,
  }) async {
    /// Form alanındaki verileri ile önce bir book objesi oluşturulması
    Guests newGuest = Guests(
      id: id,
      end: end,
      title: title,
      category: category,
      date: date,
      detail: detail,
      start: start,
      dateForOrder: dateForOrder,
      docId: docId,
    );

    /// bu kitap bilgisini database servisi üzerinden Firestore'a yazacak
    await _database.setGuestData(
        collectionPath: collectionPath, guestAsMap: newGuest.toMap());
  }
}
