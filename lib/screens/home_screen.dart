import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/menu/menu_bloc.dart';
import '../widgets/custom_appbar.dart';
import 'store_screen.dart';
import 'settings_screen.dart';
import 'wheel_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 84 + MediaQuery.of(context).viewPadding.top,
            ),
            child: BlocBuilder<MenuBloc, MenuState>(
              builder: (context, state) {
                if (state is MenuStore) return StoreScreen();

                if (state is MenuSettings) return SettingsScreen();

                return WheelScreen();
              },
            ),
          ),
          CustomAppbar(),
        ],
      ),
    );
  }
}
