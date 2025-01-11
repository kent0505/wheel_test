import 'package:flutter/material.dart';

import 'svg_widget.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController turns;

  @override
  void initState() {
    super.initState();
    turns = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    turns.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: turns,
        child: SizedBox(
          height: 40,
          child: Center(
            child: SvgWidget('assets/loading.svg'),
          ),
        ),
      ),
    );
  }
}
