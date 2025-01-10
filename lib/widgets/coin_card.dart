import 'package:flutter/material.dart';

class MoneyCard extends StatelessWidget {
  const MoneyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: RadialGradient(
          colors: [
            Color(0xffFFC83C),
            Color(0xffE3A302),
          ],
        ),
      ),
      child: Center(
        child: Text(
          '\$',
          style: TextStyle(
            color: Color(0xffEFEFEF),
            fontSize: 16,
            fontFamily: 'w600',
          ),
        ),
      ),
    );
  }
}
