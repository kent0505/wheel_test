import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/coin_card.dart';
import '../../blocs/menu/menu_bloc.dart';
import '../../blocs/money/money_bloc.dart';
import '../utils.dart';
import 'buttons/my_button.dart';
import 'others/svg_widget.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  bool menu = false;

  void onMenu() {
    setState(() {
      menu = !menu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: menu ? 400 : 84 + MediaQuery.of(context).viewPadding.top,
      decoration: BoxDecoration(
        color: menu ? Color(0xff131116) : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Color(0xff222026),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 16 + MediaQuery.of(context).viewPadding.top),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  menu ? 'Menu' : widget.title,
                  style: TextStyle(
                    color: Color(0xffEFEFEF),
                    fontSize: 20,
                    fontFamily: 'w800',
                  ),
                ),
              ),
              menu
                  ? Container()
                  : Container(
                      height: 52,
                      width: 134,
                      decoration: BoxDecoration(
                        color: Color(0xff1D1B23),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: Color(0xff222026),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 6),
                          MoneyCard(),
                          SizedBox(width: 16),
                          Expanded(
                            child: BlocBuilder<MoneyBloc, MoneyState>(
                              builder: (context, state) {
                                return Text(
                                  state is MoneyLoaded
                                      ? formatNumber(state.money)
                                      : '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xffEFEFEF),
                                    fontSize: 16,
                                    fontFamily: 'w600',
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                    ),
              SizedBox(width: 6),
              MyButton(
                onPressed: onMenu,
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: Color(0xff1D1B23),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: Color(0xff222026),
                    ),
                  ),
                  child: Center(
                    child: SvgWidget(
                      menu ? 'assets/close.svg' : 'assets/menu.svg',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          if (menu) ...[
            BlocBuilder<MenuBloc, MenuState>(
              builder: (context, state) {
                return Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      _Menu(
                        index: 1,
                        title: 'Lucky Wheel',
                        isActive: state is MenuInitial,
                      ),
                      SizedBox(height: 16),
                      _Menu(
                        index: 2,
                        title: 'Store',
                        isActive: state is MenuStore,
                      ),
                      SizedBox(height: 16),
                      _Menu(
                        index: 3,
                        title: 'Settings',
                        isActive: state is MenuSettings,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({
    required this.index,
    required this.title,
    required this.isActive,
  });

  final int index;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: () {
        context.read<MenuBloc>().add(ChangeMenu(index: index));
      },
      child: Container(
        height: 52,
        width: 275,
        decoration: BoxDecoration(
          color: isActive ? Color(0xffA3C317) : Color(0xff1D1B23),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xffEFEFEF),
              fontSize: 16,
              fontFamily: 'w600',
            ),
          ),
        ),
      ),
    );
  }
}
