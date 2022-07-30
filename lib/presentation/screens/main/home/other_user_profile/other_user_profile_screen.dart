import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/profile_header.dart';
import 'package:loby/presentation/screens/main/home/other_user_profile/widgets/user_info.dart';
import '../../../../../core/theme/colors.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({Key? key}) : super(key: key);

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundDarkJungleGreenColor,
        body: body(),
      ),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const ProfileHeader(
            avatar: AssetImage('assets/images/img.png'),
            title: "mukesh",
            subtitle: "kumar",
          ),
          const SizedBox(height: 10.0),
          UserInfo(),
        ],
      ),
    );
  }
}

