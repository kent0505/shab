import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'svg_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(
        color: Colors.black,
      ),
    );
  }
}

class Loading2 extends StatefulWidget {
  const Loading2({super.key});

  @override
  State<Loading2> createState() => _Loading2State();
}

class _Loading2State extends State<Loading2> {
  int _index = 0;
  late Timer _timer;

  void _start() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 300),
      (timer) {
        setState(() {
          _index < 2 ? _index++ : _index = 0;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Indicator(_index == 0),
          _Indicator(_index == 1),
          _Indicator(_index == 2),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator(this.active);

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: active ? 12 : 8,
      width: active ? 12 : 8,
      margin: EdgeInsets.symmetric(horizontal: active ? 2 : 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.greenAccent,
      ),
    );
  }
}

class Loading3 extends StatefulWidget {
  const Loading3({super.key});

  @override
  State<Loading3> createState() => _Loading3State();
}

class _Loading3State extends State<Loading3>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _animation,
        child: const SvgWidget(
          Assets.settings,
          height: 100,
        ),
      ),
    );
  }
}
