part of 'menu_bloc.dart';

@immutable
sealed class MenuEvent {}

class ChangeMenu extends MenuEvent {
  ChangeMenu({required this.index});

  final int index;
}
