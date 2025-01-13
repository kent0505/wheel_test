import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/money/money_bloc.dart';
import '../core/utils.dart';
import '../models/sector.dart';
import '../widgets/block_sector_dialog.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/main_button.dart';
import '../widgets/my_button.dart';
import '../widgets/select_sector_dialog.dart';
import '../widgets/txt_field.dart';
import '../widgets/wheel_bonus_button.dart';
import '../widgets/wheel_card.dart';
import '../widgets/wheel_last_results.dart';
import '../widgets/wheel_win_amount.dart';

class WheelScreen extends StatefulWidget {
  const WheelScreen({super.key});

  @override
  State<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends State<WheelScreen> {
  final controller = TextEditingController();
  int activeBonus = 0;
  int lastActiveBonus = 0;
  double turns = 0.0;
  double angle = 0;
  double amount = 0;
  double field = 0;
  bool canSpin = true;
  bool display = false;

  void onSpin(int money, int last) async {
    if (activeBonus == 1) {
      if (last == 0) {
        setState(() {
          activeBonus = 0;
        });
        return;
      }
      context.read<MoneyBloc>().add(
            RemoveLast(id: activeBonus, last: last),
          );
      setState(() {
        controller.clear();
        field = 1;
        display = true;
        activeBonus = 0;
        amount = last < 0 ? last.abs().toDouble() : -last.toDouble();
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          display = false;
          canSpin = true;
        });
      });
      return;
    } else if (activeBonus == 2 || activeBonus == 3) {
      lastActiveBonus = activeBonus;
      context.read<MoneyBloc>().add(UseBonus(id: activeBonus));
      setState(() {
        activeBonus = 0;
      });
    }
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
    context.read<MoneyBloc>().add(AddMoney(amount: -field.toInt()));
    setState(() {
      turns += 5 / 1;
      canSpin = false;
    });
    Random random = Random();
    int randomIndex = random.nextInt(angles.length);
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        angle = angles[randomIndex].toDouble();
        logger(angle);
      });
      Future.delayed(const Duration(seconds: 4), () async {
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
        if (lastActiveBonus == 2) {
          lastActiveBonus = 0;
          if (mounted) {
            context.read<MoneyBloc>().add(GetRandomSector(angle: angle));
            await showDialog<Sector>(
              context: context,
              builder: (context) {
                return SelectSectorDialog();
              },
            ).then((value) {
              if (mounted && value != null) {
                amount = value.factor;
              }
            });
          }
        }
        if (mounted) {
          context.read<MoneyBloc>().add(RestoreSectors());
          context.read<MoneyBloc>().add(AddMoney(
                amount: (amount * field).toInt(),
                result: amount == 0 ? 'Lose' : formatMultiplier(amount),
              ));
        }
        setState(() {
          display = true;
          FocusManager.instance.primaryFocus?.unfocus();
          activeBonus = 0;
        });
        Future.delayed(const Duration(seconds: 2), () async {
          setState(() {
            display = false;
            canSpin = true;
          });
        });
      });
    });
  }

  void onBonus(int value) async {
    if (activeBonus == 3) {
      context.read<MoneyBloc>().add(RestoreSectors());
      setState(() {
        activeBonus = 0;
      });
      return;
    }
    if (value == 3 && canSpin) {
      await showDialog<Sector>(
        context: context,
        builder: (context) {
          return BlockSectorDialog();
        },
      ).then((value) {
        if (mounted && value != null) {
          context.read<MoneyBloc>().add(RemoveSector(sector: value));
          setState(() {
            activeBonus = 3;
          });
        }
      });
    } else if (canSpin) {
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
    if (canSpin) {
      setState(() {
        double amount = double.tryParse(controller.text) ?? 0;
        amount += value;
        controller.text = amount.toString().replaceAll('.0', '');
      });
    }
  }

  void onClear() {
    if (canSpin) {
      setState(() {
        activeBonus = 0;
        controller.clear();
        context.read<MoneyBloc>().add(RestoreSectors());
      });
    }
  }

  void onChanged(String value) {
    setState(() {});
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
            WheelCard(
              turns: turns,
              angle: angle,
            ),
            SizedBox(height: 6),
            BlocBuilder<MoneyBloc, MoneyState>(
              builder: (context, state) {
                if (state is MoneyLoaded) {
                  return Row(
                    children: [
                      SizedBox(width: 16),
                      WheelBonusButton(
                        id: 1,
                        amound: state.model.bonus1,
                        activeBonus: activeBonus,
                        onPressed: onBonus,
                      ),
                      SizedBox(width: 6),
                      WheelBonusButton(
                        id: 2,
                        amound: state.model.bonus2,
                        activeBonus: activeBonus,
                        onPressed: onBonus,
                      ),
                      SizedBox(width: 6),
                      WheelBonusButton(
                        id: 3,
                        amound: state.model.bonus3,
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
            WheelLastResults(),
            SizedBox(height: 16),
            TxtField(
              controller: controller,
              isActive: canSpin,
              onChanged: onChanged,
              onPressed: onAdd,
            ),
            SizedBox(height: 6),
            BlocBuilder<MoneyBloc, MoneyState>(
              builder: (context, state) {
                if (state is MoneyLoaded) {
                  return MainButton(
                    title: 'Place Bet',
                    margin: 16,
                    isActive: controller.text.isNotEmpty && canSpin ||
                        activeBonus == 1,
                    onPressed: () {
                      onSpin(
                        state.model.money,
                        state.model.last,
                      );
                    },
                  );
                }

                return Container();
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
        WheelWinAmount(
          amount: amount * field,
          display: display,
        ),
      ],
    );
  }
}
