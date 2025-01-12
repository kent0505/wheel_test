import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/store_bloc.dart';
import '../widgets/store_bonus.dart';
import '../widgets/store_wheel.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state is StoreLoaded) {
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
                selected: state.store.wheel == 1,
              ),
              StoreWheel(
                id: 2,
                title: 'Diamond Wheel',
                price: 2500,
                selected: state.store.wheel == 2,
                bought: state.store.wheel2,
              ),
              StoreWheel(
                id: 3,
                title: 'Fire Wheel',
                price: 2500,
                selected: state.store.wheel == 3,
                bought: state.store.wheel3,
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
