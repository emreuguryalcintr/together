import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityList extends StatefulWidget {
  final List list;

  const ActivityList({Key key, this.list}) : super(key: key);
  @override
  _ActivityListState createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: widget.list.length,
         separatorBuilder: (context,index)=>Divider(
           color: Colors.grey,
           height: 0,
         ),
          itemBuilder: (BuildContext context,int index){
        return Text("");
      }),
    );
  }
}
