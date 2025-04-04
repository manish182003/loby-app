import 'package:flutter/material.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/profile/user.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/cusstom_text.dart';

class UserAboutWidget extends StatelessWidget {
  final User user;
  const UserAboutWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _buildWidget(textTheme);
  }

  _buildWidget(TextTheme textTheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Name",
            style: textTheme.headlineSmall?.copyWith(color: textLightColor),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: MyText(
            name: user.name ?? '',
            textColor: textWhiteColor,
            myBackgroundColor: textFieldColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            "IGN/Display Name",
            style: textTheme.headlineSmall?.copyWith(color: textLightColor),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: MyText(
            name: user.displayName ?? "",
            textColor: textWhiteColor,
            myBackgroundColor: textFieldColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Country",
            style: textTheme.headlineSmall?.copyWith(color: textLightColor),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: MyText(
            name: "${user.country?.name!}",
            textColor: textWhiteColor,
            myBackgroundColor: textFieldColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            "City",
            style: textTheme.headlineSmall?.copyWith(color: textLightColor),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: MyText(
            name: "${user.city?.name!}",
            textColor: textWhiteColor,
            myBackgroundColor: textFieldColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Profile Tag",
            style: textTheme.headlineSmall?.copyWith(color: textLightColor),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: MyText(
            name: user.profileTags?.map((e) => e.name).join(", ") ?? '',
            textColor: textWhiteColor,
            myBackgroundColor: textFieldColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Bio",
            style: textTheme.headlineSmall?.copyWith(color: textLightColor),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: MyText(
            name: user.bio ?? '',
            textColor: textWhiteColor,
            myBackgroundColor: textFieldColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Member Since",
            style: textTheme.headlineSmall?.copyWith(color: textLightColor),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'UID: ${user.uid}',
          style: textTheme.headlineSmall?.copyWith(color: whiteColor),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        Text(
          Helpers.formatDateTime(dateTime: user.createdAt ?? DateTime.now()),
          style: textTheme.headlineSmall?.copyWith(color: whiteColor),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
