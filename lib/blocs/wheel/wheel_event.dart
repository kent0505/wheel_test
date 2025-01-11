part of 'wheel_bloc.dart';

@immutable
sealed class WheelEvent {}

class StartWheel extends WheelEvent {
  StartWheel({required this.bonus});

  final int bonus;
}
