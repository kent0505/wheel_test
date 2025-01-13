import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/money/money_bloc.dart';
import '../core/utils.dart';
import '../models/sector.dart';
import 'main_button.dart';
import 'my_button.dart';
import 'rotated_widget.dart';
import 'svg_widget.dart';

class SelectSectorDialog extends StatelessWidget {
  const SelectSectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff1D1B23),
      child: Container(
        height: 340,
        width: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: Color(0xff222026),
          ),
        ),
        child: BlocBuilder<MoneyBloc, MoneyState>(
          builder: (context, state) {
            if (state is MoneyLoaded) {
              return Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Choose one sector',
                        style: TextStyle(
                          color: Color(0xffEFEFEF),
                          fontSize: 16,
                          fontFamily: 'w600',
                        ),
                      ),
                      Spacer(),
                      MainButton(
                        title: 'Apply',
                        margin: 10,
                        isActive:
                            state.model.selectedRandomSector.title.isNotEmpty,
                        onPressed: () {
                          Navigator.pop(
                            context,
                            state.model.selectedRandomSector,
                          );
                        },
                      ),
                      SizedBox(height: 10),
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
                  _Sector(
                    active: state.model.randomSector1.id ==
                        state.model.selectedRandomSector.id,
                    sector: state.model.randomSector1,
                    top: 50,
                    left: 100,
                    degree: -16,
                  ),
                  _Sector(
                    active: state.model.randomSector2.id ==
                        state.model.selectedRandomSector.id,
                    sector: state.model.randomSector2,
                    top: 50,
                    right: 100,
                    degree: 16,
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}

class _Sector extends StatelessWidget {
  const _Sector({
    this.left,
    this.right,
    this.top,
    this.degree = 0,
    required this.active,
    required this.sector,
  });

  final double? left;
  final double? right;
  final double? top;
  final int degree;
  final bool active;
  final Sector sector;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: Center(
        child: RotatedWidget(
          degree: degree,
          child: BlocBuilder<MoneyBloc, MoneyState>(
            builder: (context, state) {
              if (state is MoneyLoaded) {
                return MyButton(
                  onPressed: () {
                    context.read<MoneyBloc>().add(ChooseSector(sector: sector));
                  },
                  child: SizedBox(
                    height: 116,
                    width: 84,
                    child: Stack(
                      children: [
                        active
                            ? SvgWidget(
                                'assets/sector1.svg',
                                height: 116,
                                width: 84,
                                color: Colors.white,
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.all(3).copyWith(top: 4),
                          child: SvgWidget(
                            'assets/sector1.svg',
                            color: getColor(sector.id),
                          ),
                        ),
                        Center(
                          child: Text(
                            sector.title,
                            style: TextStyle(
                              color: sector.title == 'Lose' ||
                                      sector.title.contains('-')
                                  ? Color(0xff4C4A51)
                                  : Colors.white,
                              fontSize: 16,
                              fontFamily: 'w600',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
