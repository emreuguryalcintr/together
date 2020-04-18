import 'package:calendar_views/calendar_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:together/auth/widgets/day_view_example.dart';
import 'package:together/auth/widgets/text_form_field.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class AllEventsScreen extends StatefulWidget {
  @override
  _AllEventsScreenState createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  String _selectedActivity;
  String selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventsOfDay0.add(Event(startMinuteOfDay: 23 * 60, title: "Attaya gitmek"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButton(
                  underline: Container(
                    height: 1,
                    color: Colors.black,
                  ),
                  hint: Center(
                      child: Text(
                    _selectedActivity == null
                        ? 'Aktivite Seçiniz'
                        : _selectedActivity,
                    style: TextStyle(color: Colors.black),
                  )),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.black),
                  items: [
                    '#Kitap Okuma',
                    '#Film İzleme',
                    '#Dizi İzleme',
                    '#Spor Yapma',
                    "#Yemek Yapma",
                    '#Dil Öğrenme'
                  ].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Center(
                          child: Text(
                            val,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _selectedActivity = val;
                      },
                    );
                  },
                ),
              )),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: TextEditingController(),
            labelText:
            selectedDate ?? DateFormat('dd/MM/yyyy').format(DateTime.now()),
            prefixIcon: Icon(Icons.event),
            readOnly: true,
            onTap: () {
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2017),
                  lastDate: DateTime(2025),).then((date){
              setState(() {
                selectedDate=DateFormat('dd/MM/yyyy').format(date);
              });
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(flex: 1, child: DayViewExample())
        ]),
      ),
    ));
  }
}
