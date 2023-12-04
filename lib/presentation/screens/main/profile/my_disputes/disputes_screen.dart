import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
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

class _DisputeScreenState extends State<DisputeScreen> with SingleTickerProviderStateMixin {

  OrderController orderController = Get.find<OrderController>();
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDisputes();

    _tabController = TabController(length: 2, vsync: this, initialIndex: _currentTabIndex);
    _tabController.addListener(() {
      if (_tabController.animation?.value == _tabController.index) {
        setState(() {
          _currentTabIndex = _tabController.index;
        });
        getDisputes();
        debugPrint('current tab $_currentTabIndex');
      }
    });
  }

  Future<void> getDisputes()async{
    orderController.disputesPageNumber.value = 1;
    orderController.areMoreDisputesAvailable.value = true;
    orderController.getDisputes(status: _currentTabIndex == 0 ? 'PENDING' : 'RESOLVED');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child:  Scaffold(
        appBar: appBar(context: context, appBarName: "My Disputes", isBackIcon: true),
        body:  Column(
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
                Tab(text: 'Open'),
                Tab(text: 'Closed'),
              ],
            ),
            SizedBox(height: 2.h,),
            Expanded(
              child:  TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  DisputeScreenTab(status: 'PENDING',),
                  DisputeScreenTab(status: 'RESOLVED',),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
