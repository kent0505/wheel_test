import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wheel_event.dart';
part 'wheel_state.dart';

class WheelBloc extends Bloc<WheelEvent, WheelState> {
  WheelBloc() : super(WheelInitial()) {
    on<StartWheel>((event, emit) async {
      emit(WheelSpinning());

      await Future.delayed(
        Duration(seconds: 4),
        () {
          emit(WheelStopped());
        },
      );
    });
  }
}
