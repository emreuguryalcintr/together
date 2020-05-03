import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:together/auth/auth_service.dart';
import 'package:together/firebase_helper.dart';
import 'package:together/screens/profile/add_plan_screen.dart';
import 'package:together/screens/profile/innovation_kit.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentSelection = 0;
  FirebaseUser user;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      authService.user.listen((user){
        print("user id: ${user.uid}");
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profil"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
      floatingActionButton: BoomMenu(
        fabAlignment: Alignment.bottomLeft,
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blueAccent,
        animatedIconTheme: IconThemeData(size: 22.0,color: Colors.white),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Icon(Icons.event, color: Colors.white),
            title: "Plan",
            titleColor: Colors.white,
            subtitle: "Günlük planınızı ekleyin",
            subTitleColor: Colors.white,
            backgroundColor: Colors.deepOrange,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>AddPlanScreen()));
            },
          ),
          MenuItem(
            child: Icon(Icons.notifications, color: Colors.white),
            title: "Sosyal İnovasyon",
            titleColor: Colors.white,
            subtitle: "Sosyal inovasyon kitinizi oluşturun",
            subTitleColor: Colors.white,
            backgroundColor: Colors.green,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>InnovationKit()));
            }
          ),
        ],
      ),
        body: Container(
        color: Colors.pink.withOpacity(0.6),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: new AssetImage("images/deneme.jpg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(50.0)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Emre Uğur Yalçın"),
                          Text("emre.ugur")
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: MaterialSegmentedControl(
                children: _children,
                selectionIndex: _currentSelection,
                borderColor: Colors.grey,
                selectedColor: Colors.redAccent,
                unselectedColor: Colors.white,
                borderRadius: 5.0,
                disabledChildren: [
                  _children.length,
                ],
                onSegmentChosen: (index) {
                  setState(() {
                    _currentSelection = index;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Map<int, Widget> _children = {
    0: Text('Planlar'),
    1: Text('Sosyal Kit'),
  };
}
