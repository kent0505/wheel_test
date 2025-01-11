part of 'menu_bloc.dart';

@immutable
sealed class MenuState {}

final class MenuInitial extends MenuState {}

final class MenuStore extends MenuState {}

final class MenuSettings extends MenuState {}
