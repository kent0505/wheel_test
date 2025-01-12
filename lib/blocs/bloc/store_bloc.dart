import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils.dart';
import '../../models/store.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<LoadStore>((event, emit) async {
      Store store = await getStore();
      emit(StoreLoaded(store: store));
    });

    on<BuyBonus>((event, emit) async {
      Store store = await getStore();
      if (event.id == 1) {
        store.bonus1 += 1;
        await saveInt('bonus1', store.bonus1);
      } else if (event.id == 2) {
        store.bonus2 += 1;
        await saveInt('bonus2', store.bonus2);
      } else if (event.id == 3) {
        store.bonus3 += 1;
        await saveInt('bonus3', store.bonus3);
      }
      emit(StoreLoaded(store: store));
    });

    on<BuyWheel>((event, emit) async {
      Store store = await getStore();
      if (event.id == 2) {
        store.wheel2 = true;
        await saveBool('wheel2', store.wheel2);
      } else if (event.id == 3) {
        store.wheel3 = true;
        await saveBool('wheel3', store.wheel3);
      }
      emit(StoreLoaded(store: store));
    });

    on<SelectWheel>((event, emit) async {
      Store store = await getStore();
      store.wheel = event.id;
      await saveInt('wheel', store.wheel);
      emit(StoreLoaded(store: store));
    });

    on<UseBonus>((event, emit) async {
      Store store = await getStore();
      if (event.id == 1) {
        store.bonus1 -= 1;
        await saveInt('bonus1', store.bonus1);
      } else if (event.id == 2) {
        store.bonus2 -= 1;
        await saveInt('bonus2', store.bonus2);
      } else if (event.id == 3) {
        store.bonus3 -= 1;
        await saveInt('bonus3', store.bonus3);
      }
      emit(StoreLoaded(store: store));
    });
  }
}
