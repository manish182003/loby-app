import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../data/models/ItemModel.dart';
import '../../../../../../services/routing_service/routes_name.dart';
import '../../../../../widgets/UpdateStatusDialog.dart';

class OrderItem extends StatefulWidget {
  final String name;

  const OrderItem({Key? key, required this.name});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late List<ItemModel> menuItems;
  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuItems = [
      ItemModel(
        'Raise Dispute',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: backgroundBalticSeaColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 10.h,
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.66,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Text("Lvl 78 Account on SA",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textTheme.headline5
                                      ?.copyWith(color: textWhiteColor)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        SizedBox(
                          child: Text("Battlegrounds Mobile India",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: textTheme.headline6
                                  ?.copyWith(color: textInputTitleColor)),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: orangeColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Text('Account',
                                    style: textTheme.subtitle1
                                        ?.copyWith(color: textWhiteColor)),
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            GestureDetector(
                              onTap: () {
                                UpdateStatusDialog(
                                        textTheme: textTheme,
                                        tileName: "Congratulations",
                                        titleColor: aquaGreenColor,
                                        contentName:
                                            "Your service has been successfully listed. You can edit your listings from My Listings.",
                                        contentLinkName: ' My Listings')
                                    .showBottomDialog(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: butterflyBlueColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('Update Status',
                                      style: textTheme.subtitle1
                                          ?.copyWith(color: textWhiteColor)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Current Status : ",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textTheme.headline4?.copyWith(
                                      fontSize: 11.0, color: textLightColor),
                                ),
                                const SizedBox(width: 2.0),
                                Text(
                                  "Order in Progress",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textTheme.headline4?.copyWith(
                                      fontSize: 11.0, color: aquaGreenColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: CustomPopupMenu(
                    arrowColor: lavaRedColor,
                    menuBuilder: () => ClipRRect(
                      borderRadius: BorderRadius.circular(5),
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
                    verticalMargin: -10,
                    controller: _controller,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Icon(Icons.more_vert,
                          size: 24.0, color: iconWhiteColor),
                    ),
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
