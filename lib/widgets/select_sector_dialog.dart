import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/money/money_bloc.dart';
import '../models/sector.dart';
import 'main_button.dart';
import 'my_button.dart';
import 'rotated_widget.dart';
import 'svg_widget.dart';

class SelectSectorDialog extends StatefulWidget {
  const SelectSectorDialog({super.key});

  @override
  State<SelectSectorDialog> createState() => _SelectSectorDialogState();
}

class _SelectSectorDialogState extends State<SelectSectorDialog> {
  Sector sector = emptySector;

  void onSector(Sector value) {}

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
                      isActive: sector.title.isNotEmpty,
                      onPressed: () {
                        Navigator.pop(context, sector);
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
                  active: sector.title.isNotEmpty,
                  sector: sector,
                  top: 50,
                  left: 100,
                  degree: -16,
                  onPressed: onSector,
                ),
                _Sector(
                  active: sector.title.isNotEmpty,
                  sector: sector,
                  top: 50,
                  right: 100,
                  degree: 16,
                  onPressed: onSector,
                ),
              ],
            );
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
    required this.onPressed,
  });

  final double? left;
  final double? right;
  final double? top;
  final int degree;
  final bool active;
  final Sector sector;
  final void Function(Sector) onPressed;

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
                  onPressed: active
                      ? () {
                          // context.read<WheelBloc>().add(RemoveSector(sector: sector));
                          // context.read<WheelBloc>().add(SelectSector(
                          //       sector: sector,
                          //       selectedSector: state.selectedSector,
                          //     ));
                        }
                      : null,
                  child: SizedBox(
                    height: 116,
                    width: 84,
                    child: Stack(
                      children: [
                        sector.id == state.model.selectedSector.id
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
                            color: sector.color,
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
