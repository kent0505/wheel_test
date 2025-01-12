part of 'store_bloc.dart';

@immutable
sealed class StoreState {}

final class StoreInitial extends StoreState {}

final class StoreLoaded extends StoreState {
  StoreLoaded({required this.store});

  final Store store;
}
