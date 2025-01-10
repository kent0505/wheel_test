import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/menu/menu_bloc.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          CustomAppbar(title: 'Lucky Wheel'),
          BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              if (state is MenuStore) return Container();

              if (state is MenuSettings) return Container();

              return Expanded(
                child: ListView(
                  children: [],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
