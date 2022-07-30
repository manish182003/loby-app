import 'package:flutter/material.dart';
import 'follower_item_widget.dart';

class FollowingTabScreen extends StatefulWidget {
  const FollowingTabScreen({Key? key}) : super(key: key);

  @override
  State<FollowingTabScreen> createState() => _FollowingTabScreenState();
}

class _FollowingTabScreenState extends State<FollowingTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildchatUser(textTheme),
        ],
      ),
    );
  }

  _buildchatUser(TextTheme textTheme) {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const FollowerItemWidget();
      },
    );
  }
}
