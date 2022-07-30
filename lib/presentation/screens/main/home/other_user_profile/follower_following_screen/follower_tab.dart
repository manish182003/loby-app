import 'package:flutter/material.dart';
import 'follower_item_widget.dart';

class FollowerTabScreen extends StatefulWidget {
  const FollowerTabScreen({Key? key}) : super(key: key);

  @override
  State<FollowerTabScreen> createState() => _FollowerTabScreenState();
}

class _FollowerTabScreenState extends State<FollowerTabScreen> {
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
      itemCount: 50,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const FollowerItemWidget();
      },
    );
  }
}
