import 'package:flutter/material.dart';

import '../widgets/main_button.dart';
import '../widgets/svg_widget.dart';
import 'home_screen.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SvgWidget(
            'assets/onboard.svg',
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ready to test your luck? Place your bets and spin the wheel for exciting rewards with amazing coefficients! Get started now and make your fortune!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffEFEFEF),
                fontSize: 16,
                fontFamily: 'w600',
              ),
            ),
          ),
          SizedBox(height: 20),
          MainButton(
            title: 'Let’s Start ',
            margin: 16,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
