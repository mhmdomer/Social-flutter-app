import 'package:flutter/material.dart';

// the color pallette
const mediumBlue = Color(0xFF2D1DC0);
const cornflowerBlue = Color(0xFF758BFD);
const morningBlue = Color(0xFF8AA399);
const greyBlue = Color(0xFFD5DFE5);
const onyx = Color(0xFF393D3F);
const scrollThreshold = 200.0;


const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mediumBlue, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mediumBlue, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);