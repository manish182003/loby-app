import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loby/presentation/screens/main/profile/my_listing/widgets/myListingItemList.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';

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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: purpleLightIndigoColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          label: Text('Add Listing', style: textTheme.headline4?.copyWith(color: textWhiteColor)),
        ),
      ),
    );
  }
  Widget body(TextTheme textTheme) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 7.h,
                  height: 7.h,
                  child: MaterialButton(
                    shape: const CircleBorder(),
                    color: backgroundBalticSeaColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      'assets/icons/back_icon.svg',
                      color: whiteColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 8.0),
                      child: Text(
                        'My Listing',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline2
                            ?.copyWith(color: textWhiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          _buildGames(textTheme),
        ],
      ),
    );
  }

  _buildGames(TextTheme textTheme) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6.0 / 10.2,
        mainAxisSpacing: 0.1.h,
        crossAxisSpacing: 0.1.h,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: MyListingItemList(name: 'hello $index'),
        );
      },
    );
  }
}
