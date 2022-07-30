import 'package:flutter/material.dart';

class InputTextTitleWidget extends StatelessWidget {
  final String titleName;
  final Color? titleTextColor;

  const InputTextTitleWidget(
      {Key? key, required this.titleName, this.titleTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: Text(
        titleName,
        style: textTheme.headline5?.copyWith(color: titleTextColor),
      ),
    );
  }
}
