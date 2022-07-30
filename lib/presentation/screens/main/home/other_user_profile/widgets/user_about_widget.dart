import 'package:flutter/material.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/cusstom_text.dart';

class UserAboutWidget extends StatelessWidget {
  const UserAboutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _buildWidget(textTheme);
  }

  _buildWidget(TextTheme textTheme) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Name",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "Mukesh Kumar",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "IGN/Display Name",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "UNTD * Commander",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Country",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "India",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "City",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "Lucknow, Uttar Pradesh",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Profile Tag",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Bio",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Member Since",
                  style: textTheme.headline5
                      ?.copyWith(color: textLightColor),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: MyText(
                  name: "August 18, 2022",
                  textColor: textWhiteColor,
                  myBackgroundColor: textFieldColor,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
