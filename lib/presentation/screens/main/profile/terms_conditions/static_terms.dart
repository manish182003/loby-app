import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';

class StaticTerms extends StatefulWidget {
  final String termName;

  const StaticTerms({Key? key, required this.termName}) : super(key: key);

  @override
  State<StaticTerms> createState() => _StaticTermsState();
}

class _StaticTermsState extends State<StaticTerms> {
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getStaticData();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar(context: context, appBarName: widget.termName),
      body: BodyPaddingWidget(
        child: Obx(() {
          if (homeController.isStaticDataFetching.value) {
            return const CustomLoader();
          } else {
            final staticData = homeController.staticData
                .where((e) => e.label == widget.termName)
                .toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    staticData.isEmpty
                        ? "No Data Found"
                        : staticData.first.realValue!,
                    style: textTheme.headlineSmall
                        ?.copyWith(color: textWhiteColor, height: 0.2.h),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
