import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/sector.dart';

part 'wheel_event.dart';
part 'wheel_state.dart';

class WheelBloc extends Bloc<WheelEvent, WheelState> {
  WheelBloc() : super(WheelInitial()) {
    on<LoadWheelSectors>((event, emit) async {
      emit(WheelLoaded(
        sectors: sectorsList,
        selectedSector: emptySector,
      ));
    });

    on<RemoveSector>((event, emit) async {
      List<Sector> sectors = sectorsList.map((sector) {
        return Sector(
          id: sector.id,
          title: sector.title,
          factor: sector.factor,
          color: sector.color,
        );
      }).toList();

      Sector sector = sectors.firstWhere(
        (element) => element.id == event.sector.id,
      );

      if (event.sector.title.isNotEmpty) {
        sector.title = '';
        sector.factor = 0;
        emit(WheelLoaded(
          sectors: sectors,
          selectedSector: emptySector,
        ));
      } else {
        emit(WheelLoaded(
          sectors: sectorsList,
          selectedSector: emptySector,
        ));
      }
    });

    on<SelectSector>((event, emit) async {
      if (event.sector.id == event.selectedSector.id) {
        emit(WheelLoaded(
          sectors: sectorsList,
          selectedSector: emptySector,
        ));
      } else {
        emit(WheelLoaded(
          sectors: sectorsList,
          selectedSector: event.sector,
        ));
      }
    });
  }
}
