import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/notification/widgets/notification_item_widget.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_app_bar.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body(),
      ),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        CustomAppBar(
          appBarName: "Transactions",
        ),
        // _buildNotifications(textTheme),
      ],
    );
  }

  // _buildNotifications(TextTheme textTheme) {
  //   return Flexible(
  //     child: SingleChildScrollView(
  //       child: ListView.builder(
  //         itemCount: 10,
  //         shrinkWrap: true,
  //         padding: const EdgeInsets.only(top: 16),
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemBuilder: (context, index) {
  //           return const NotificationItemWidget();
  //         },
  //       ),
  //     ),
  //   );
  // }
}
