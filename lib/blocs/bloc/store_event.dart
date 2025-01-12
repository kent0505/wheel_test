part of 'store_bloc.dart';

@immutable
sealed class StoreEvent {}

class LoadStore extends StoreEvent {}

class BuyBonus extends StoreEvent {
  BuyBonus({
    required this.id,
    required this.price,
  });

  final int id;
  final double price;
}

class BuyWheel extends StoreEvent {
  BuyWheel({
    required this.id,
    required this.price,
  });

  final int id;
  final double price;
}

class SelectWheel extends StoreEvent {
  SelectWheel({required this.id});

  final int id;
}

class UseBonus extends StoreEvent {
  UseBonus({required this.id});

  final int id;
}
