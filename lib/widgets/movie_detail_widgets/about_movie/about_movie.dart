import 'package:flutter/material.dart';

class AboutMovie extends StatelessWidget {
  const AboutMovie({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Text(
      "ABOUT MOVIE",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
        color: Colors.white.withOpacity(0.5),
      ),
    ),
  );
}
