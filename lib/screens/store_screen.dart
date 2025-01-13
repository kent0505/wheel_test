import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/money/money_bloc.dart';
import '../widgets/store_bonus.dart';
import '../widgets/store_wheel.dart';

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
              StoreBonus(
                id: 1,
                title: 'Second Chance',
                description:
                    'You get the opportunity to spin the wheel a second time. Only the second result is counted.',
                price: 250,
              ),
              StoreBonus(
                id: 2,
                title: 'One from Two',
                description:
                    'You can spin the wheel twice and choose either of the two results.',
                price: 250,
              ),
              StoreBonus(
                id: 3,
                title: 'Block Sector',
                description:
                    'You can "block" one unwanted sector. It will not be considered during the next spin.',
                price: 250,
              ),
              StoreWheel(
                id: 1,
                title: 'Classic Wheel',
                price: 2500,
                selected: state.model.currentWheel == 1,
              ),
              StoreWheel(
                id: 2,
                title: 'Diamond Wheel',
                price: 2500,
                selected: state.model.currentWheel == 2,
                bought: state.model.boughtWheel2,
              ),
              StoreWheel(
                id: 3,
                title: 'Fire Wheel',
                price: 2500,
                selected: state.model.currentWheel == 3,
                bought: state.model.boughtWheel3,
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
