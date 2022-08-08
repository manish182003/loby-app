import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

class CustomAppBar extends StatelessWidget {
  String? appBarName;
  IconData? otherIcon;
  Color? txtColor;

  CustomAppBar({Key? key, this.appBarName, this.otherIcon, this.txtColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Row(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 42,
                height: 42,
                child: MaterialButton(
                  shape: const CircleBorder(),
                  color: textCharcoalBlueColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 44.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    appBarName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headline2
                        ?.copyWith(color: txtColor ?? textWhiteColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
