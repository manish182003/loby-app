import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';

class UserDuelsWidget extends StatelessWidget {
  const UserDuelsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _buildWidget(textTheme, context);
  }

  _buildWidget(TextTheme textTheme, BuildContext context) {
    double rating = 3.5;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0),
          child: Card(
            color: backgroundBalticSeaColor,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 97.0,
                decoration: BoxDecoration(
                  color: aquaGreenColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Total WINS',
                              textAlign: TextAlign.center,
                              style: textTheme.headline4
                                  ?.copyWith(color: textTunaBlueColor, fontWeight: FontWeight.w500)),
                          Text('23',
                              textAlign: TextAlign.center,
                              style: textTheme.headlineLarge
                                  ?.copyWith(color: textTunaBlueColor, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Total LOSSES',
                              textAlign: TextAlign.center,
                              style: textTheme.headline4
                                  ?.copyWith(color: textTunaBlueColor, fontWeight: FontWeight.w500)),
                          Text('07',
                              textAlign: TextAlign.center,
                              style: textTheme.headlineLarge
                                  ?.copyWith(color: textTunaBlueColor, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ),
        Card(
          color: textFieldColor,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildUser(textTheme, 'Winner', aquaGreenColor, context),
                    _buildNameField(textTheme, 'Vs',
                        textTheme.headline4?.copyWith(color: textWhiteColor)),
                    buildUser(textTheme, 'Loser', lavaRedColor, context),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: orangeColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: Text('Battlegrounds Mobile India',
                              style: textTheme.headline4?.copyWith(
                                  fontSize: 12.0, color: textWhiteColor)),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Container(
                        decoration: BoxDecoration(
                          color: butterflyBlueColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: Text('TDM - 1v1',
                              style: textTheme.headline4?.copyWith(
                                  fontSize: 12.0, color: textWhiteColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  buildUser(TextTheme textTheme, String name, Color borderColor,
      BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitleField(textTheme, name, borderColor, context),
        _buildUserAvtar(lavaRedColor),
        _buildNameField(textTheme, 'Mukesh',
            textTheme.headline6?.copyWith(color: textLightColor)),
      ],
    );
  }

  _buildNameField(TextTheme textTheme, String name, var style) {
    return Text(
      name,
      style: style,
    );
  }

  _buildTitleField(TextTheme textTheme, String name, Color borderColor,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          /*decoration: BoxDecoration(
            color: textFieldColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10.0),
          ),*/
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                name,
                style: textTheme.headline5?.copyWith(color: whiteColor),
              ))),
    );
  }

  _buildUserAvtar(Color borderColor) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: butterflyBlueColor,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundColor: backgroundDarkJungleGreenColor,
            radius: 32,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/img.png'),
                radius: 32,
                backgroundColor: backgroundDarkJungleGreenColor,
              ),
            ), //CircleAvatar
          ),
        ),
      ),
    );
  }
}
