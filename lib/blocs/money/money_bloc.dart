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
      if (event.result.isNotEmpty) {
        if (money.results.length > 10) money.results.removeLast();
        money.results.insert(0, event.result);
        await saveStringList('results', money.results);
      }
      emit(MoneyLoaded(money: money));
    });

    on<RemoveLast>((event, emit) async {
      Money money = await getMoney();
      if (money.last == 0) {
        emit(MoneyLoaded(money: money));
      } else {
        money.money += event.last;
        money.last = 0;
        money.results.removeAt(0);
        await saveDouble('money', money.money);
        await saveDouble('last', money.last);
        await saveStringList('results', money.results);
        emit(MoneyLoaded(money: money));
      }
    });
  }
}
