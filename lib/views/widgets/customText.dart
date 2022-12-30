import 'package:flutter/material.dart';

Widget customText(String? title, double? size, Color? color, FontWeight? fontWeight) {
  return Text(title!, 
  style: TextStyle(fontSize:size, color:color , fontWeight: fontWeight),
  
  );
}
