import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/colors.dart';

class SearchFieldWidget extends StatelessWidget {
  final String? textHint;
  const SearchFieldWidget({Key? key, this.textHint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 45,
          minWidth: 45,
        ),
        decoration: BoxDecoration(
          color: textFieldColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.13,
              child: SvgPicture.asset(
                'assets/icons/search_icon.svg',
                color: iconWhiteColor,
                width: 18,
                height: 18,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                style: textTheme.headline4?.copyWith(color: textWhiteColor),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: textTheme.headline4?.copyWith(color: textWhiteColor),
                  hintText: textHint?? 'Search',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
