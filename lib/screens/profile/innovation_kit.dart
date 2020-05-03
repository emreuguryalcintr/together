import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:together/auth/auth_service.dart';

class InnovationKit extends StatefulWidget {
  @override
  _InnovationKitState createState() => _InnovationKitState();
}

class _InnovationKitState extends State<InnovationKit> {
  String userID;
  bool isList=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    authService.user.listen((user) {
      setState(() {
        userID = user.uid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            child: Icon(Icons.add,color: Colors.blueAccent,),
            onPressed: (){

            },
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Sosyal İnovasyon Kiti"),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              color: Colors.transparent,
              image: new DecorationImage(
                image: AssetImage(
                  'images/background.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Dizi Önerileri",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: isList?ListView.builder(
                      itemCount: 322,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          color: Colors.white,
                          margin: EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                                ),
                                width: 30,
                                height: 30,
                                child: Center(child: Text("${index+1}",)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Game Of thrones")
                            ],
                          ),
                        );
                      },
                    ):
                    GridView.count(
                      childAspectRatio: 2,
                      padding: EdgeInsets.all(10),
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 3,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(100, (index) {
                        return Container(
                          height: 100,
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text("Game Of thrones",textAlign: TextAlign.center,),
                            )),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                          ),
                        );
                      }),
                    )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: Colors.white,
                              width: 2,
                              style: BorderStyle.solid)),
                      color: Colors.transparent,
                      onPressed: () {},
                      child: Text(
                        "Kaydet",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

void saveKit({String userID, String title, var suggestions}) {
  List<Map> list = List<Map>();
  Map<String, dynamic> map = Map<String, dynamic>();
  map["suggestions"] = suggestions;
  map["title"] = title;
  map["created"] = DateTime.now();
  list.add(map);

  Firestore.instance
      .collection("user_kit")
      .document(userID)
      .updateData({"userKit": FieldValue.arrayUnion(list)});
}
