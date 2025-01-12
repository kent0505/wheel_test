import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bloc/store_bloc.dart';
import 'blocs/menu/menu_bloc.dart';
import 'blocs/money/money_bloc.dart';
import 'blocs/wheel/wheel_bloc.dart';
import 'core/themes.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MenuBloc()),
        BlocProvider(create: (context) => WheelBloc()),
        BlocProvider(create: (context) => StoreBloc()..add(LoadStore())),
        BlocProvider(create: (context) => MoneyBloc()..add(LoadMoney())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: SplashScreen(),
      ),
    );
  }
}
