import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import 'closed_dispute_screen.dart';
import 'open_dispute_screen.dart';

class DisputeScreen extends StatefulWidget {
  const DisputeScreen({Key? key}) : super(key: key);

  @override
  State<DisputeScreen> createState() => _DisputeScreenState();
}

class _DisputeScreenState extends State<DisputeScreen> {

  final _tabs = [
    const Tab(text: 'Open'),
    const Tab(text: 'Closed'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child:  Scaffold(
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.17),
          child:  Container(
            child:  SafeArea(
              child: Column(
                children: <Widget>[
                  CustomAppBar(
                    appBarName: "My Disputes",
                  ),
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: butterflyBlueColor,
                    indicatorWeight: 4.0,
                    labelColor: textWhiteColor,
                    labelStyle: textTheme.headline5,
                    tabs: _tabs,
                  ),
                ],
              ),
            ),
          ),
        ),
        body:  const TabBarView(
          children: <Widget>[
            OpenDisputeScreen(),
            ClosedDisputeScreen()
          ],
        ),
      ),
    );
  }
}
