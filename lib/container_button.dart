import 'package:flutter/material.dart';

class containerButton extends StatelessWidget {
  const containerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            GestureDetector(onTap:(){print("pressed");} ,
              child: Container(
      height: 100,
      width: 100,
      color: Colors.redAccent,
    ),
            ),   InkWell(onTap:(){print("pressed");} ,
              child: Container(
      height: 100,
      width: 100,
      color: Colors.green,
    ),
            ),
          ],
        ),
    );
  }
}
