import 'package:flutter/material.dart';

mixin UIToolMixin {
  showMessage(GlobalKey<ScaffoldState> _scaffoldKey, String message,
      {Color color = Colors.red}) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    ));
  }
}
