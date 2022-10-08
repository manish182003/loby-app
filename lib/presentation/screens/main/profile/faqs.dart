import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';

import '../../../../core/theme/colors.dart';

class FAQs extends StatefulWidget {
  const FAQs({Key? key}) : super(key: key);

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar(context: context, appBarName: "FAQs"),
      body: BodyPaddingWidget(
        child: Column(
          children: [
            GFAccordion(
              title: "1. What is Loby?",
              contentChild: Text("Loby is a great gaming application.", style: textTheme.headline5?.copyWith(color: textWhiteColor),),
              collapsedIcon: const Icon(Icons.add, color: whiteColor,),
              expandedIcon: const Icon(Icons.minimize, color: whiteColor,),
              collapsedTitleBackgroundColor: backgroundColor,
              expandedTitleBackgroundColor: backgroundColor,
              contentBackgroundColor : backgroundColor,
              textStyle: textTheme.headline3!.copyWith(color: textWhiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
