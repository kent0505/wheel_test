import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/store_bloc.dart';
import '../blocs/money/money_bloc.dart';
import 'dialog_widget.dart';
import 'main_button.dart';
import 'svg_widget.dart';

class StoreBonus extends StatelessWidget {
  const StoreBonus({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });

  final int id;
  final String title;
  final String description;
  final double price;

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
                    if (state is MoneyLoaded) {
                      return MainButton(
                        title: 'Get for \$$price',
                        onPressed: () {
                          if (state.money.money >= price) {
                            context
                                .read<StoreBloc>()
                                .add(BuyBonus(id: id, price: price));
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
                        },
                      );
                    }

                    return Container();
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
