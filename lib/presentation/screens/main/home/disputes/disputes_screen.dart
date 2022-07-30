import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/theme/colors.dart';
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
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
          child:  Container(
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
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 8.0),
                              child: Text(
                                'My Disputes',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.headline2
                                    ?.copyWith(color: textWhiteColor),
                              ),
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
