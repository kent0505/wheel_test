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

      emit(MoneyLoaded(
        money: money,
        isOnboard: isOnboard,
      ));
    });
  }
}
