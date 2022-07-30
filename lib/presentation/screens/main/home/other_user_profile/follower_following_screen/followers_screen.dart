import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../core/theme/colors.dart';
import 'follower_tab.dart';
import 'following_tab.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  final _tabs = [
    const Tab(text: 'Following'),
    const Tab(text: 'Followers'),
  ];


  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.55;
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child:  Scaffold(
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.34),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Card(
                            color: backgroundBalticSeaColor,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.green[500],
                                        radius: 36,
                                        child: const Padding(
                                          padding: EdgeInsets.all(1.0),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage('assets/images/img.png'),
                                            radius: 36,
                                          ),
                                        ), //CircleAvatar
                                      ),
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    constraints: BoxConstraints(maxWidth: maxWidth),
                                                    child: Text("Mukesh Kumar",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: textTheme.headline3
                                                            ?.copyWith(
                                                            fontSize: 16.sp,
                                                            color: textWhiteColor)),
                                                  ),
                                                  const SizedBox(width: 8.0),
                                                  SvgPicture.asset(
                                                    'assets/icons/verified_user_bedge.svg',
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
            FollowerTabScreen(),
            FollowingTabScreen(),
          ],
        ),
      ),
    );
  }
}