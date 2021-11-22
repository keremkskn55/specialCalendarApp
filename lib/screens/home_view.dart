import 'package:calender_app/models/guest.dart';
import 'package:calender_app/screens/adding_view.dart';
import 'package:calender_app/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../database.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  Size size;
  HomeView({required this.size});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Guests>? guests;

  List allUserAOnSelectedDate = [];
  List allUserBOnSelectedDate = [];

  List UserABlocks = [];
  List UserBBlocks = [];

  List<Widget> newUserABlocks = [];
  List<Widget> newUserBBlocks = [];

  String todayStr = '';

  void chooseUsers(BuildContext context) {
    allUserAOnSelectedDate = [];
    allUserBOnSelectedDate = [];
    for (Guests guest in guests!) {
      if (guest.date == todayStr) {
        if (guest.category == 'User A') {
          allUserAOnSelectedDate.add(guest);
        } else {
          allUserBOnSelectedDate.add(guest);
        }
      }
    }
  }

  void creatingBlocks(BuildContext context, Size size) {
    for (int i = 0; i < allUserAOnSelectedDate.length; i++) {
      for (int i = 0; i < allUserAOnSelectedDate.length - 1; i++) {
        if (allUserAOnSelectedDate[i].start >
            allUserAOnSelectedDate[i + 1].start) {
          var temp = allUserAOnSelectedDate[i];
          allUserAOnSelectedDate[i] = allUserAOnSelectedDate[i + 1];
          allUserAOnSelectedDate[i + 1] = temp;
        }
      }
    }

    for (int i = 0; i < allUserBOnSelectedDate.length; i++) {
      for (int i = 0; i < allUserBOnSelectedDate.length - 1; i++) {
        if (allUserBOnSelectedDate[i].start >
            allUserBOnSelectedDate[i + 1].start) {
          var temp = allUserBOnSelectedDate[i];
          allUserBOnSelectedDate[i] = allUserBOnSelectedDate[i + 1];
          allUserBOnSelectedDate[i + 1] = temp;
        }
      }
    }

    newUserABlocks = [];
    newUserBBlocks = [];

    int indexOfBlock = 0;
    int heightOfSpaceBlock = 0;
    int subtractForSpaceContainer = 0;
    for (int i = 8; i <= 17; i++) {
      if (indexOfBlock != allUserAOnSelectedDate.length) {
        if (allUserAOnSelectedDate[indexOfBlock].start == i) {
          SizedBox tempSizedBox = SizedBox(
              height: (heightOfSpaceBlock - subtractForSpaceContainer) * 80);
          newUserABlocks.add(tempSizedBox);

          var currentGuestA = allUserAOnSelectedDate[indexOfBlock];

          GestureDetector bottomSheetGestureDeA = GestureDetector(
            onTap: () {
              print('gesturededectorrr..');
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      width: size.width,
                      height: size.height / 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFD0ADCB),
                            Color(0xFFD3EAED),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          /// User and Back Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD3EAED),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  currentGuestA.category,
                                  style: TextStyle(
                                    color: Color(0xFF8F8F8F),
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFFD3EAED),
                                        Color(0xFFD1AFCD),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        offset: Offset(-3, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Stack(
                              children: [
                                Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 54,
                                      ),
                                      Text(
                                        currentGuestA.id,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        offset: Offset(4, 0),
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Stack(
                              children: [
                                Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 54,
                                      ),
                                      Text(
                                        '${currentGuestA.start}-${currentGuestA.end}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        offset: Offset(4, 0),
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.watch_later,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Stack(
                              children: [
                                Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 54,
                                      ),
                                      Text(
                                        currentGuestA.title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        offset: Offset(4, 0),
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.exit_to_app,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: size.height / 2 - 204,
                                width: size.width - 48,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD3EAED),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        currentGuestA.detail,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  print('delete');
                                  await Database().deleteDocument(
                                      referecePath: 'appointments',
                                      docId: currentGuestA.docId);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          offset: Offset(0, -4),
                                        ),
                                      ]),
                                  child: Center(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: currentGuestA.block,
          );

          newUserABlocks.add(bottomSheetGestureDeA);
          heightOfSpaceBlock = 0;
          subtractForSpaceContainer = allUserAOnSelectedDate[indexOfBlock].end -
              allUserAOnSelectedDate[indexOfBlock].start -
              1;
          indexOfBlock++;
          print('HelloHello');
          continue;
        }
      }
      heightOfSpaceBlock++;
      print('indexOfBlockA: $indexOfBlock');
      print('heightOfSpaceBlockA: $heightOfSpaceBlock');
    }

    indexOfBlock = 0;
    heightOfSpaceBlock = 0;
    subtractForSpaceContainer = 0;
    for (int i = 8; i <= 17; i++) {
      if (indexOfBlock != allUserBOnSelectedDate.length) {
        if (allUserBOnSelectedDate[indexOfBlock].start == i) {
          print('number of block B');
          SizedBox tempSizedBox = SizedBox(
              height: (heightOfSpaceBlock - subtractForSpaceContainer) * 80);
          newUserBBlocks.add(tempSizedBox);

          var currentGuestB = allUserBOnSelectedDate[indexOfBlock];

          GestureDetector bottomSheetGestureDeB = GestureDetector(
            onTap: () {
              print('gesturededectorrr..');
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      width: size.width,
                      height: size.height / 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFD0ADCB),
                            Color(0xFFD3EAED),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          /// User and Back Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD3EAED),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  currentGuestB.category,
                                  style: TextStyle(
                                    color: Color(0xFF8F8F8F),
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFFD3EAED),
                                        Color(0xFFD1AFCD),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        offset: Offset(-3, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Stack(
                              children: [
                                Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 54,
                                      ),
                                      Text(
                                        currentGuestB.id,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        offset: Offset(4, 0),
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Stack(
                              children: [
                                Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 54,
                                      ),
                                      Text(
                                        '${currentGuestB.start}-${currentGuestB.end}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        offset: Offset(4, 0),
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.watch_later,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Stack(
                              children: [
                                Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 54,
                                      ),
                                      Text(
                                        currentGuestB.title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD3EAED),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        offset: Offset(4, 0),
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.exit_to_app,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: size.height / 2 - 204,
                                width: size.width - 48,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD3EAED),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        currentGuestB.detail,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  print('delete');
                                  await Database().deleteDocument(
                                      referecePath: 'appointments',
                                      docId: currentGuestB.docId);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          offset: Offset(0, -4),
                                        ),
                                      ]),
                                  child: Center(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: currentGuestB.block,
          );

          newUserBBlocks.add(bottomSheetGestureDeB);
          heightOfSpaceBlock = 0;
          subtractForSpaceContainer = allUserBOnSelectedDate[indexOfBlock].end -
              allUserBOnSelectedDate[indexOfBlock].start -
              1;
          indexOfBlock++;
          print('HelloHello');
          continue;
        }
      }
      heightOfSpaceBlock++;
      print('indexOfBlock $indexOfBlock');
      print('heightOfSpaceBlock $heightOfSpaceBlock');
    }
  }

  @override
  void initState() {
    // int daysInMonth =
    //     DateTimeRange(start: date, end: DateTime(date.year, date.month + 1))
    //         .duration
    //         .inDays;

    DateTime nowTime = DateTime.now();
    todayStr = DateFormat('dd.MM.y').format(nowTime);
    print('Today is $todayStr');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      builder: (context, child) => StreamBuilder<List<Guests>>(
          stream: Provider.of<HomeViewModel>(context).getGuestList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('There is an error...'),
              );
            } else {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Guests> snapGuests = snapshot.data!;
                guests = snapGuests;
                chooseUsers(context);
                creatingBlocks(context, size);

                return SafeArea(
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('$todayStr'),
                      backgroundColor: Color(0xFF00BCD4),
                      actions: [
                        IconButton(
                          icon: Icon(
                            Icons.watch_later,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HistoryView(guests: guests)));
                          },
                        ),
                      ],
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddingView(
                                      allUserData: guests,
                                    )));
                      },
                      backgroundColor: Color(0xFF00BCD4),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Color(0xFFD3EAED),
                    body: Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          height: 30,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    'User A',
                                    style: TextStyle(
                                        color: Color(0xFF8F8F8F), fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    'User B',
                                    style: TextStyle(
                                        color: Color(0xFF8F8F8F), fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            width: size.width - 32,
                            child: Divider(
                              height: 30,
                              color: Colors.white,
                              thickness: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Time Part
                                Expanded(
                                  child: Column(
                                    children: [
                                      timeColumn('8 am', size),
                                      timeColumn('9 am', size),
                                      timeColumn('10 am', size),
                                      timeColumn('11 am', size),
                                      timeColumn('12 am', size),
                                      timeColumn('1 pm', size),
                                      timeColumn('2 pm', size),
                                      timeColumn('3 pm', size),
                                      timeColumn('4 pm', size),
                                      timeColumn('5 pm', size),
                                    ],
                                  ),
                                ),

                                /// User A
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: newUserABlocks,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: newUserBBlocks,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Stack(
                    //   children: [
                    //
                    //     /// Name Of User A, User B
                    //     Positioned(
                    //       top: 200,
                    //       child: SizedBox(
                    //         width: size.width,
                    //         height: 30,
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.end,
                    //           children: [
                    //             Expanded(child: Container()),
                    //             Expanded(
                    //               flex: 2,
                    //               child: Center(
                    //                 child: Text(
                    //                   'User A',
                    //                   style: TextStyle(
                    //                       color: Color(0xFF8F8F8F),
                    //                       fontSize: 20),
                    //                 ),
                    //               ),
                    //             ),
                    //             Expanded(
                    //               flex: 2,
                    //               child: Center(
                    //                 child: Text(
                    //                   'User B',
                    //                   style: TextStyle(
                    //                       color: Color(0xFF8F8F8F),
                    //                       fontSize: 20),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //
                    //     /// Divider
                    //     Positioned(
                    //       top: 230,
                    //       child: Padding(
                    //         padding:
                    //             const EdgeInsets.symmetric(horizontal: 16.0),
                    //         child: SizedBox(
                    //           width: size.width - 32,
                    //           child: Divider(
                    //             height: 30,
                    //             color: Colors.white,
                    //             thickness: 2,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //
                    //     /// Calendar Part
                    //     Positioned(
                    //       top: 260,
                    //       child: SizedBox(
                    //         width: size.width,
                    //         height: size.height - 260,
                    //         child: SingleChildScrollView(
                    //           scrollDirection: Axis.vertical,
                    //           child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               /// Time Part
                    //               Expanded(
                    //                 child: Column(
                    //                   children: [
                    //                     timeColumn('8 am', size),
                    //                     timeColumn('9 am', size),
                    //                     timeColumn('10 am', size),
                    //                     timeColumn('11 am', size),
                    //                     timeColumn('12 am', size),
                    //                     timeColumn('1 pm', size),
                    //                     timeColumn('2 pm', size),
                    //                     timeColumn('3 pm', size),
                    //                     timeColumn('4 pm', size),
                    //                     timeColumn('5 pm', size),
                    //                   ],
                    //                 ),
                    //               ),
                    //
                    //               /// User A
                    //               Expanded(
                    //                 flex: 2,
                    //                 child: Column(
                    //                   children: newUserABlocks,
                    //                 ),
                    //               ),
                    //               Expanded(
                    //                 flex: 2,
                    //                 child: Column(
                    //                   children: newUserBBlocks,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                );
              }
            }
          }),
    );
  }

  Widget timeColumn(String time, Size size) {
    return SizedBox(
      height: 80,
      width: size.width / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.white,
            thickness: 2,
            height: 4,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 24,
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width / 10,
            child: Divider(
              color: Colors.white,
              thickness: 2,
              height: 2,
            ),
          ),
          Container(
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget timeColumn2(String time, Size size) {
    return SizedBox(
      height: 40,
      width: size.width / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.white,
            thickness: 2,
            height: 4,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 24,
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width / 10,
            child: Divider(
              color: Colors.white,
              thickness: 2,
              height: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class DayNumbersAndName {
  String dayName;
  int dayNumber;

  DayNumbersAndName({
    required this.dayName,
    required this.dayNumber,
  });
}
