import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String? appBarName;
  final IconData? otherIcon;
  final Color? txtColor;

  final Function()? onBack;

  const CustomAppBar({
    super.key,
    this.appBarName,
    this.otherIcon,
    this.txtColor,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Row(
        children: [
          Stack(
            children: [
              // SizedBox(
              //   width: 42,
              //   height: 42,
              //   child: MaterialButton(
              //     shape: const CircleBorder(),
              //     color: textCharcoalBlueColor,
              //     onPressed: () {
              //       if(onBack == null){
              //         Navigator.pop(context);
              //       }else{
              //         onBack!();
              //         Navigator.pop(context);
              //       }
              //     },
              //     child: const Icon(
              //       Icons.arrow_back_ios,
              //       size: 18,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 44.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    appBarName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.displayMedium
                        ?.copyWith(color: txtColor ?? textWhiteColor),
                  ),
                ),
              ),
              // `InkWell(
              //   onTap: () {

              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       color: textCharcoalBlueColor,
              //       child: Icon(Icons.search)),
              //   ),
              // )`
            ],
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget appBar({
  required BuildContext context,
  String? appBarName,
  IconData? otherIcon,
  String? userImage,
  bool? isVerified,
  String? userId,
  Color? txtColor,
  double? textSize,
  Function()? onBack,
  bool isBackIcon = true,
}) {
  final textTheme = Theme.of(context).textTheme;
  return PreferredSize(
    preferredSize: const Size(double.infinity, 70),
    child: SafeArea(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: userImage == null
                  ? Text(
                      textAlign: TextAlign.center,
                      appBarName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.displayMedium?.copyWith(
                        color: txtColor ?? aquaGreenColor,
                        fontSize: textSize,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isVerified == true)
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                userProfilePage,
                                extra: {'userId': userId, 'from': 'other'},
                              );
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                CircleAvatar(
                                  backgroundColor: butterflyBlueColor,
                                  radius: 24,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image.network(
                                      userImage,
                                      fit: BoxFit.cover,
                                      width: 35,
                                      height: 35,
                                    ),
                                  ), //CircleAvatar
                                ),
                                SvgPicture.asset(
                                  'assets/icons/blue_tick.svg',
                                  height: 18,
                                  width: 18,
                                ),
                              ],
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                userProfilePage,
                                extra: {'userId': userId, 'from': 'other'},
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(userImage),
                              radius: 24,
                            ),
                          ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          appBarName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.displayMedium
                              ?.copyWith(color: txtColor ?? aquaGreenColor),
                        )
                      ],
                    ),
            ),
            isBackIcon
                ? SizedBox(
                    width: 42,
                    height: 42,
                    child: MaterialButton(
                      shape: const CircleBorder(),
                      color: textCharcoalBlueColor,
                      onPressed: () {
                        if (onBack == null) {
                          Navigator.pop(context);
                        } else {
                          onBack();
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    ),
  );
}
