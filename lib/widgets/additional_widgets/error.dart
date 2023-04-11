import 'package:flutter/material.dart';

Widget errorWidget(String error) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Error occured: $error"),
    ],
  ),
);
