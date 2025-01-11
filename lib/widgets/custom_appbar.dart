import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/menu/menu_bloc.dart';
import '../blocs/money/money_bloc.dart';
import '../core/utils.dart';
import 'my_button.dart';
import 'coin_card.dart';
import 'svg_widget.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({
    super.key,
    this.title = '',
    this.back = false,
  });

  final String title;
  final bool back;

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
    return Stack(
      children: [
        if (menu)
          GestureDetector(
            onTap: onMenu,
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),
        Container(
          height: menu ? 400 : 84 + MediaQuery.of(context).viewPadding.top,
          decoration: BoxDecoration(
            color: menu ? Color(0xff131116) : Color(0xff040404),
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Color(0xff222026),
              ),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 16 + MediaQuery.of(context).viewPadding.top),
              Row(
                children: [
                  SizedBox(width: 16),
                  if (widget.back) ...[
                    MyButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: SvgWidget('assets/back.svg'),
                    ),
                    SizedBox(width: 12),
                  ],
                  Expanded(
                    child: BlocBuilder<MenuBloc, MenuState>(
                      builder: (context, state) {
                        return Text(
                          widget.title.isEmpty
                              ? menu
                                  ? 'Menu'
                                  : state is MenuInitial
                                      ? 'Lucky Wheel'
                                      : state is MenuStore
                                          ? 'Store'
                                          : 'Settings'
                              : widget.title,
                          style: TextStyle(
                            color: Color(0xffEFEFEF),
                            fontSize: 20,
                            fontFamily: 'w800',
                          ),
                        );
                      },
                    ),
                  ),
                  if (!widget.back) ...[
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
                ],
              ),
              if (menu)
                BlocConsumer<MenuBloc, MenuState>(
                  listener: (context, state) {
                    onMenu();
                  },
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
          ),
        ),
      ],
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
      onPressed: isActive
          ? null
          : () {
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
