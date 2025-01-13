import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/money/money_bloc.dart';

class WheelLastResults extends StatelessWidget {
  const WheelLastResults({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              Text(
                'Last 10 results',
                style: TextStyle(
                  color: Color(0xff4C4A51),
                  fontSize: 12,
                  fontFamily: 'w600',
                ),
              ),
            ],
          ),
          Spacer(),
          SizedBox(
            height: 30,
            child: BlocBuilder<MoneyBloc, MoneyState>(
              builder: (context, state) {
                if (state is MoneyLoaded) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 16, right: 12),
                    itemCount: state.model.lastResults.length,
                    itemBuilder: (context, index) {
                      return _LastResult(
                        title: state.model.lastResults[index],
                      );
                    },
                  );
                }

                return Container();
              },
            ),
          ),
        ],
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
