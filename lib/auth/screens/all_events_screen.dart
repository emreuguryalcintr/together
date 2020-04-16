import 'package:calendar_views/calendar_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:together/auth/widgets/day_view_example.dart';
import 'package:together/auth/widgets/text_form_field.dart';
import 'package:intl/intl.dart';

class AllEventsScreen extends StatefulWidget {
  @override
  _AllEventsScreenState createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  String _selectedActivity;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventsOfDay0.add(Event(startMinuteOfDay: 23*60,title: "Attaya gitmek"));
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
                      underline: Container(height: 1, color: Colors.black,),
                      hint: Center(child: Text(_selectedActivity == null
                          ? 'Aktivite Seçiniz'
                          : _selectedActivity, style: TextStyle(color: Colors
                          .black),)),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: [
                        '#Kitap Okuma',
                        '#Film İzleme',
                        '#Dizi İzleme',
                        '#Spor Yapma'
                        , "#Yemek Yapma"
                        , '#Dil Öğrenme'
                      ].map(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Center(child: Text(
                              val, style: TextStyle(color: Colors.black),),),
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
              SizedBox(height: 20,),
              CustomTextField(
                controller: TextEditingController(),
                labelText: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                prefixIcon: Icon(Icons.event),
                readOnly: true,
                onTap: () {

                },
              ),
              SizedBox(height: 20,),
              Expanded(flex:1,child: DayViewExample())
            ]),
          ),
        ));
  }
}
