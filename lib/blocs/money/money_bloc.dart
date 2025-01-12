import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../core/utils.dart';
import '../../models/money.dart';

part 'money_event.dart';
part 'money_state.dart';

class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {
  MoneyBloc() : super(MoneyInitial()) {
    on<LoadMoney>((event, emit) async {
      Money money = await getMoney();
      logger(money.last);
      emit(MoneyLoaded(money: money));
    });

    on<ClearMoney>((event, emit) async {
      await clearData();
      Money money = await getMoney();
      emit(MoneyLoaded(money: money));
    });

    on<AddMoney>((event, emit) async {
      Money money = await getMoney();
      money.money += event.amount;
      money.last = event.amount;
      await saveDouble('money', money.money);
      await saveDouble('last', money.last);
      emit(MoneyLoaded(money: money));
    });
  }
}
