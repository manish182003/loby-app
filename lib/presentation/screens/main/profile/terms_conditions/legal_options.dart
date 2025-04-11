import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

class LegalOptions extends StatelessWidget {
  const LegalOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar(
        context: context,
        appBarName: 'Terms & Conditions',
        textSize: 24,
        txtColor: textWhiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _termTile(context, termName: 'Terms of Use', sequenceNo: 1),
            SizedBox(
              height: 2.h,
            ),
            _termTile(context, termName: 'Privacy Policy', sequenceNo: 2),
            SizedBox(
              height: 2.h,
            ),
            _termTile(context, termName: 'EULA', sequenceNo: 3),
            SizedBox(
              height: 2.h,
            ),
            _termTile(context, termName: 'Refund Policy', sequenceNo: 4),
            SizedBox(
              height: 2.h,
            ),
            _termTile(context,
                termName: 'Loby Protection Period', sequenceNo: 5),
          ],
        ),
      ),
    );
  }

  Widget _termTile(BuildContext context,
      {required String termName, required int sequenceNo}) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          '$sequenceNo. ',
          style: textTheme.displayMedium?.copyWith(
            color: whiteColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        GestureDetector(
            onTap: () {
              context
                  .pushNamed(staticContentPage, extra: {'termName': termName});
            },
            child: Text(
              termName,
              style: textTheme.displayMedium?.copyWith(
                color: whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            )),
      ],
    );
  }
}
