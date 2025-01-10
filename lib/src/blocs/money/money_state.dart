part of 'money_bloc.dart';

@immutable
sealed class MoneyState {}

final class MoneyInitial extends MoneyState {}

final class MoneyLoaded extends MoneyState {
  MoneyLoaded({
    required this.money,
    this.isOnboard = false,
  });

  final int money;
  final bool isOnboard;
}
