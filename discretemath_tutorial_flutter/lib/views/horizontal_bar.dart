
import 'package:flutter/material.dart';

class HorizontalBar extends StatelessWidget {
  const HorizontalBar({this.color, this.fraction});

  final Color color;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: constraints.maxWidth,
        height: 4,
        child: Row(
          children: [
            SizedBox(
              width: (1 - fraction) * constraints.maxHeight,
              child: Container(
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: fraction * constraints.maxHeight,
              child: Container(color: color),
            ),
          ],
        ),
      );
    });
  }
}