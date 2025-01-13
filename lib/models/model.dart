import 'sector.dart';

class Model {
  Model({
    required this.onboard,
    required this.money,
    required this.last,
    required this.lastResults,
    required this.bonus1,
    required this.bonus2,
    required this.bonus3,
    required this.currentWheel,
    required this.boughtWheel2,
    required this.boughtWheel3,
    required this.sectors,
    required this.selectedSector,
    required this.angles,
  });

  bool onboard;

  int money;
  int last;
  List<String> lastResults;

  int bonus1;
  int bonus2;
  int bonus3;

  int currentWheel;
  bool boughtWheel2;
  bool boughtWheel3;

  List<Sector> sectors;
  Sector selectedSector;

  List<int> angles;
}
