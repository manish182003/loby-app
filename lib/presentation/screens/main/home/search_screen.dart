import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loby/presentation/screens/main/home/widgets/game_list_card.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../widgets/SearchFieldWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: body(),
      ),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
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
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        const SearchFieldWidget(textHint: 'Search Game'),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Listings",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style:
                        textTheme.headline4?.copyWith(color: aquaGreenColor)),
                Divider(
                  color: aquaGreenColor,
                  thickness: 1.0,
                ),
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {},
                    child: buildListItem(textTheme),
                  ),
                ),
                SizedBox(
                  height: 44.0,
                ),
                Text("Games",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style:
                        textTheme.headline4?.copyWith(color: aquaGreenColor)),
                Divider(
                  color: aquaGreenColor,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 166,
                  child: ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        debugPrint('Battlegrounds Mobile India $index');
                        FocusManager.instance.primaryFocus?.unfocus();
                        //  context.pushNamed(gamePage);
                        /*Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    GameItemScreen(name: 'Battlegrounds Mobile $index')));*/
                      },
                      child: SizedBox(
                        height: 166,
                        width: 120,
                        child: Center(
                          child: GameCard(index: index),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 44.0,
                ),
                Text("Users",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style:
                        textTheme.headline4?.copyWith(color: aquaGreenColor)),
                Divider(
                  color: aquaGreenColor,
                  thickness: 1.0,
                ),
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {},
                    child: buildUsersListItem(textTheme),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  buildListItem(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text("Lvl 78 Account on Sjtyujtt  tt jtyjtyjt tyjtyjtA",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: textTheme.headline5?.copyWith(color: textWhiteColor)),
          ),
          SizedBox(width: 16.0),
          Container(
            decoration: BoxDecoration(
              color: orangeColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Text('Account',
                  style: textTheme.subtitle1?.copyWith(color: textWhiteColor)),
            ),
          ),
        ],
      ),
    );
  }

  buildUsersListItem(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text("Mukesh kumar Patel",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: textTheme.headline5?.copyWith(color: textWhiteColor)),
          ),
        ],
      ),
    );
  }
}
