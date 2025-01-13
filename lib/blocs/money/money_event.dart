part of 'money_bloc.dart';

@immutable
sealed class MoneyEvent {}

class LoadMoney extends MoneyEvent {}

class ClearMoney extends MoneyEvent {}

class AddMoney extends MoneyEvent {
  AddMoney({
    required this.amount,
    this.result = '',
  });

  final double amount;
  final String result;
}

class RemoveLast extends MoneyEvent {
  RemoveLast({required this.last});

  final double last;
}
