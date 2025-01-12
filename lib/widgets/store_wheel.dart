import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/store_bloc.dart';
import '../blocs/money/money_bloc.dart';
import '../core/utils.dart';
import 'dialog_widget.dart';
import 'main_button.dart';
import 'svg_widget.dart';

class StoreWheel extends StatelessWidget {
  const StoreWheel({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.selected,
    this.bought = true,
  });

  final int id;
  final String title;
  final double price;
  final bool selected;
  final bool bought;

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
                          : 'Get for \$${formatNumber(price.toDouble())}',
                      isActive: !selected,
                      onPressed: () {
                        if (bought) {
                          context.read<StoreBloc>().add(SelectWheel(id: id));
                        } else {
                          if (state is MoneyLoaded &&
                              state.money.money >= price) {
                            context
                                .read<StoreBloc>()
                                .add(BuyWheel(id: id, price: price));
                            context
                                .read<MoneyBloc>()
                                .add(AddMoney(amount: -price));
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
