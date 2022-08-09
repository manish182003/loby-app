import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../data/models/ItemModel.dart';
import '../disputes/create_new_dispute_screen.dart';
import '../game_details_screen.dart';

class ItemList extends StatefulWidget {
  final String name;
  bool? menuIcon = true;

  ItemList({required this.name, this.menuIcon});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  late List<ItemModel> menuItems;
  final CustomPopupMenuController _controller = CustomPopupMenuController();


  @override
  void initState() {
    menuItems = [
      ItemModel(
        'Report Listing',
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
       /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GameDetailScreen(),
          ),
        );*/
        context.pushNamed(gameDetailPage);
      },
      child: Card(
        color: backgroundBalticSeaColor,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18.0 / 12.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: aquaGreenColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        "assets/images/img.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Lvl 78 Account on SA",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style:
                              textTheme.headline5?.copyWith(color: textWhiteColor)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Battlegrounds Mobile India",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textTheme.headline6
                                ?.copyWith(color: textInputTitleColor)),
                      ),
                      const SizedBox(height: 2.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 4.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: orangeColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 6.0),
                                    child: Text('Account',
                                        style: textTheme.headline6?.copyWith(color: textWhiteColor)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 4.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '₹25,000',
                                  style: textTheme.headline2?.copyWith(color: aquaGreenColor),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      const Divider(
                        color: dividerColor,
                        height: 4,
                        thickness: 2,
                        endIndent: 0,
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundColor: aquaGreenColor,
                            radius: 15,
                            child: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/img.png'),
                                radius: 15,
                              ),
                            ), //CircleAvatar
                          ),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mukesh Kumar Patel",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textTheme.headline4?.copyWith(
                                      fontSize: 11.0, color: textWhiteColor),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/user_rating_icon.svg',
                                          color: iconWhiteColor,
                                        ),
                                        const SizedBox(width: 2.0),
                                        Text(
                                          "4.5",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: textTheme.headline4?.copyWith(
                                              fontSize: 11.0,
                                              color: textWhiteColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 4.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/user_chat_icon.svg',
                                          color: iconWhiteColor,
                                        ),
                                        const SizedBox(width: 2.0),
                                        Text(
                                          "12",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: textTheme.headline4?.copyWith(
                                              fontSize: 11.0,
                                              color: textWhiteColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: widget.menuIcon! ? CustomPopupMenu(
                              arrowColor: lavaRedColor,
                              menuBuilder: () => ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  color: lavaRedColor,
                                  child: IntrinsicWidth(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: menuItems
                                          .map(
                                            (item) => GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            _controller.hideMenu();
                                            context.pushNamed(createNewDisputePage);
                                            /* ConfirmationRiseDisputeBottomDialog(
                              textTheme: textTheme,
                              contentName:
                              "Are you sure you want raise a dispute against this order ?",
                            ).showBottomDialog(context);*/
                                          },
                                          child: Container(
                                            height: 40,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    margin: const EdgeInsets.only(
                                                        left: 10),
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                    child: Text(
                                                      item.title,
                                                      style: textTheme.headline6
                                                          ?.copyWith(
                                                          color: textWhiteColor),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                              pressType: PressType.singleClick,
                              verticalMargin: 2,
                              controller: _controller,
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                child: const Icon(Icons.more_vert,
                                    size: 20.0, color: iconWhiteColor),
                              ),
                            ) : Container(),
                          )
                          /*SizedBox(
                              height: 4.h,
                              width: 5.w,
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                color: iconWhiteColor,
                                icon: const Icon(Icons.more_vert, size: 18.0),
                                onPressed: () {
                                  context.pushNamed(createNewDisputePage);
                                },
                              ))*/
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
