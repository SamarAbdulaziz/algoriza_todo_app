import 'package:flutter/material.dart';

AppBar MyAppBar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),
      color: Colors.black,
    ),
    shape: const Border(
      bottom: BorderSide(
        color: Colors.black12,
        width: 2.0,
      ),
    ),
  );
}
