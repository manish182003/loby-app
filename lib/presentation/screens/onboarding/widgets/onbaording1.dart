import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:sizer/sizer.dart';

class OnBoarding1 extends StatelessWidget {
  final String backgroundImage;
  final String frontImage;
  final String title;
  final String desc;
  final double? frontImageSize;
  final double? frontImagePosition;
  final double? backImageSize;
  const OnBoarding1(
      {Key? key,
      required this.backgroundImage,
      required this.frontImage,
      required this.title,
      required this.desc,
      this.frontImageSize,
      this.frontImagePosition,
      this.backImageSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BodyPaddingWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              FadeInUp(
                  duration: const Duration(seconds: 1),
                  child: Image.asset(
                    "assets/onboarding/$backgroundImage.png",
                    height: backImageSize ?? 41.h,
                    width: 41.h,
                  )),
              Positioned(
                bottom: frontImagePosition ?? 2.h,
                child: FadeInDown(
                    duration: const Duration(seconds: 1),
                    child: Image.asset(
                      "assets/onboarding/$frontImage.png",
                      height: frontImageSize ?? 35.h,
                      width: frontImageSize ?? 35.h,
                    )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Text(title,
                    style: textTheme.displayMedium
                        ?.copyWith(color: whiteColor, fontSize: 18.sp)),
                SizedBox(height: 3.h),
                Text(desc,
                    style: textTheme.headlineSmall?.copyWith(
                        color: whiteColor, fontWeight: FontWeight.w100))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
