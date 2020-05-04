import 'package:flutter/cupertino.dart';
import 'package:together/enums/enums.dart';

class KitModel{
  final String title;
  final String type;
  final List<String> suggestion;
  final DateTime dateTime;

  KitModel({@required this.title,@required this.type,@required this.suggestion,@required this.dateTime});

  bool addToFireBase(){
    return (title!=null && title.isNotEmpty) && (type!=null && type.isNotEmpty) &&(suggestion!=null &&suggestion.length>0) &&(dateTime!=null);
  }


  factory KitModel.fromJson(Map<String,dynamic> json){
    return KitModel(
      title: json["title"],
      type: json["type"]??EnumListType.list.toString(),
      suggestion: json["suggestions"],
      dateTime: json["created"]
    );
  }

  List<Map> toJson(){
    List<Map> list = List<Map>();
    Map<String, dynamic> map = Map<String, dynamic>();
    map["suggestions"] = suggestion;
    map["title"] = title;
    map["created"] = dateTime;
    map["type"]=type;
    list.add(map);

    return list;


  }
}