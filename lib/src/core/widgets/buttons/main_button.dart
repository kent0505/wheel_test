import 'package:flutter/material.dart';

import 'my_button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.margin = 0,
    this.width,
    this.isActive = true,
    required this.onPressed,
  });

  final String title;
  final double margin;
  final double? width;
  final bool isActive;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 52,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: isActive ? Color(0xffB2FB8F) : Color(0xff222026),
        ),
        // color: isActive ? Color(0xffA1C116) : Color(0xff38373e),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            if (isActive) ...[
              Color(0xffB4D235),
              Color(0xffA1C116),
            ] else ...[
              Color(0xff38373e),
              Color(0xff38373e),
            ]
          ],
        ),
      ),
      child: MyButton(
        onPressed: isActive ? onPressed : null,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Color(0xffEFEFEF) : Color(0xff4C4A51),
              fontSize: 16,
              fontFamily: 'w600',
            ),
          ),
        ),
      ),
    );
  }
}
