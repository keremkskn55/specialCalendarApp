import 'package:calender_app/models/guest.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  List<Guests>? guests;

  HistoryView({required this.guests});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List orderedGuests = [];

  @override
  void initState() {
    if (widget.guests!.isNotEmpty) {
      for (var guest in widget.guests!) {
        orderedGuests.add(guest);
      }
    }

    orderedGuests.sort((a, b) => b.dateForOrder.compareTo(a.dateForOrder));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3EAED),
      appBar: AppBar(
        title: Text('History Screen'),
        backgroundColor: Color(0xFF00BCD4),
      ),
      body: ListView.builder(
        itemCount: orderedGuests.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${orderedGuests[index].id}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${orderedGuests[index].date}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    'Time: ${orderedGuests[index].start} - ${orderedGuests[index].end}'),
                Divider(
                  height: 10,
                  color: Color(0xFFD3EAED),
                  thickness: 2,
                ),
                Text('Title: ${orderedGuests[index].title}'),
                SizedBox(
                  height: 15,
                ),
                Text('Detail\n${orderedGuests[index].detail}'),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
