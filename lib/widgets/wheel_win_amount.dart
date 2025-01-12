import 'package:flutter/material.dart';

import '../core/utils.dart';

class WheelWinAmount extends StatelessWidget {
  const WheelWinAmount({
    super.key,
    required this.amount,
    required this.display,
  });

  final double amount;
  final bool display;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 112,
      left: 0,
      right: 0,
      child: IgnorePointer(
        ignoring: !display,
        child: Center(
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: display ? 1 : 0,
            child: Container(
              height: 70,
              width: 192,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 2,
                  color: Color(0xff222026),
                ),
              ),
              child: Center(
                child: Text(
                  formatDouble(amount),
                  style: TextStyle(
                    color: amount > 0 ? Color(0xff73CB00) : Color(0xffE10606),
                    fontSize: 36,
                    fontFamily: 'w800',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
