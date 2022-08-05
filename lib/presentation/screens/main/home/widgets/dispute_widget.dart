import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class DisputeWidget extends StatelessWidget {
  final String disputeType;
  final String currentStatus;

  const DisputeWidget(
      {Key? key, required this.disputeType, required this.currentStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _buildWidget(textTheme, context);
  }

  _buildWidget(TextTheme textTheme, BuildContext context) {
    return Column(
      children: <Widget>[
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
                    buildUser(textTheme, 'Seller', aquaGreenColor, context),
                    const SizedBox(
                      width: 8,
                    ),
                    buildUser(textTheme, 'Buyer', orangeColor, context),
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
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          color: orangeColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: Text('Battlegrounds Mobile India',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.headline6
                                  ?.copyWith(color: textWhiteColor)),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color: butterflyBlueColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: Text('TDM - 1v1',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.headline6
                                  ?.copyWith(color: textWhiteColor)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _buildListingIdWidget(
                    textTheme, "Listing Id : ", textWhiteColor, context),
                const SizedBox(height: 8),
                _buildCurrentStatusWidget(
                    textTheme,
                    "Current Status : ",
                    disputeType == "Open" ? orangeColor : aquaGreenColor,
                    context)
              ],
            ),
          ),
        )
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
            textTheme.headline5?.copyWith(color: textLightColor)),
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
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.30,
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
      padding: EdgeInsets.symmetric(vertical:8.0, horizontal: 0.0),
      child: CircleAvatar(
        radius: 36,
        backgroundColor: butterflyBlueColor,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundColor: backgroundDarkJungleGreenColor,
            radius: 36,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/img.png'),
                radius: 36,
                backgroundColor: backgroundDarkJungleGreenColor,
              ),
            ), //CircleAvatar
          ),
        ),
      ),
    );
  }

  _buildListingIdWidget(TextTheme textTheme, String title, Color textColor,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.center,
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Listing ID : ',
                style: textTheme.headline6?.copyWith(color: textLightColor),
              ),
              TextSpan(
                  text: '2207202200001',
                  style: textTheme.headline6?.copyWith(color: textWhiteColor)),
            ],
          ),
        ),
      ),
    );
  }

  _buildCurrentStatusWidget(TextTheme textTheme, String title, Color textColor,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.center,
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Current Status : ',
                style: textTheme.headline6?.copyWith(color: textLightColor),
              ),
              TextSpan(
                  text: currentStatus,
                  style: textTheme.headline6?.copyWith(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
