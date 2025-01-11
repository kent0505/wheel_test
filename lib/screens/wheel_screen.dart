import 'package:flutter/material.dart';

import '../widgets/main_button.dart';
import '../widgets/my_button.dart';
import '../widgets/svg_widget.dart';
import '../widgets/txt_field.dart';
import '../widgets/wheel_card.dart';

class WheelScreen extends StatefulWidget {
  const WheelScreen({super.key});

  @override
  State<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends State<WheelScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: 20),
        WheelCard(),
        SizedBox(height: 6),
        Row(
          children: [
            SizedBox(width: 16),
            _Action(
              id: 1,
              amound: 1,
              onPressed: () {},
            ),
            SizedBox(width: 6),
            _Action(
              id: 2,
              amound: 1,
              onPressed: () {},
            ),
            SizedBox(width: 6),
            _Action(
              id: 3,
              amound: 1,
              onPressed: () {},
            ),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Last 10 results',
            style: TextStyle(
              color: Color(0xff4C4A51),
              fontSize: 12,
              fontFamily: 'w600',
            ),
          ),
        ),
        SizedBox(height: 6),
        SizedBox(
          height: 30,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 16, right: 12),
            children: [
              _LastResult(title: 'x2'),
              _LastResult(title: 'Lose'),
              _LastResult(title: 'x2'),
              _LastResult(title: 'x2'),
              _LastResult(title: 'x2'),
              _LastResult(title: 'x2'),
              _LastResult(title: 'x2'),
              _LastResult(title: 'x2'),
            ],
          ),
        ),
        SizedBox(height: 16),
        TxtField(
          controller: controller,
          hintText: '100',
        ),
        SizedBox(height: 6),
        MainButton(
          title: 'Place Bet',
          margin: 16,
          onPressed: () {},
        ),
        SizedBox(height: 10),
        MyButton(
          onPressed: () {},
          minSize: 52,
          child: Center(
            child: Text(
              'Clear All',
              style: TextStyle(
                color: Color(0xffE10606),
                fontSize: 16,
                fontFamily: 'w600',
              ),
            ),
          ),
        ),
        SizedBox(height: 90),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.id,
    required this.amound,
    required this.onPressed,
  });

  final int id;
  final int amound;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyButton(
        onPressed: onPressed,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: Color(0xff040404),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 2,
              color: Color(0xff222026),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgWidget('assets/action$id.svg'),
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

class _LastResult extends StatelessWidget {
  const _LastResult({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 55,
      margin: EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
    );
  }
}
