import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/domain/entities/home/static_data.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

class LegalOptions extends StatelessWidget {
  const LegalOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar(context: context),
      body: BodyPaddingWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _termTile(context, termName: 'Terms of Use'),
            SizedBox(height: 2.h,),
            _termTile(context, termName: 'Privacy Policy'),
            SizedBox(height: 2.h,),
            _termTile(context, termName: 'EULA'),
          ],
        ),
      ),
    );
  }

  Widget _termTile(BuildContext context, {required String termName}){
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
        onTap: (){
          context.pushNamed(staticContentPage, queryParams: {'termName' : termName});
        },
        child: Text(termName, style: textTheme.headline2?.copyWith(color: whiteColor),));
  }
}
