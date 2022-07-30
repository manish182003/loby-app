import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/theme/colors.dart';
import 'all_orders_screen.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final _tabs = [
    const Tab(text: 'All Orders'),
    const Tab(text: 'Bought'),
    const Tab(text: 'Sold'),
  ];


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 3,
      child:  Scaffold(
        backgroundColor: backgroundDarkJungleGreenColor,
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.19),
          child:  SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 7.h,
                        height: 7.h,
                        child: MaterialButton(
                          shape: const CircleBorder(),
                          color: backgroundBalticSeaColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            'assets/icons/back_icon.svg',
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                 TabBar(
                   indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: tabIndicatorColor,
                  indicatorWeight: 4.0,
                  labelColor: textWhiteColor,
                  labelStyle: textTheme.headline5,
                  tabs: _tabs,
                ),
              ],
            ),
          ),
        ),
        body:  const TabBarView(
          children: <Widget>[
            AllOrdersTabScreen(),
            AllOrdersTabScreen(),
            AllOrdersTabScreen()
          ],
        ),
      ),
    );
  }
}