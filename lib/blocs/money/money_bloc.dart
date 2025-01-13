import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../core/utils.dart';
import '../../models/model.dart';
import '../../models/sector.dart';

part 'money_event.dart';
part 'money_state.dart';

class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {
  MoneyBloc() : super(MoneyInitial()) {
    on<LoadMoney>((event, emit) async {
      await getData();
      emit(MoneyLoaded(model: getModel()));
    });

    on<ClearMoney>((event, emit) async {
      await clearData();
      await getData();
      emit(MoneyLoaded(model: getModel()));
    });

    on<AddMoney>((event, emit) async {
      money += event.amount;
      last = event.amount;
      await saveInt('money', money);
      await saveInt('last', last);
      if (event.result.isNotEmpty) {
        if (lastResults.length > 10) lastResults.removeLast();
        lastResults.insert(0, event.result);
        await saveStringList('lastResults', lastResults);
      }
      emit(MoneyLoaded(model: getModel()));
    });

    on<RemoveLast>((event, emit) async {
      if (last == 0) {
        emit(MoneyLoaded(model: getModel()));
      } else {
        money += event.last < 0 ? event.last.abs() : -event.last;
        last = 0;
        lastResults.removeAt(0);
        bonus1 -= 1;
        await saveInt('bonus1', bonus1);
        await saveInt('money', money);
        await saveInt('last', last);
        await saveStringList('lastResults', lastResults);
        emit(MoneyLoaded(model: getModel()));
      }
    });

    on<BuyBonus>((event, emit) async {
      money -= event.price;
      await saveInt('money', money);
      if (event.id == 1) {
        bonus1 += 1;
        await saveInt('bonus1', bonus1);
      } else if (event.id == 2) {
        bonus2 += 1;
        await saveInt('bonus2', bonus2);
      } else if (event.id == 3) {
        bonus3 += 1;
        await saveInt('bonus3', bonus3);
      }
      emit(MoneyLoaded(model: getModel()));
    });

    on<BuyWheel>((event, emit) async {
      money -= event.price;
      await saveInt('money', money);
      if (event.id == 2) {
        boughtWheel2 = true;
        await saveBool('boughtWheel2', boughtWheel2);
      } else if (event.id == 3) {
        boughtWheel3 = true;
        await saveBool('boughtWheel3', boughtWheel3);
      }
      emit(MoneyLoaded(model: getModel()));
    });

    on<SelectWheel>((event, emit) async {
      currentWheel = event.id;
      await saveInt('currentWheel', currentWheel);
      emit(MoneyLoaded(model: getModel()));
    });

    on<UseBonus>((event, emit) async {
      if (event.id == 2) {
        bonus2 -= 1;
        await saveInt('bonus2', bonus2);
      } else if (event.id == 3) {
        bonus3 -= 1;
        await saveInt('bonus3', bonus3);
      }
      emit(MoneyLoaded(model: getModel()));
    });

    on<RemoveSector>((event, emit) async {
      List<Sector> list = sectorsList.map((sector) {
        return Sector(
          id: sector.id,
          title: sector.title,
          factor: sector.factor,
          color: sector.color,
        );
      }).toList();
      List<int> ang = angles.map((number) => number).toList();

      Sector model = list.firstWhere(
        (element) => element.id == event.sector.id,
      );

      if (event.sector.title.isNotEmpty) {
        model.title = '';
        model.factor = 0;
        sectors = list;
        angles = ang;
        ang.removeWhere((element) => element == model.id);
        emit(MoneyLoaded(model: getModel()));
      } else {
        sectors = sectorsList;
        emit(MoneyLoaded(model: getModel()));
      }
    });

    on<SelectSector>((event, emit) async {
      if (event.sector.id == event.selectedSector.id) {
        selectedSector = emptySector;
        emit(MoneyLoaded(model: getModel()));
      } else {
        selectedSector = event.sector;
        emit(MoneyLoaded(model: getModel()));
      }
    });

    on<RestoreSectors>((event, emit) async {
      sectors = sectorsList;
      selectedSector = emptySector;
      angles = anglesList;
      emit(MoneyLoaded(model: getModel()));
    });
  }
}
