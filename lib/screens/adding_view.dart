import 'package:calender_app/models/guest.dart';
import 'package:calender_app/screens/adding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddingView extends StatefulWidget {
  List<Guests>? allUserData;

  AddingView({required this.allUserData});
  @override
  _AddingViewState createState() => _AddingViewState();
}

class _AddingViewState extends State<AddingView> {
  GlobalKey<FormState> addingKey = GlobalKey<FormState>();

  TextEditingController idCtr = TextEditingController();
  TextEditingController titleCtr = TextEditingController();
  TextEditingController detailCtr = TextEditingController();

  int dropdownValue1 = 8;
  int dropdownValue2 = 17;

  int selectedUserNum = 0;
  String selectedUserName = 'User A';

  String selectedDate = 'Select Date';

  bool isAllow = true;

  void isAllowedAppointment() {
    Map<int, int> tempTimes = {};
    if (widget.allUserData!.isEmpty) {
      isAllow = true;
    } else {
      for (var guest in widget.allUserData!) {
        print('guests...0');
        if (guest.date == selectedDate && guest.category == selectedUserName) {
          tempTimes[guest.start] = guest.end;
          print('${guest.start}');
          print('${guest.end}');
        }
      }

      int tempCount = 0;
      for (var startTime in tempTimes.keys) {
        print(startTime);
        print('${tempTimes[startTime]}');
        if (!((dropdownValue1 < startTime && dropdownValue2 <= startTime) ||
            (dropdownValue1 >= tempTimes[startTime]! &&
                dropdownValue2 > tempTimes[startTime]!))) {
          print(dropdownValue1 < startTime && dropdownValue2 < startTime);
          print(dropdownValue1 > tempTimes[startTime]! &&
              dropdownValue2 > tempTimes[startTime]!);
          print(dropdownValue1);
          print(dropdownValue2);
          isAllow = false;
          break;
        }
        tempCount++;
      }
      if (tempCount == tempTimes.length) {
        isAllow = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AddingViewModel>(
      create: (_) => AddingViewModel(),
      builder: (context, _) => SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              isAllowedAppointment();
              if (addingKey.currentState!.validate()) {
                if (selectedUserNum == 0) {
                  _showDialog('Please select User A or User B.');
                } else if (dropdownValue1 >= dropdownValue2) {
                  _showDialog('Please select valid start and end time.');
                } else if (!isAllow) {
                  print('is Allow: $isAllow');
                  _showDialog('Selected time range is full.');
                } else {
                  DateTime nowTime = DateTime.now();
                  selectedDate = DateFormat('dd.MM.y').format(nowTime);
                  String dateForOrder = DateFormat('y.MM.dd').format(nowTime);
                  await Provider.of<AddingViewModel>(context, listen: false)
                      .addNewGuest(
                    id: idCtr.text,
                    category: selectedUserName,
                    start: dropdownValue1,
                    end: dropdownValue2,
                    date: selectedDate,
                    title: titleCtr.text,
                    detail: detailCtr.text,
                    dateForOrder: dateForOrder,
                  );
                  print('was added.');
                  Navigator.pop(context, true);
                  print('we cannot see it');
                }
              }
            },
            backgroundColor: Color(0xFF00BCD4),
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFFD3EAED),
          appBar: AppBar(
            backgroundColor: Color(0xFF00BCD4),
            title: Text('Adding Appointment'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          body: Form(
            key: addingKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 32,
                  ),

                  /// UserA, UserB
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// UserA
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedUserNum = 1;
                            selectedUserName = 'User A';
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              color: Colors.white,
                              child: Opacity(
                                opacity: selectedUserNum == 1 ? 1 : 0,
                                child: Icon(
                                  Icons.done,
                                  color: Color(0xFF00BCD4),
                                  size: 32,
                                ),
                              ),
                            ),
                            Text(
                              ' User A',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),

                      /// UserB
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedUserNum = 2;
                            selectedUserName = 'User B';
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              color: Colors.white,
                              child: Opacity(
                                opacity: selectedUserNum == 2 ? 1 : 0,
                                child: Icon(
                                  Icons.done,
                                  color: Color(0xFF00BCD4),
                                  size: 32,
                                ),
                              ),
                            ),
                            Text(
                              ' User B',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 32,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: idCtr,
                      validator: (_val) {
                        if (_val == '') {
                          return 'Please enter id';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                          hintText: 'Enter Id',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  /// Time start end
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 80,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Column(
                          children: [
                            Text('Start'),
                            DropdownButton<int>(
                              value: dropdownValue1,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              onChanged: (int? newValue) {
                                setState(() {
                                  dropdownValue1 = newValue!;
                                });
                              },
                              items: <int>[
                                8,
                                9,
                                10,
                                11,
                                12,
                                13,
                                14,
                                15,
                                16,
                                17,
                              ].map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text('$value'),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Column(
                          children: [
                            Text('End'),
                            DropdownButton<int>(
                              value: dropdownValue2,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              onChanged: (int? newValue) {
                                setState(() {
                                  dropdownValue2 = newValue!;
                                });
                              },
                              items: <int>[
                                8,
                                9,
                                10,
                                11,
                                12,
                                13,
                                14,
                                15,
                                16,
                                17,
                              ].map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text('$value'),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  /// Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: titleCtr,
                      validator: (_val) {
                        if (_val == '') {
                          return 'Please enter title';
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                          hintText: 'Enter title',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  /// Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: detailCtr,
                      validator: (_val) {
                        if (_val == '') {
                          return 'Please enter details';
                        } else {
                          return null;
                        }
                      },
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                          hintText: 'Enter detail',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(String detail) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(detail),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
