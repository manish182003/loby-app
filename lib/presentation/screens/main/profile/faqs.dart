import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';

import '../../../../core/theme/colors.dart';

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    homeController.getFaqsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar(context: context, appBarName: "FAQs"),
      body: BodyPaddingWidget(child: Obx(() {
        final faqs = homeController.allFaqsData;
        return ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            var faq = faqs[index];
            return GFAccordion(
              title: faq.question ?? "1. What is Loby?",
              contentChild: Text(
                faq.answer ?? "Loby is a great gaming application.",
                style: textTheme.headlineSmall?.copyWith(color: textWhiteColor),
              ),
              collapsedIcon: const Icon(
                Icons.add,
                color: whiteColor,
              ),
              expandedIcon: const Icon(
                Icons.minimize,
                color: whiteColor,
              ),
              collapsedTitleBackgroundColor: backgroundColor,
              expandedTitleBackgroundColor: backgroundColor,
              contentBackgroundColor: backgroundColor,
              textStyle:
                  textTheme.displaySmall!.copyWith(color: textWhiteColor),
            );
          },
        );
      })),
    );
  }
}
