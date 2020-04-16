import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:together/auth/auth_service.dart';
import 'package:together/auth/constants.dart';
import 'package:together/auth/screens/all_events_screen.dart';

class MainScreen extends StatefulWidget{
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>  with SingleTickerProviderStateMixin{
  String userA;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    authService.user.listen((user) {
      userA = user.email + "--" + user.uid;
      print("user A: $userA");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.colorAccent,
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          animationCurve: Curves.easeIn,
          color: Colors.red,
          backgroundColor: Colors.transparent,
          onTap: (index) {},
          items: <Widget>[
            Icon(Icons.event, size: 30,color: Colors.white,),
            Icon(Icons.people, size: 30,color: Colors.white,),
            Icon(Icons.person, size: 30,color: Colors.white,)
          ],

        ),
        body: TabBarView(
          controller: TabController(initialIndex: 0,length: 3,vsync: this),
          children: <Widget>[
            AllEventsScreen(),
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
          ],
        ));
  }
}
