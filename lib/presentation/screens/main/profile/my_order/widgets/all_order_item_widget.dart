import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../services/routing_service/routes_name.dart';
import '../../../../../widgets/custom_dialog.dart';
import '../../../../../widgets/follow_btn.dart';

class OrderItem extends StatelessWidget {
  final String name;

   const OrderItem({Key? key, required this.name});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        debugPrint('check');
      },
      child: Card(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text("Lvl 78 Account on SA",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textTheme.headline5
                                      ?.copyWith(color: textWhiteColor)),
                            ),
                            SizedBox(
                                height: 2.h,
                                width: 5.w,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0.0),
                                  color: iconWhiteColor,
                                  icon: const Icon(Icons.more_vert, size: 18.0),
                                  onPressed: () {
                                    context.pushNamed(createNewDisputePage);
                                  },
                                ))
                          ],
                        ),
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
                              decoration: BoxDecoration(
                                color: orangeColor,
                                borderRadius: BorderRadius.circular(1.2.h),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 6.0),
                                child: Text('Account',
                                    style: textTheme.subtitle1
                                        ?.copyWith(color: textWhiteColor)),
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.31,
                              child: Button(
                                width: MediaQuery.of(context).size.width * 0.31,
                                height: 24,
                                onPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CustomDialog());
                                },
                                txtPadding: 2.0,
                                btnBgColor: butterflyBlueColor,
                                txtColor: textWhiteColor,
                                borderRadius: 1.2.h,
                                btnName: 'Update Status',
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
            )
          ],
        ),
      ),
    );
  }
}
