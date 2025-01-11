part of 'money_bloc.dart';

@immutable
sealed class MoneyEvent {}

class LoadMoney extends MoneyEvent {}

class ClearMoney extends MoneyEvent {}
