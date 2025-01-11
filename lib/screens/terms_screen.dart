import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(
            title: 'Terms of use',
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
