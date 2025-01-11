import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/money/money_bloc.dart';
import '../core/utils.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/main_button.dart';
import '../widgets/svg_widget.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyBloc, MoneyState>(
      builder: (context, state) {
        if (state is MoneyLoaded) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ).copyWith(bottom: 8),
            children: [
              _Item(
                id: 1,
                title: 'Second Chance',
                description:
                    'You get the opportunity to spin the wheel a second time. Only the second result is counted.',
                price: 250,
              ),
              _Item(
                id: 2,
                title: 'One from Two',
                description:
                    'You can spin the wheel twice and choose either of the two results.',
                price: 250,
              ),
              _Item(
                id: 3,
                title: 'Block Sector',
                description:
                    'You can "block" one unwanted sector. It will not be considered during the next spin.',
                price: 250,
              ),
              _Wheel(
                id: 1,
                title: 'Classic Wheel',
                price: 2500,
                selected: state.wheel == 1,
              ),
              _Wheel(
                id: 2,
                title: 'Diamond Wheel',
                price: 2500,
                bought: state.wheel2,
                selected: state.wheel == 2,
              ),
              _Wheel(
                id: 3,
                title: 'Fire Wheel',
                price: 2500,
                bought: state.wheel3,
                selected: state.wheel == 3,
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });

  final int id;
  final String title;
  final String description;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Color(0xff1D1B23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Color(0xff222026),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 12),
          Container(
            height: 110,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xff040404),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: SvgWidget('assets/store$id.svg'),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'w600',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff4C4A51),
                    fontSize: 12,
                    fontFamily: 'w600',
                  ),
                ),
                Spacer(),
                BlocBuilder<MoneyBloc, MoneyState>(
                  builder: (context, state) {
                    return MainButton(
                      title: 'Get for \$$price',
                      onPressed: () {
                        state is MoneyLoaded && state.money >= price
                            ? context
                                .read<MoneyBloc>()
                                .add(BuyItem(id: id, price: price))
                            : showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogWidget(
                                    title: 'Not Enough Funds',
                                    description:
                                        'You don’t have enough money for this purchase. But no worries! Watch a quick ad and get \$500 for free to keep going!',
                                    buttonTitle: 'Watch',
                                    buttonColor: Color(0xff0A84FF),
                                    onPressed: () {},
                                  );
                                },
                              );
                      },
                    );
                  },
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _Wheel extends StatelessWidget {
  const _Wheel({
    required this.id,
    required this.title,
    required this.price,
    this.bought = true,
    required this.selected,
  });

  final int id;
  final String title;
  final int price;
  final bool bought;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Color(0xff1D1B23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Color(0xff222026),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 12),
          Container(
            height: 110,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xff040404),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: SvgWidget('assets/wheel$id.svg'),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'w600',
                  ),
                ),
                Spacer(),
                BlocBuilder<MoneyBloc, MoneyState>(
                  builder: (context, state) {
                    return MainButton(
                      title: selected || bought
                          ? 'Apply'
                          : 'Get for \$${formatNumber(price)}',
                      isActive: !selected,
                      onPressed: () {
                        if (bought) {
                          context.read<MoneyBloc>().add(SelectWheel(id: id));
                        } else {
                          if (state is MoneyLoaded && state.money >= price) {
                            context
                                .read<MoneyBloc>()
                                .add(BuyWheel(id: id, price: price));
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return DialogWidget(
                                  title: 'Not Enough Funds',
                                  description:
                                      'You don’t have enough money for this purchase. But no worries! Watch a quick ad and get \$500 for free to keep going!',
                                  buttonTitle: 'Watch',
                                  buttonColor: Color(0xff0A84FF),
                                  onPressed: () {},
                                );
                              },
                            );
                          }
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}
