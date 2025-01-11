import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(
            title: 'Privacy Policy',
            back: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
