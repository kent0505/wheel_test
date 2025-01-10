import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<ChangeMenu>((event, emit) {
      if (event.index == 1) emit(MenuInitial());
      if (event.index == 2) emit(MenuStore());
      if (event.index == 3) emit(MenuSettings());
    });
  }
}
