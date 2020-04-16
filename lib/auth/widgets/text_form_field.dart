import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {

  final String labelText;
  final TextEditingController controller;
  final Icon prefixIcon;
  final suffixIcon;
  final bool readOnly;
  final VoidCallback onTap;
  final bool enable;
  CustomTextField({@required this.labelText, @required this.controller,@required this.prefixIcon, this.suffixIcon, this.readOnly, this.onTap, this.enable});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Theme(
          data: new ThemeData(
              primaryColor: Colors.black,
              accentColor: Colors.pink,
              hintColor: Colors.grey
          ),

          child: TextFormField(
            onTap: widget.onTap,
            enabled: widget.enable??true,
            controller: widget.controller,
            readOnly: widget.readOnly??false,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              labelText: widget.labelText
            ),
          ),
        ),
      ),
    );
  }
}
