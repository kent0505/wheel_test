import 'package:flutter/material.dart';

import '../models/sector.dart';
import 'my_button.dart';
import 'rotated_widget.dart';
import 'svg_widget.dart';

class WheelCard extends StatelessWidget {
  const WheelCard({
    super.key,
    required this.id,
    required this.turns,
    required this.angle,
  });

  final int id;
  final double turns;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 296,
      // height: 360,
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
            left: 0,
            right: 0,
            child: Transform.rotate(
              angle: angle,
              child: AnimatedRotation(
                turns: turns,
                curve: Curves.easeInOutCirc,
                duration: const Duration(seconds: 7),
                child: SvgWidget(
                  'assets/wheel$id.svg',
                  height: 350,
                ),
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

class _Sector extends StatelessWidget {
  const _Sector({
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.degree = 0,
    required this.sector,
  });

  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final int degree;
  final Sector sector;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Center(
        child: RotatedWidget(
          degree: degree,
          child: MyButton(
            onPressed: () {},
            child: Container(
              height: 116,
              width: 84,
              decoration: BoxDecoration(
                  // color: Colors.greenAccent,
                  ),
              child: Stack(
                children: [
                  SvgWidget(
                    'assets/sector1.svg',
                    height: 116,
                    width: 84,
                  ),
                  Center(
                    child: Text(
                      sector.title,
                      style: TextStyle(
                        color:
                            sector.title == 'Lose' || sector.title.contains('-')
                                ? Color(0xff4C4A51)
                                : Colors.white,
                        fontSize: 16,
                        fontFamily: 'w600',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
