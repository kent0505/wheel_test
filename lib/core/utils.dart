import 'dart:developer' as developer;

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/model.dart';
import '../models/sector.dart';

bool onboard = false;
int money = 10000;
int last = 0;
List<String> lastResults = [];
int bonus1 = 1;
int bonus2 = 1;
int bonus3 = 1;
int currentWheel = 1;
bool boughtWheel2 = false;
bool boughtWheel3 = false;
List<Sector> sectors = sectorsList;
Sector selectedSector = emptySector;
List<int> angles = [
  1, // 5
  2, // 2.5
  13, // loose
  3, // 25
  15, // -2
  4, // 7
  11, // -1.5
  8, // 20
  9, // -2
  10, // 1.7
  12, // 1.5
  13, // loose
  19, // 13
  20, // 5
  11, // -1.5
  22, // 25
  15, // -2
];

List<int> anglesList = [
  1, // 5
  2, // 2.5
  13, // loose
  3, // 25
  15, // -2
  4, // 7
  11, // -1.5
  8, // 20
  9, // -2
  10, // 1.7
  12, // 1.5
  13, // loose
  19, // 13
  20, // 5
  11, // -1.5
  22, // 25
  15, // -2
];

Future<void> getData() async {
  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();
  onboard = prefs.getBool('onboard') ?? false;
  money = prefs.getInt('money') ?? 10000;
  last = prefs.getInt('last') ?? 0;
  lastResults = prefs.getStringList('lastResults') ?? [];
  bonus1 = prefs.getInt('bonus1') ?? 1;
  bonus2 = prefs.getInt('bonus2') ?? 1;
  bonus3 = prefs.getInt('bonus3') ?? 1;
  currentWheel = prefs.getInt('currentWheel') ?? 1;
  boughtWheel2 = prefs.getBool('boughtWheel2') ?? false;
  boughtWheel3 = prefs.getBool('boughtWheel3') ?? false;
}

Model getModel() {
  logger(lastResults.length);
  return Model(
    onboard: onboard,
    money: money,
    last: last,
    lastResults: lastResults,
    bonus1: bonus1,
    bonus2: bonus2,
    bonus3: bonus3,
    currentWheel: currentWheel,
    boughtWheel2: boughtWheel2,
    boughtWheel3: boughtWheel3,
    sectors: sectors,
    selectedSector: selectedSector,
    angles: angles,
  );
}

Future<void> clearData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<void> saveInt(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

Future<void> saveBool(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}

Future<void> saveStringList(String key, List<String> value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(key, value);
}

String formatNumber(int number) {
  return NumberFormat('#,###').format(number).replaceAll(',', ' ');
}

String formatDouble(double value) {
  if (value == 0) return 'Lose';
  String formattedValue =
      value.abs().toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  return value < 0 ? '- \$$formattedValue' : '+ \$$formattedValue';
}

String formatMultiplier(double value) {
  String formattedValue =
      value.abs().toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  return value < 0 ? '-x$formattedValue' : 'x$formattedValue';
}

void logger(Object message) => developer.log(message.toString());
