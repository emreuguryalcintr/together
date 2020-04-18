import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:together/auth/auth_service.dart';
import 'package:together/auth/constants.dart';
import 'package:together/auth/screens/all_events_screen.dart';
import 'package:together/auth/screens/profile_screen.dart';

class MainScreen extends StatefulWidget{
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>  with TickerProviderStateMixin{
  String userA;
  PageController _tabController;
  int _activeTabIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController=PageController(initialPage: 0);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
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
          index: _activeTabIndex,
          height: 50,
          animationCurve: Curves.easeIn,
          color: Colors.red,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              _tabController.jumpToPage(index);
              _activeTabIndex=index;
            });
          },
          items: <Widget>[
            Icon(Icons.event, size: 30,color: Colors.white,),
            Icon(Icons.people, size: 30,color: Colors.white,),
            Icon(Icons.person, size: 30,color: Colors.white,)
          ],


        ),
        body: PageView(
         physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index){
            setState(() {
              _activeTabIndex=index;
            });
          },
          controller:_tabController,
          children: <Widget>[
            AllEventsScreen(),
            Icon(Icons.directions_car),
            ProfileScreen(),
          ],

        ));
  }
}
