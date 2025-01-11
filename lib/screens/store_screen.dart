import 'package:flutter/material.dart';

import '../core/utils.dart';
import '../widgets/main_button.dart';
import '../widgets/svg_widget.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ).copyWith(bottom: 8),
      children: [
        _Item(
          id: 1,
          title: 'Second Chance',
          description:
              'You get the opportunity to spin the wheel a second time. Only the second result is counted.',
          price: 250,
        ),
        _Item(
          id: 2,
          title: 'One from Two',
          description:
              'You can spin the wheel twice and choose either of the two results.',
          price: 250,
        ),
        _Item(
          id: 3,
          title: 'Block Sector',
          description:
              'You can "block" one unwanted sector. It will not be considered during the next spin.',
          price: 250,
        ),
        _Wheel(
          id: 1,
          title: 'Classic Wheel',
          price: 2500,
          bought: true,
          selected: true,
        ),
        _Wheel(
          id: 2,
          title: 'Diamond Wheel',
          price: 2500,
          bought: true,
          selected: false,
        ),
        _Wheel(
          id: 3,
          title: 'Fire Wheel',
          price: 2500,
          bought: false,
          selected: false,
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });

  final int id;
  final String title;
  final String description;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Color(0xff1D1B23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Color(0xff222026),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 12),
          Container(
            height: 110,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xff040404),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: SvgWidget('assets/store$id.svg'),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'w600',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff4C4A51),
                    fontSize: 12,
                    fontFamily: 'w600',
                  ),
                ),
                Spacer(),
                MainButton(
                  title: 'Get for \$$price',
                  onPressed: () {},
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _Wheel extends StatelessWidget {
  const _Wheel({
    required this.id,
    required this.title,
    required this.price,
    required this.bought,
    required this.selected,
  });

  final int id;
  final String title;
  final int price;
  final bool bought;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Color(0xff1D1B23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Color(0xff222026),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 12),
          Container(
            height: 110,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xff040404),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: SvgWidget('assets/wheel$id.svg'),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'w600',
                  ),
                ),
                Spacer(),
                MainButton(
                  title: selected || bought
                      ? 'Apply'
                      : 'Get for \$${formatNumber(price)}',
                  isActive: !selected,
                  onPressed: () {},
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}
