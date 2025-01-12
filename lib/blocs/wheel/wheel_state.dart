part of 'wheel_bloc.dart';

@immutable
sealed class WheelState {}

final class WheelInitial extends WheelState {}

final class WheelLoaded extends WheelState {
  WheelLoaded({
    required this.sectors,
    required this.selectedSector,
  });

  final List<Sector> sectors;
  final Sector selectedSector;
}
