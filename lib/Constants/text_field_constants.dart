import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';


const kTextInputDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: CustColors.pinkish_grey05,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: CustColors.black_01, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: CustColors.black_01, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.5),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.5),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
);

const Widget vertical5 = SizedBox(height: 5.0);
const Widget vertical10 = SizedBox(height: 10.0);
const Widget vertical15 = SizedBox(height: 15.0);
const Widget vertical20 = SizedBox(height: 20.0);

const Widget vertical25 = SizedBox(height: 25.0);
const Widget vertical30 = SizedBox(height: 30.0);

const Widget vertical50 = SizedBox(height: 50.0);
const Widget vertical120 = SizedBox(height: 120.0);
