import 'dart:developer' as developer;

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/money.dart';
import '../models/store.dart';

String formatNumber(double number) {
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

Future<Money> getMoney() async {
  final prefs = await SharedPreferences.getInstance();
  // await prefs.remove('onboard');
  // await prefs.clear();
  double money = prefs.getDouble('money') ?? 10000;
  double last = prefs.getDouble('last') ?? 0;
  bool onboard = prefs.getBool('onboard') ?? true;
  List<String> results = prefs.getStringList('results') ?? [];
  return Money(
    money: money,
    last: last,
    onboard: onboard,
    results: results,
  );
}

Future<Store> getStore() async {
  final prefs = await SharedPreferences.getInstance();
  int bonus1 = prefs.getInt('bonus1') ?? 1;
  int bonus2 = prefs.getInt('bonus2') ?? 1;
  int bonus3 = prefs.getInt('bonus3') ?? 1;
  int wheel = prefs.getInt('wheel') ?? 1;
  bool wheel2 = prefs.getBool('wheel2') ?? false;
  bool wheel3 = prefs.getBool('wheel3') ?? false;
  return Store(
    bonus1: bonus1,
    bonus2: bonus2,
    bonus3: bonus3,
    wheel: wheel,
    wheel2: wheel2,
    wheel3: wheel3,
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

Future<void> saveDouble(String key, double value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(key, value);
}

Future<void> saveBool(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}

Future<void> saveStringList(String key, List<String> value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(key, value);
}
