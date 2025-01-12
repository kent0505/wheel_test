part of 'wheel_bloc.dart';

@immutable
sealed class WheelEvent {}

class LoadWheelSectors extends WheelEvent {}

class RemoveSector extends WheelEvent {
  RemoveSector({required this.sector});

  final Sector sector;
}

class SelectSector extends WheelEvent {
  SelectSector({
    required this.sector,
    required this.selectedSector,
  });

  final Sector sector;
  final Sector selectedSector;
}
