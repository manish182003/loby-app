import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import 'all_orders_screen.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundDarkJungleGreenColor,
          appBar: appBar(context: context, appBarName: "My Orders"),
          body: Column(
            children: [
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: butterflyBlueColor,
                indicatorWeight: 4.0,
                labelColor: textWhiteColor,
                labelStyle: textTheme.headline5,
                tabs: const [
                  Tab(text: 'All Orders'),
                  Tab(text: 'Bought'),
                  Tab(text: 'Sold'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: <Widget>[
                    AllOrdersTabScreen(status: 'ALL',),
                    AllOrdersTabScreen(status: 'BOUGHT',),
                    AllOrdersTabScreen(status: 'SOLD',)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
