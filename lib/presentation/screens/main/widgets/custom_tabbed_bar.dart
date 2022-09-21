import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';

import '../../../../core/theme/colors.dart';
import '../chat/chat_screen.dart';
import '../create_listing/create_listing_screen.dart';
import '../home/home_screen.dart';
import '../notification/notification_screen.dart';
import '../profile/profile_screen.dart';

class CustomTabbedAppBar extends StatefulWidget {
  const CustomTabbedAppBar({Key? key}) : super(key: key);

  @override
  State<CustomTabbedAppBar> createState() => CustomTabbedAppBarState();
}

class CustomTabbedAppBarState extends State<CustomTabbedAppBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  HomeController homeController = Get.find<HomeController>();

  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    homeController.getUnreadCount(type: 'chat');
    homeController.getUnreadCount(type: 'notification');

    _tabController =
        TabController(length: 5, vsync: this, initialIndex: _currentTabIndex);
    _tabController.addListener(() {
      if (_tabController.animation?.value == _tabController.index) {
        setState(() {
          _currentTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomeScreen(),
              CreateListingScreen(),
              ChatScreen(),
              NotificationScreen(),
              ProfileScreen(),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              top: 24.0, bottom: 24.0, left: 24.0, right: 24.0),
          // width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: aquaGreenColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: TabBar(
            controller: _tabController,
            onTap: (value) => setState(() => _currentTabIndex = value),
            labelColor: aquaGreenColor,
            labelStyle: textTheme.headline5,
            unselectedLabelColor: whiteColor,
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
            labelPadding: const EdgeInsets.all(2.0),
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              color: activeBottomNavItemColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            tabs: [
              Tab(
                  child: TabTitle(
                    isSelected: _currentTabIndex == 0,
                    icon: 'assets/icons/home_icon.svg',
                  )),
              Tab(
                  child: TabTitle(
                    isSelected: _currentTabIndex == 1,
                    icon: 'assets/icons/create_icon.svg',
                  )),
              Tab(
                  child: Obx(() {
                    return TabTitle(
                      isSelected: _currentTabIndex == 2,
                      icon: 'assets/icons/chat_icon.svg',
                      count: homeController.chatCount.value,
                    );
                  })),
              Tab(
                  child: Obx(() {
                    return TabTitle(
                      isSelected: _currentTabIndex == 3,
                      icon: 'assets/icons/notification_icon.svg',
                      count: homeController.notificationCount.value,
                    );
                  })),
              Tab(
                  child: TabTitle(
                    isSelected: _currentTabIndex == 4,
                    icon: 'assets/icons/profile_icon.svg',
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class TabTitle extends StatelessWidget {
  final bool isSelected;
  final String icon;
  final int? count;

  const TabTitle({
    Key? key,
    this.isSelected = false,
    required this.icon, this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Badge(
      badgeContent: Text(
          '$count', style: textTheme.headline6?.copyWith(color: Colors.white)
      ),
      position: BadgePosition.topEnd(),
      badgeColor: badgeColor,
      showBadge: count == 0 ? false : true,
      child: AnimatedContainer(
        width: 56,
        height: 46,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: IconTheme(
            data: const IconThemeData(
              size: 24,
              color: Colors.black,
            ),
            child: SvgPicture.asset(icon),
          ),
        ),
      ),
    );
  }
}
