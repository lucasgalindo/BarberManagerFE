import 'package:barbermanager_fe/models/message.dart';
import 'package:flutter/material.dart';

class MessageBalloon extends StatelessWidget {
  final Message msg;
  const MessageBalloon({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    double maxBubbleWidth = MediaQuery.of(context).size.width * 0.7;

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 300),
      builder: (context, double opacity, child) {
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(
              msg.fromMe ? 30 * (1 - opacity) : -30 * (1 - opacity),
              0,
            ),
            child: Align(
              alignment: msg.fromMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxBubbleWidth),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg.fromMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg.message,
                      style: TextStyle(
                        color: msg.fromMe ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}