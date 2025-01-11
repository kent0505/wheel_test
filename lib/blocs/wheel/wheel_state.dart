part of 'wheel_bloc.dart';

@immutable
sealed class WheelState {}

final class WheelInitial extends WheelState {}

final class WheelSpinning extends WheelState {}

final class WheelStopped extends WheelState {}
