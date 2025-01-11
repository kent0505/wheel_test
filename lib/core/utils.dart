import 'dart:developer' as developer;

import 'package:intl/intl.dart';

String formatNumber(int number) {
  return NumberFormat('#,###').format(number).replaceAll(',', ' ');
}

void logger(Object message) => developer.log(message.toString());
