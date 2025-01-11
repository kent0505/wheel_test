part of 'money_bloc.dart';

@immutable
sealed class MoneyEvent {}

class LoadMoney extends MoneyEvent {}

class ClearMoney extends MoneyEvent {}

class BuyItem extends MoneyEvent {
  BuyItem({
    required this.id,
    required this.price,
  });

  final int id;
  final int price;
}

class BuyWheel extends MoneyEvent {
  BuyWheel({
    required this.id,
    required this.price,
  });

  final int id;
  final int price;
}

class SelectWheel extends MoneyEvent {
  SelectWheel({required this.id});

  final int id;
}
