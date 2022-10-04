import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import 'all_orders_screen.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> with SingleTickerProviderStateMixin {

  OrderController orderController = Get.find<OrderController>();
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();

    _tabController = TabController(length: 3, vsync: this, initialIndex: _currentTabIndex);
    _tabController.addListener(() {
      if (_tabController.animation?.value == _tabController.index) {
        setState(() {
          _currentTabIndex = _tabController.index;
        });

        getOrders();
        debugPrint('current tab $_currentTabIndex');
      }
    });
  }

  Future<void> getOrders()async{
    orderController.ordersPageNumber.value = 1;
    orderController.areMoreOrdersAvailable.value = true;
    orderController.getOrders(status: _currentTabIndex == 0 ? 'ALL' : _currentTabIndex == 1 ? 'BOUGHT' : 'SOLD');
  }
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundDarkJungleGreenColor,
        appBar: appBar(context: context, appBarName: "My Orders"),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: butterflyBlueColor,
              indicatorWeight: 4.0,
              labelColor: textWhiteColor,
              labelStyle: textTheme.headline5,
              onTap: (value){
                setState(() => _currentTabIndex = value);
              },
              tabs: const [
                Tab(text: 'All Orders'),
                Tab(text: 'Bought'),
                Tab(text: 'Sold'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  AllOrdersTabScreen(status: 'ALL',),
                  AllOrdersTabScreen(status: 'BOUGHT',),
                  AllOrdersTabScreen(status: 'SOLD',)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
