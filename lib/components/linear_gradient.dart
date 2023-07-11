import 'package:flutter/material.dart';

var startAlignment = Alignment.topLeft;
var endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 198, 198, 198),
          ],
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: widget,
    );
  }
}
