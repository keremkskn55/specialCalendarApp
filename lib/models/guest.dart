import 'package:flutter/material.dart';

class Guests {
  String category;
  String id;
  int start;
  int end;
  String date;
  String dateForOrder;
  String title;
  String detail;
  String docId;

  Widget block = Container();

  Guests({
    required this.category,
    required this.id,
    required this.date,
    required this.end,
    required this.start,
    required this.detail,
    required this.title,
    required this.dateForOrder,
    required this.docId,
  }) {
    block = Container(
      height: (80 * (end - start)).toDouble(),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFD0ADCB),
            Color(0xFFD0ADCB).withOpacity(0),
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'id: ',
                  style: TextStyle(
                    color: Color(0xFFD3EAED),
                    fontSize: 20,
                  ),
                ),
                Text(
                  id,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.watch_later,
                  color: Color(0xFFD3EAED),
                ),
                Text(' '),
                Text(
                  start > 12 ? '${start % 12}pm-' : '${start}am-',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  end > 12 ? '${end % 12}pm' : '${end}am',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'date': date,
      'end': end,
      'start': start,
      'detail': detail,
      'title': title,
      'dateForOrder': dateForOrder,
      'docId': docId,
    };
  }

  factory Guests.fromMap(Map map) {
    return Guests(
      id: map['id'],
      category: map['category'],
      date: map['date'],
      end: map['end'],
      start: map['start'],
      detail: map['detail'],
      title: map['title'],
      dateForOrder: map['dateForOrder'],
      docId: map['docId'],
    );
  }
}
