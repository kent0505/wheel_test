import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/store_bloc.dart';
import '../blocs/money/money_bloc.dart';
import '../core/utils.dart';
import '../widgets/dialog_widget.dart';
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
  double amount = 0;
  double field = 0;
  bool canSpin = true;
  bool display = false;

  List<double> angles = [
    1, // 5
    2, // 2.5
    13, // loose
    3, // 25
    15, // -2
    4, // 7
    11, // -1.5
    8, // 20
    9, // -2
    10, // 1.7
    12, // 1.5
    13, // loose
    19, // 13
    20, // 5
    11, // -1.5
    22, // 25
    15, // -2
  ];

  void onSpin(double money) async {
    field = double.tryParse(controller.text) ?? 0;
    if (money < field) {
      showDialog(
        context: context,
        builder: (context) {
          return DialogWidget(
            title: 'Out of Coins? No Problem!',
            description:
                'Looks like you\'re out of funds to place your bet. Don\'t worry—watch a quick ad and get 500 coins for free!',
            buttonTitle: 'Watch',
            buttonColor: Color(0xff0A84FF),
            onPressed: () {},
          );
        },
      );
      return;
    }
    context.read<MoneyBloc>().add(AddMoney(amount: -field));
    setState(() {
      turns += 5 / 1;
      canSpin = false;
    });
    Random random = Random();
    int randomIndex = random.nextInt(angles.length);
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        angle = angles[randomIndex];
        logger(angle);
      });
    });
    await Future.delayed(const Duration(seconds: 4), () async {
      if (angle == 1) amount = 5;
      if (angle == 2) amount = 2.5;
      if (angle == 3) amount = 25;
      if (angle == 4) amount = 7;
      if (angle == 8) amount = 20;
      if (angle == 9) amount = -2;
      if (angle == 10) amount = 1.7;
      if (angle == 11) amount = -1.5;
      if (angle == 12) amount = 1.5;
      if (angle == 13) amount = 0;
      if (angle == 14) amount = 20;
      if (angle == 15) amount = -2;
      if (angle == 19) amount = 13;
      if (angle == 20) amount = 5;
      if (angle == 22) amount = 25;
      if (mounted) {
        context.read<MoneyBloc>().add(AddMoney(amount: amount * field));
      }
      setState(() {
        display = true;
        FocusManager.instance.primaryFocus?.unfocus();
        activeBonus = 0;
      });
    });
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        display = false;
        canSpin = true;
      });
    });
  }

  void onBonus(int value) {
    if (canSpin) {
      setState(() {
        if (activeBonus == value) {
          activeBonus = 0;
        } else {
          activeBonus = value;
        }
      });
    }
  }

  void onAdd(double value) {
    setState(() {
      double amount = double.tryParse(controller.text) ?? 0;
      amount += value;
      controller.text = amount.toString().replaceAll('.0', '');
    });
  }

  void onClear() {
    if (canSpin) {
      setState(() {
        activeBonus = 0;
        controller.clear();
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 20),
            BlocBuilder<StoreBloc, StoreState>(
              builder: (context, state) {
                return WheelCard(
                  id: state is StoreLoaded ? state.store.wheel : 1,
                  turns: turns,
                  angle: angle,
                );
              },
            ),
            SizedBox(height: 6),
            BlocBuilder<StoreBloc, StoreState>(
              builder: (context, state) {
                if (state is StoreLoaded) {
                  return Row(
                    children: [
                      SizedBox(width: 16),
                      _BonusButton(
                        id: 1,
                        amound: state.store.bonus1,
                        activeBonus: activeBonus,
                        onPressed: onBonus,
                      ),
                      SizedBox(width: 6),
                      _BonusButton(
                        id: 2,
                        amound: state.store.bonus2,
                        activeBonus: activeBonus,
                        onPressed: onBonus,
                      ),
                      SizedBox(width: 6),
                      _BonusButton(
                        id: 3,
                        amound: state.store.bonus3,
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
                    money: state.money.money,
                    isActive: canSpin,
                    onPressed: onAdd,
                  );
                }
                return Container();
              },
            ),
            SizedBox(height: 6),
            BlocBuilder<MoneyBloc, MoneyState>(
              builder: (context, state) {
                return MainButton(
                  title: 'Place Bet',
                  margin: 16,
                  // isActive: state is! WheelSpinning,
                  isActive: controller.text.isNotEmpty && canSpin,
                  onPressed: () {
                    onSpin(state is MoneyLoaded ? state.money.money : 0);
                  },
                );
              },
            ),
            SizedBox(height: 10),
            MyButton(
              onPressed: canSpin ? onClear : null,
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
        ),
        Positioned(
          top: 112,
          left: 0,
          right: 0,
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
                    formatDouble(amount * field),
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
      ],
    );
  }
}

class _BonusButton extends StatelessWidget {
  const _BonusButton({
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
        onPressed: () {
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
