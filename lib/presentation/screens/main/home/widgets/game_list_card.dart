import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';

class GameCard extends StatelessWidget {
  int index;

  GameCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      shadowColor: Colors.black,
      color: Colors.transparent,
      child: SizedBox(
        width: 150,
        height: 166,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: aquaGreenColor,
                  child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: CircleAvatar(
                      backgroundColor: backgroundDarkJungleGreenColor,
                      radius: 36,
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/img.png'),
                          radius: 36,
                          backgroundColor: backgroundDarkJungleGreenColor,
                        ),
                      ), //CircleAvatar
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ), //CircleAvatar//SizedBox
              Text(
                'Battleground Mobile India',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: textTheme.headline6
                    ?.copyWith(color: textWhiteColor), //Textstyle
              ), //Text
              SizedBox(
                height: 0.5.h,
              ), //SizedBoxe
            ],
          ), //Column
        ), //Padding
      ), //SizedBox
    );
  }
}
