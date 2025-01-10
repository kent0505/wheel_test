import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/money/money_bloc.dart';
import '../../core/widgets/custom_scaffold.dart';
import '../../core/widgets/others/loading.dart';
import '../home/pages/home_page.dart';
import 'onboard_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocConsumer<MoneyBloc, MoneyState>(
        listener: (context, state) {
          if (state is MoneyLoaded) {
            Future.delayed(
              const Duration(seconds: 2),
              () {
                context.mounted
                    ? Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              state.isOnboard ? OnboardPage() : HomePage(),
                        ),
                        (route) => false,
                      )
                    : {};
              },
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Spacer(),
              Container(
                height: 117,
                width: 117,
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(height: 26),
              Loading(),
              Spacer(flex: 2),
            ],
          );
        },
      ),
    );
  }
}
