import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPlanScreen extends StatefulWidget {
  @override
  _AddPlanScreenState createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Plan"),
        centerTitle: true,
      ),
      body: Container(
        child: Text("hoppa"),
      ),
    );
  }
}
