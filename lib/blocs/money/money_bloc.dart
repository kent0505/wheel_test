import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'money_event.dart';
part 'money_state.dart';

class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {
  MoneyBloc() : super(MoneyInitial()) {
    on<LoadMoney>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      // await prefs.remove('onboard');
      // await prefs.clear();
      bool isOnboard = prefs.getBool('onboard') ?? true;
      int money = prefs.getInt('money') ?? 10000;
      int item1 = prefs.getInt('item1') ?? 1;
      int item2 = prefs.getInt('item2') ?? 1;
      int item3 = prefs.getInt('item3') ?? 1;
      int wheel = prefs.getInt('wheel') ?? 1;
      bool wheel2 = prefs.getBool('wheel2') ?? false;
      bool wheel3 = prefs.getBool('wheel3') ?? false;

      emit(MoneyLoaded(
        money: money,
        isOnboard: isOnboard,
        item1: item1,
        item2: item2,
        item3: item3,
        wheel: wheel,
        wheel2: wheel2,
        wheel3: wheel3,
      ));
    });

    on<ClearMoney>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      emit(MoneyLoaded());
    });

    on<BuyItem>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      int money = prefs.getInt('money') ?? 10000;
      int item1 = prefs.getInt('item1') ?? 1;
      int item2 = prefs.getInt('item2') ?? 1;
      int item3 = prefs.getInt('item3') ?? 1;
      int wheel = prefs.getInt('wheel') ?? 1;
      bool wheel2 = prefs.getBool('wheel2') ?? false;
      bool wheel3 = prefs.getBool('wheel3') ?? false;

      if (money >= event.price) {
        money -= event.price;
        await prefs.setInt('money', money);
        if (event.id == 1) {
          item1 += 1;
          await prefs.setInt('item1', item1);
        } else if (event.id == 2) {
          item2 += 1;
          await prefs.setInt('item2', item2);
        } else if (event.id == 3) {
          item3 += 1;
          await prefs.setInt('item3', item3);
        }
      } else {
        emit(MoneyError());
      }

      emit(MoneyLoaded(
        money: money,
        item1: item1,
        item2: item2,
        item3: item3,
        wheel: wheel,
        wheel2: wheel2,
        wheel3: wheel3,
      ));
    });

    on<BuyWheel>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      int money = prefs.getInt('money') ?? 10000;
      int item1 = prefs.getInt('item1') ?? 1;
      int item2 = prefs.getInt('item2') ?? 1;
      int item3 = prefs.getInt('item3') ?? 1;
      int wheel = prefs.getInt('wheel') ?? 1;
      bool wheel2 = prefs.getBool('wheel2') ?? false;
      bool wheel3 = prefs.getBool('wheel3') ?? false;

      if (money >= event.price) {
        money -= event.price;
        await prefs.setInt('money', money);
        if (event.id == 2) {
          wheel2 = true;
          await prefs.setBool('wheel2', wheel2);
        } else if (event.id == 3) {
          wheel3 = true;
          await prefs.setBool('wheel3', wheel3);
        }
      } else {
        emit(MoneyError());
      }

      emit(MoneyLoaded(
        money: money,
        item1: item1,
        item2: item2,
        item3: item3,
        wheel: wheel,
        wheel2: wheel2,
        wheel3: wheel3,
      ));
    });

    on<SelectWheel>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      int money = prefs.getInt('money') ?? 10000;
      int item1 = prefs.getInt('item1') ?? 1;
      int item2 = prefs.getInt('item2') ?? 1;
      int item3 = prefs.getInt('item3') ?? 1;
      bool wheel2 = prefs.getBool('wheel2') ?? false;
      bool wheel3 = prefs.getBool('wheel3') ?? false;

      await prefs.setInt('wheel', event.id);

      emit(MoneyLoaded(
        money: money,
        item1: item1,
        item2: item2,
        item3: item3,
        wheel: event.id,
        wheel2: wheel2,
        wheel3: wheel3,
      ));
    });
  }
}
