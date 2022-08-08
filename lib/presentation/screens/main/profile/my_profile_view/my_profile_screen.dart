import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/profile/my_profile_view/widgets/my_info.dart';
import 'package:loby/presentation/screens/main/profile/my_profile_view/widgets/my_profile_header.dart';

import '../../../../../../core/theme/colors.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => MyProfileScreenState();
}

class MyProfileScreenState extends State<MyProfileScreen> {
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
          const MyProfileHeader(
            avatar: AssetImage('assets/images/img.png'),
            title: "mukesh",
            subtitle: "kumar",
          ),
          const SizedBox(height: 10.0),
          MyInfo(),
        ],
      ),
    );
  }
}
