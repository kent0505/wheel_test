import 'dart:ui';

import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.title,
    required this.description,
    required this.buttonTitle,
    this.buttonColor = const Color(0xffF12E36),
    required this.onPressed,
  });

  final String title;
  final String description;
  final String buttonTitle;
  final Color buttonColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff1E1E1E).withValues(alpha: 0.75),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: SizedBox(
            height: 168,
            width: 274,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'w600',
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'w600',
                      height: 1.2,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: 1,
                  color: Color(0xff545458).withValues(alpha: 0.65),
                ),
                Row(
                  children: [
                    _Button(
                      title: 'Cancel',
                      fontFamily: 'w400',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      height: 44,
                      width: 1,
                      color: Color(0xff545458).withValues(alpha: 0.65),
                    ),
                    _Button(
                      title: buttonTitle,
                      color: buttonColor,
                      onPressed: () {
                        Navigator.pop(context);
                        onPressed();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    this.color = const Color(0xff0A84FF),
    this.fontFamily = 'w600',
    required this.onPressed,
  });

  final String title;
  final Color color;
  final String fontFamily;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyButton(
        padding: 0,
        minSize: 44,
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontFamily: fontFamily,
          ),
        ),
      ),
    );
  }
}
