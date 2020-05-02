
import 'package:calendar_views/calendar_views.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:together/widgets/day_view_example.dart';
import 'package:together/widgets/text_form_field.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../firebase_helper.dart';

class AllEventsScreen extends StatefulWidget {
  @override
  _AllEventsScreenState createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  String _selectedActivityName="";
  String _selectedActivity="";
  String selectedDate;
  List items=List();
  List enums=List();
  Map<String,dynamic> languageMap=Map<String,dynamic>();
  String language="tr";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedDate=DateFormat('dd-MM-yyyy').format(DateTime.now());
    eventsOfDay0.clear();


    Firestore.instance.collection("events").document("events").get().then((snapshot){
      setState(() {
        languageMap=snapshot[language];
      });

    });

    /*String a="12-06-2020";
    Firestore.instance.collection("total_analyze").document("reading_book").updateData({
      "$a.21":FieldValue.increment(1)
    });*/

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fBHelper.map.clear();
    eventsOfDay0.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance.collection("total_analyze").document(_selectedActivity).snapshots(),
            builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){

              DocumentSnapshot ds=snapshot.data;
              if(snapshot.hasError)
                return new Text("Error: ${snapshot.error}");

              return Container(
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
                                    _selectedActivityName == null || _selectedActivity.isEmpty
                                        ? 'Aktivite Seçiniz'
                                        : _selectedActivityName,
                                    style: TextStyle(color: Colors.black),
                                  )),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: Colors.black),

                              items: languageMap.map(
                                    (key,value) {
                                  eventsOfDay0.clear();
                                  if(snapshot.hasData &&snapshot.data!=null && snapshot.data.data!=null )
                                    snapshot.data.data[selectedDate]?.forEach((key, value) {
                                      if(key!="total")
                                        eventsOfDay0.add(Event(startMinuteOfDay: (int.parse(key)) * 60, title: value.toString()+ " kişi"));
                                    });
                                  return MapEntry(
                                    key,
                                    DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).values.toList(),
                              onChanged: (value) {
                                setState(
                                      () {
                                    _selectedActivityName = value;
                                    _selectedActivity=languageMap.keys.firstWhere((k)=>languageMap[k]==value,orElse:() =>"");
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
                        selectedDate,
                        prefixIcon: Icon(Icons.event),
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2017),
                            lastDate: DateTime(2025),).then((date){
                            setState(() {
                              selectedDate=DateFormat('dd-MM-yyyy').format(date);
                              eventsOfDay0.clear();
                              if(snapshot.hasData &&snapshot.data!=null && snapshot.data.data!=null)
                                snapshot.data.data[selectedDate]?.forEach((key, value) {
                                  if(key!="total")
                                    eventsOfDay0.add(Event(startMinuteOfDay: (int.parse(key)) * 60, title: value.toString()+ " kişi"));
                                });
                            });
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(flex: 1, child: eventsOfDay0.length>0?DayViewExample():Center(child: Text("Kayıtlı etkinlik bu tarihte yok"),))
                    ]),
                  );

              }

          ),
        ));
  }
}
