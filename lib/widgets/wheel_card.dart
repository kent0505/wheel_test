import 'package:flutter/material.dart';

class WheelCard extends StatelessWidget {
  const WheelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 296,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xff1D1B23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: Color(0xff222026),
        ),
      ),
    );
  }
}
