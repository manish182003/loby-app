import 'package:flutter/material.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../widgets/CustomSwitch.dart';
import '../../../../../widgets/SuccessfullyDeleteListingBottomDialog.dart';
import '../../../../../widgets/bottom_dialog_widget.dart';
import '../../../../../widgets/confirmation_dialog.dart';

class MyListingItemList extends StatefulWidget {
  final String name;

  const MyListingItemList({required this.name});

  @override
  State<MyListingItemList> createState() => _MyListingItemListState();
}

class _MyListingItemListState extends State<MyListingItemList> {
  bool _enable = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {},
      child: Card(
        color: backgroundBalticSeaColor,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
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
                  Text("item.category",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textTheme.headline6
                          ?.copyWith(color: textInputTitleColor)),
                  const SizedBox(height: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    vertical: 2.0, horizontal: 6.0),
                                child: Text('Account',
                                    style: textTheme.headline6
                                        ?.copyWith(color: textWhiteColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4.0),
                        child: Column(
                          children: <Widget>[
                            Text('₹ 25,000',
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.headline4
                                    ?.copyWith(color: aquaGreenColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                butterflyBlueColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ))),
                        onPressed: () {},
                        child: Text("Edit",
                            style: textTheme.headline6
                                ?.copyWith(color: textWhiteColor)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(lavaRedColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ))),
                        onPressed: () {
                          ConfirmationBottomDialog(
                              textTheme: textTheme,
                              contentName:
                              "Are you sure you want delete this listing ?", yesBtnClick: SuccessfullyDeleteListingDialog(
                            textTheme: textTheme,
                            contentName:
                            "Your listing has been completely deleted. Any ongoing order still needs to be completed",))
                              .showBottomDialog(context);
                        },
                        child: Text("Delete",
                            style: textTheme.headline6
                                ?.copyWith(color: textWhiteColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Inactive",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textWhiteColor)),
                      CustomSwitch(
                        value: _enable,
                        onChanged: (bool val) {
                          setState(() {
                            _enable = val;
                          });
                        },
                      ),
                      Text("Active",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headline5
                              ?.copyWith(color: textWhiteColor)),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
