part of 'money_bloc.dart';

@immutable
sealed class MoneyEvent {}

class LoadMoney extends MoneyEvent {}

class ClearMoney extends MoneyEvent {}

class AddMoney extends MoneyEvent {
  AddMoney({required this.amount, this.result = ''});
  final int amount;
  final String result;
}

class RemoveLast extends MoneyEvent {
  RemoveLast({required this.id, required this.last});
  final int id;
  final int last;
}

class BuyBonus extends MoneyEvent {
  BuyBonus({required this.id, required this.price});
  final int id;
  final int price;
}

class BuyWheel extends MoneyEvent {
  BuyWheel({required this.id, required this.price});
  final int id;
  final int price;
}

class SelectWheel extends MoneyEvent {
  SelectWheel({required this.id});
  final int id;
}

class UseBonus extends MoneyEvent {
  UseBonus({required this.id});
  final int id;
}

class RemoveSector extends MoneyEvent {
  RemoveSector({required this.sector});
  final Sector sector;
}

class SelectSector extends MoneyEvent {
  SelectSector({required this.sector, required this.selectedSector});
  final Sector sector;
  final Sector selectedSector;
}

class RestoreSectors extends MoneyEvent {}

class GetRandomSector extends MoneyEvent {
  GetRandomSector({required this.angle});
  final double angle;
}

class ChooseSector extends MoneyEvent {
  ChooseSector({required this.sector});
  final Sector sector;
}
