import 'package:flutter/material.dart';
import 'package:social/UI/constants.dart';

class CustomTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for posts or people',
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cornflowerBlue, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cornflowerBlue, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
      ),
    );
  }
}
