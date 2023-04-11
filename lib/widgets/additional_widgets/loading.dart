import 'package:flutter/material.dart';

Widget loadingWidget() => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      SizedBox(
        height: 25.0,
        width: 25.0,
        child: CircularProgressIndicator(),
      ),
    ],
  ),
);
