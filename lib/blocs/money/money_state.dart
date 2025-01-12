part of 'money_bloc.dart';

@immutable
sealed class MoneyState {}

final class MoneyInitial extends MoneyState {}

final class MoneyLoaded extends MoneyState {
  MoneyLoaded({required this.money});

  final Money money;
}

class MoneyError extends MoneyState {}
