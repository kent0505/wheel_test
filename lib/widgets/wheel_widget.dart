import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/money/money_bloc.dart';
import '../core/utils.dart';
import '../models/sector.dart';
import 'my_button.dart';
import 'rotated_widget.dart';
import 'svg_widget.dart';

class WheelWidget extends StatelessWidget {
  const WheelWidget({
    super.key,
    this.active = true,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 350,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color: Colors.redAccent,
      ),
      child: BlocBuilder<MoneyBloc, MoneyState>(
        builder: (context, state) {
          if (state is MoneyLoaded) {
            return Stack(
              children: [
                _Sector(
                  top: -4,
                  left: 0,
                  right: 0,
                  active: active,
                  sector: state.model.sectors[0],
                ),
                _Sector(
                  top: 12,
                  right: 85,
                  degree: 30,
                  active: active,
                  sector: state.model.sectors[1],
                ),
                _Sector(
                  top: 57,
                  right: 40,
                  degree: 30 * 2,
                  active: active,
                  sector: state.model.sectors[2],
                ),
                _Sector(
                  top: 0,
                  bottom: 0,
                  right: 24,
                  degree: 30 * 3,
                  active: active,
                  sector: state.model.sectors[3],
                ),
                _Sector(
                  bottom: 58,
                  right: 40,
                  degree: 30 * 4,
                  active: active,
                  sector: state.model.sectors[4],
                ),
                _Sector(
                  bottom: 12,
                  right: 84,
                  degree: 30 * 5,
                  active: active,
                  sector: state.model.sectors[5],
                ),
                _Sector(
                  bottom: -4,
                  left: 0,
                  right: 0,
                  degree: 30 * 6,
                  active: active,
                  sector: state.model.sectors[6],
                ),
                _Sector(
                  bottom: 12,
                  left: 84,
                  degree: 30 * 7,
                  active: active,
                  sector: state.model.sectors[7],
                ),
                _Sector(
                  bottom: 58,
                  left: 40,
                  degree: 30 * 8,
                  active: active,
                  sector: state.model.sectors[8],
                ),
                _Sector(
                  top: 0,
                  bottom: 0,
                  left: 24,
                  degree: 30 * 9,
                  active: active,
                  sector: state.model.sectors[9],
                ),
                _Sector(
                  top: 58,
                  left: 40,
                  degree: 30 * 10,
                  active: active,
                  sector: state.model.sectors[10],
                ),
                _Sector(
                  top: 12,
                  left: 84,
                  degree: 30 * 11,
                  active: active,
                  sector: state.model.sectors[11],
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}

class _Sector extends StatelessWidget {
  const _Sector({
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.degree = 0,
    required this.active,
    required this.sector,
  });

  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final int degree;
  final bool active;
  final Sector sector;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Center(
        child: RotatedWidget(
          degree: degree,
          child: BlocBuilder<MoneyBloc, MoneyState>(
            builder: (context, state) {
              if (state is MoneyLoaded) {
                return MyButton(
                  onPressed: active
                      ? () {
                          context.read<MoneyBloc>().add(SelectSector(
                                sector: sector,
                                selectedSector: state.model.selectedSector,
                              ));
                        }
                      : null,
                  child: SizedBox(
                    height: 116,
                    width: 84,
                    child: Stack(
                      children: [
                        sector.id == state.model.selectedSector.id && active
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
