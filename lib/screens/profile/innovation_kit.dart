import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:together/auth/auth_service.dart';
import 'package:together/enums/enums.dart';
import 'package:together/models/kit_model.dart';

class InnovationKit extends StatefulWidget {
  @override
  _InnovationKitState createState() => _InnovationKitState();
}

class _InnovationKitState extends State<InnovationKit> {
  String userID;
  bool isList = false;
  List<String> suggestionList;
  String title;
  DateTime createdDateTime;
  String type;
  EnumListType enumType;
  StorageReference storageReference;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    enumType=EnumListType.card;
    type=EnumListType.card.toString();
    suggestionList = List();

    StorageReference ref = FirebaseStorage.instance.ref();

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
            child: Icon(
              Icons.add,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              customAlertDialog(context,alertTitle: "Öneri ekle",suggestionList: suggestionList);
            },
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Sosyal İnovasyon Kiti"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: (){
                },
              )
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              color: Colors.transparent,
              image: new DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/together-c475e.appspot.com/o/kit_background%2Frainbow.png?alt=media&token=450ec02c-84f9-4ffb-ad58-cfa7dbb2640c"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                   customAlertDialog(context, alertTitle:"Başlık Giriniz", title: title);
                    },
                    child: Text(
                      title ?? "Başlık girmek için tıklayınız",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      flex: 1,
                      child: suggestionList.length > 0
                          ? (enumType != EnumListType.grid
                              ? ListView.builder(
                                  itemCount: suggestionList.length,
                                  itemBuilder: (context, index) {
                                    String suggestion=suggestionList[index];
                                    return Card(
                                        elevation: enumType == EnumListType.list
                                            ? 0
                                            : 1,
                                        color: enumType == EnumListType.list?Colors.transparent:Colors.white,
                                        margin: EdgeInsets.all(8),
                                        child: Stack(
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white),
                                                  width: 30,
                                                  height: 30,
                                                  child: Center(
                                                      child: Text(
                                                    "${index + 1}",
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(child: Text(suggestion),flex: 1,),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      suggestionList.removeAt(index);
                                                    });
                                                  },
                                                  child: Icon(Icons.cancel),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                            )
                                          ],
                                        ));
                                  },
                                )
                              : GridView.count(
                                  childAspectRatio: 2,
                                  padding: EdgeInsets.all(10),
                                  // Create a grid with 2 columns. If you change the scrollDirection to
                                  // horizontal, this produces 2 rows.
                                  crossAxisCount: 3,
                                  // Generate 100 widgets that display their index in the List.
                                  children: List.generate(suggestionList.length,
                                      (index) {
                                    String suggestion=suggestionList[index];
                                    return Container(
                                      height: 100,
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Stack(
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: Text(
                                                    suggestion,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: (){
                                                    setState(() {
                                                      suggestionList.removeAt(index);
                                                    });
                                                },
                                                child: Icon(Icons.cancel),
                                              ),
                                            )
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 5,
                                      ),
                                    );
                                  })))
                          : Center(
                              child:
                                  Text("Öneri listesi girmeniz gerekmektedir"),
                            )),
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
                      onPressed: () {
                        saveKit(context,
                            userID: userID,
                            type: type,
                            title: title,
                            suggestionList: suggestionList);
                      },
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

  customAlertDialog(BuildContext context,{String alertTitle,List<String> suggestionList,String title}){

    List<String> list=List();
    String titleS;

    TextEditingController controller=TextEditingController();
    AlertDialog alert= AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextField(
              controller: controller,
            ),
          ),
          Visibility(
            visible: suggestionList!=null,
            child: InkWell(
              child: Icon(Icons.add),
              onTap: (){
                if(controller.text!="")list.add(controller.text);
                controller.clear();
              },
            ),
          )
        ],
      ),
      title: Text(alertTitle),
      actions: <Widget>[
        InkWell(child: Icon(Icons.done),onTap: (){
          if(suggestionList==null){
           setState(() {
             this.title=controller.text;
           });
            print("title is: $title");
          }else{
            suggestionList.addAll(list);
          }
          Navigator.pop(context);
        },),
        SizedBox(width: 5,),
        InkWell(child: Icon(Icons.clear),
        onTap: (){
          Navigator.pop(context);
        },),
      ],
    );

    showDialog(context: context,
    barrierDismissible: false,
    builder: (context){
      return alert;
    });
  }
}

void saveKit(BuildContext context,
    {String userID, String title, String type, List<String> suggestionList}) {
  KitModel kitModel = KitModel(
      dateTime: DateTime.now(),
      title: title,
      type: type,
      suggestion: suggestionList);

  if (kitModel.addToFireBase()) {
    Firestore.instance.collection("user_kit").document(userID).setData(
        {"userKit": FieldValue.arrayUnion(kitModel.toJson())},
        merge: true);
  } else {
    Toast.show("gerekli alanları doldurunuz", context, gravity: Toast.CENTER);
  }
}
