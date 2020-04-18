import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profil"),
        actions: <Widget>[
          IconButton(
            onPressed: (){

            },
            icon:Icon(Icons.add,color: Colors.white,size: 24,),
          )
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
                            image: new AssetImage('images/deneme.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: new BorderRadius.all(new Radius.circular(50.0)),

                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Emre Uğur Yalçın"),
                          Text("emre.ugur")
                        ],
                      )
                    ],
                  )
                  ,Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: (){

                      },
                      icon: Icon(Icons.settings,color: Colors.white,),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              color: Colors.yellow,
              child: Text("Planlar",textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
