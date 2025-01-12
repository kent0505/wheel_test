import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/money/money_bloc.dart';
import '../blocs/wheel/wheel_bloc.dart';
import '../core/utils.dart';
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
  int activeBonus = 0;
  double turns = 0.0;
  double angle = 0;
  String asset = '';
  bool canSpin = true;

  List<double> angles = [
    1, // 5
    2, // 2.5
    3, // 25
    4, // 7
    8, // 20
    9, // -2
    10, // 1.7
    11, // -1.5
    12, // 1.5
    13, // loose
    14, // 20
    15, // -2
    19, // 13
    20, // 5
    22, // 25
  ];

  int getCoins() {
    asset = '';
    if (angle == 1) return 5;
    if (angle == 2) return 15;
    if (angle == 3) return 15;
    if (angle == 4) return 7;
    if (angle == 5) return 50;
    if (angle == 7) return 55;
    if (angle == 12) return 25;
    if (angle == 14) return 10;
    if (angle == 15) return 150;
    if (angle == 16) return 20;
    if (angle == 19) return 1;
    if (angle == 21) return 500;
    return 0;
  }

  void onSpin() async {
    setState(() {
      turns += 5 / 1;
      canSpin = false;
    });
    Random random = Random();
    int randomIndex = random.nextInt(angles.length);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        angle = angles[randomIndex];
        logger(angle);
      });
    });
    await Future.delayed(const Duration(seconds: 7), () async {
      setState(() {
        canSpin = true;
      });
    });
  }

  void onBonus(int value) {
    setState(() {
      activeBonus = value;
    });
  }

  void onAdd(int value) {
    setState(() {
      int amount = int.tryParse(controller.text) ?? 0;
      amount += value;
      controller.text = amount.toString();
    });
  }

  // void onSpin() {
  //   context.read<WheelBloc>().add(StartWheel(bonus: activeBonus));
  // }

  void onClear() {
    setState(() {
      activeBonus = 0;
      controller.clear();
    });
  }

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
        BlocBuilder<MoneyBloc, MoneyState>(
          builder: (context, state) {
            return WheelCard(
              id: state is MoneyLoaded ? state.wheel : 1,
              turns: turns,
              angle: angle,
            );
          },
        ),
        SizedBox(height: 6),
        BlocBuilder<MoneyBloc, MoneyState>(
          builder: (context, state) {
            if (state is MoneyLoaded) {
              return Row(
                children: [
                  SizedBox(width: 16),
                  _Action(
                    id: 1,
                    amound: state.bonus1,
                    activeBonus: activeBonus,
                    onPressed: onBonus,
                  ),
                  SizedBox(width: 6),
                  _Action(
                    id: 2,
                    amound: state.bonus2,
                    activeBonus: activeBonus,
                    onPressed: onBonus,
                  ),
                  SizedBox(width: 6),
                  _Action(
                    id: 3,
                    amound: state.bonus3,
                    activeBonus: activeBonus,
                    onPressed: onBonus,
                  ),
                  SizedBox(width: 16),
                ],
              );
            }

            return Container();
          },
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
        BlocBuilder<MoneyBloc, MoneyState>(
          builder: (context, state) {
            if (state is MoneyLoaded) {
              return TxtField(
                controller: controller,
                hintText: '100',
                money: state.money,
                onPressed: onAdd,
              );
            }
            return Container();
          },
        ),
        SizedBox(height: 6),
        BlocBuilder<WheelBloc, WheelState>(
          builder: (context, state) {
            return MainButton(
              title: 'Place Bet',
              margin: 16,
              // isActive: state is! WheelSpinning,
              isActive: canSpin,
              onPressed: onSpin,
            );
          },
        ),
        SizedBox(height: 10),
        BlocBuilder<WheelBloc, WheelState>(
          builder: (context, state) {
            return MyButton(
              onPressed: state is WheelSpinning ? null : onClear,
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
            );
          },
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
        onPressed: activeBonus == id
            ? null
            : () {
                onPressed(id);
              },
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
