import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'coin_card.dart';
import 'my_button.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    super.key,
    required this.controller,
    required this.hintText,
    this.length = 6,
    required this.money,
    required this.isActive,
    required this.onPressed,
  });

  final TextEditingController controller;
  final String hintText;
  final int length;
  final double money;
  final bool isActive;
  final void Function(double) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
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
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            readOnly: !isActive,
            inputFormatters: [
              LengthLimitingTextInputFormatter(length),
              FilteringTextInputFormatter.digitsOnly,
            ],
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'w600',
            ),
            decoration: InputDecoration(
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MoneyCard(),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 52,
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Color(0xff4C4A51),
                fontFamily: 'w600',
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 173,
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 5),
                  _Button(
                    title: '+10',
                    onPressed: () {
                      onPressed(10);
                    },
                  ),
                  SizedBox(width: 3),
                  _Button(
                    title: '+100',
                    onPressed: () {
                      onPressed(100);
                    },
                  ),
                  SizedBox(width: 3),
                  _Button(
                    title: 'All',
                    onPressed: () {
                      double amount = double.tryParse(controller.text) ?? 0;
                      onPressed(money - amount);
                    },
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: onPressed,
      minSize: 42,
      child: Container(
        height: 42,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xff040404),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 2,
            color: Color(0xff222026),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xffEFEFEF),
              fontSize: 16,
              fontFamily: 'w600',
            ),
          ),
        ),
      ),
    );
  }
}
