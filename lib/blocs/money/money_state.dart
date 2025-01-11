part of 'money_bloc.dart';

@immutable
sealed class MoneyState {}

final class MoneyInitial extends MoneyState {}

final class MoneyLoaded extends MoneyState {
  MoneyLoaded({
    this.money = 10000,
    this.isOnboard = false,
    this.bonus1 = 1,
    this.bonus2 = 1,
    this.bonus3 = 1,
    this.wheel = 1,
    this.wheel2 = false,
    this.wheel3 = false,
  });

  final int money;
  final bool isOnboard;
  final int bonus1;
  final int bonus2;
  final int bonus3;
  final int wheel;
  final bool wheel2;
  final bool wheel3;
}

class MoneyError extends MoneyState {}
