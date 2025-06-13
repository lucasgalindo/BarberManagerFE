import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 900),
      vsync: this,
    )..repeat();
    _dotCount = IntTween(begin: 1, end: 3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dotCount,
      builder: (context, child) {
        final dots = '.' * _dotCount.value;
        return Text("Digitando$dots", style: TextStyle(fontSize: 16));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
