import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class NoDataFoundWidget extends StatelessWidget {
  final String? text;
  const NoDataFoundWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
        child: Text(
      text ?? 'No Data Found',
      textAlign: TextAlign.center,
      style: textTheme.displaySmall?.copyWith(color: textWhiteColor),
    ));
  }
}
