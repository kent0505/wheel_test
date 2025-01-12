import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/store_bloc.dart';
import '../blocs/menu/menu_bloc.dart';
import '../blocs/money/money_bloc.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/my_button.dart';
import 'onboard_screen.dart';
import 'privacy_screen.dart';
import 'terms_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ).copyWith(bottom: 8),
      children: [
        _Settings(
          title: 'Notifications',
          description:
              'Stay updated with the latest news, offers, and app features through personalized alerts.',
          onPressed: () {},
        ),
        _Settings(
          title: 'Privacy Policy',
          description:
              'Learn how we protect and handle your personal data securely.',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrivacyScreen(),
              ),
            );
          },
        ),
        _Settings(
          title: 'Terms of use',
          description:
              'Understand the rules and guidelines for using our app effectively.',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TermsScreen(),
              ),
            );
          },
        ),
        _Settings(
          title: 'Share this app',
          description:
              'Invite your friends to join the fun by sharing our app with just a tap!',
          onPressed: () {},
        ),
        _Settings(
          title: 'Rate us',
          description:
              'Let us know how we’re doing by leaving your feedback and rating the app.',
          onPressed: () {},
        ),
        _Settings(
          title: 'Clear Data',
          description:
              'Remove all stored data and reset the app to its default settings for a fresh start.',
          red: true,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DialogWidget(
                  title: 'Clear Data',
                  description:
                      'Are you sure you want to clear all app data? This will remove your saved preferences and settings, returning the app to its default state.',
                  buttonTitle: 'Clear',
                  onPressed: () {
                    context.read<MoneyBloc>().add(ClearMoney());
                    context.read<StoreBloc>().add(LoadStore());
                    context.read<MenuBloc>().add(ChangeMenu(index: 1));
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardScreen(),
                      ),
                      (route) => false,
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _Settings extends StatelessWidget {
  const _Settings({
    required this.title,
    required this.description,
    this.red = false,
    required this.onPressed,
  });

  final String title;
  final String description;
  final bool red;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xff1D1B23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Color(0xff222026),
        ),
      ),
      child: MyButton(
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: red ? Color(0xffE10606) : Color(0xffEFEFEF),
                fontSize: 16,
                fontFamily: 'w600',
              ),
            ),
            Expanded(
              child: Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xff4C4A51),
                  fontSize: 12,
                  fontFamily: 'w600',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
