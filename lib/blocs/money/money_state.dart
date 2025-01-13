part of 'money_bloc.dart';

@immutable
sealed class MoneyState {}

final class MoneyInitial extends MoneyState {}

final class MoneyLoaded extends MoneyState {
  MoneyLoaded({required this.model});
  final Model model;
}

class MoneyError extends MoneyState {}
