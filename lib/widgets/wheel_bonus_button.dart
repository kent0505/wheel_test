import 'package:flutter/material.dart';

import 'my_button.dart';
import 'svg_widget.dart';

class WheelBonusButton extends StatelessWidget {
  const WheelBonusButton({
    super.key,
    required this.id,
    required this.amound,
    required this.activeBonus,
    required this.onPressed,
  });

  final int id;
  final int amound;
  final int activeBonus;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyButton(
        onPressed: amound >= 1
            ? () {
                onPressed(id);
              }
            : null,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 52,
          decoration: BoxDecoration(
            color: activeBonus == id ? Color(0xffA3C317) : Color(0xff040404),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 2,
              color: Color(0xff222026),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgWidget(
                'assets/store$id.svg',
                color:
                    activeBonus == id ? Color(0xffEFEFEF) : Color(0xff676179),
                height: 24,
              ),
              SizedBox(width: 10),
              Text(
                amound.toString(),
                style: TextStyle(
                  color: Color(0xffEFEFEF),
                  fontSize: 16,
                  fontFamily: 'w600',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
