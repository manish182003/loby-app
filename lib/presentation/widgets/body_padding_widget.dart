import 'package:flutter/material.dart';


class BodyPaddingWidget extends StatelessWidget {
  final Widget child;

  const BodyPaddingWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15 , right: 15),
      child: child,
    );
  }
}