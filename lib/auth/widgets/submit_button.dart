import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final String text;
  final Color textColor;
  final Color backgroundColor;

  const SubmitButton({Key key, this.onPressed, @required this.width, this.text, this.textColor, this.backgroundColor, @required this.height}) : super(key: key);
  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(3.0),
        ),
        color:widget.backgroundColor,
        textColor: widget.textColor,
        onPressed: widget.onPressed,
        child: Text(widget.text),
      ),
    );
  }
}
