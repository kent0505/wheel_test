import 'package:flutter/material.dart';

import 'svg_widget.dart';
import 'wheel_widget.dart';

class WheelCard extends StatelessWidget {
  const WheelCard({
    super.key,
    required this.turns,
    required this.angle,
  });

  final double turns;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 296,
      width: 360,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xff1D1B23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: Color(0xff222026),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -68,
            left: MediaQuery.of(context).size.width < 380 ? -18 : -10,
            right: MediaQuery.of(context).size.width < 380 ? -18 : -10,
            // bottom: 10,
            child: Transform.rotate(
              angle: angle,
              child: AnimatedRotation(
                turns: turns,
                curve: Curves.easeInOutCirc,
                duration: const Duration(seconds: 7),
                child: Center(child: WheelWidget(active: false)),
              ),
            ),
          ),
          Positioned(
            top: 68,
            left: 0,
            right: 0,
            child: SvgWidget('assets/wheel_arrow.svg'),
          ),
        ],
      ),
    );
  }
}
