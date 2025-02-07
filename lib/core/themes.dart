import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: false,
  fontFamily: 'w600',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xff131116),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
  ),
  dialogTheme: const DialogTheme(
    insetPadding: EdgeInsets.symmetric(horizontal: 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  ),
);

const cupertinoTheme = CupertinoThemeData(
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(
      fontFamily: 'w600',
      color: Colors.black,
    ),
  ),
);
