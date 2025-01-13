import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/money/money_bloc.dart';
import 'main_button.dart';
import 'my_button.dart';
import 'wheel_widget.dart';

class BlockSectorDialog extends StatelessWidget {
  const BlockSectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff1D1B23),
      child: Container(
        height: 564,
        width: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: Color(0xff222026),
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 16),
                Text(
                  'Choose one sector which you want block',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffEFEFEF),
                    fontSize: 16,
                    fontFamily: 'w600',
                  ),
                ),
                Spacer(),
                BlocBuilder<MoneyBloc, MoneyState>(
                  builder: (context, state) {
                    if (state is MoneyLoaded) {
                      return MainButton(
                        title: 'Apply',
                        margin: 10,
                        isActive: state.model.selectedSector.id != 0,
                        onPressed: () {
                          Navigator.pop(context, state.model.selectedSector);
                        },
                      );
                    }

                    return Container();
                  },
                ),
                MyButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  minSize: 52,
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xffE10606),
                        fontSize: 16,
                        fontFamily: 'w600',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
            Positioned(
              top: 72,
              left: -10,
              right: -10,
              child: WheelWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
