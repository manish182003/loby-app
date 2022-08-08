import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/profile/my_listing/widgets/myListingItemList.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_app_bar.dart';

class MyListingScreen extends StatefulWidget {
  const MyListingScreen({Key? key}) : super(key: key);

  @override
  State<MyListingScreen> createState() => _MyListingScreenState();
}

class _MyListingScreenState extends State<MyListingScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundDarkJungleGreenColor,
        body: body(textTheme),
      ),
    );
  }

  Widget body(TextTheme textTheme) {
    return Column(
      children: [
        CustomAppBar(
          appBarName: "My Listing",
        ),
        _buildGames(textTheme)
      ],
    );
  }

  _buildGames(TextTheme textTheme) {
    return Flexible(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.60,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 50,
            itemBuilder: (context, index) {
              return MyListingItemList(name: 'hello $index');
            },
          ),
        ),
      ),
    );
  }
}
