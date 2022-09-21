import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/screens/main/profile/my_order/widgets/all_order_item_widget.dart';
import 'package:loby/presentation/widgets/custom_loader.dart';

class AllOrdersTabScreen extends StatefulWidget {
  final String status;
  const AllOrdersTabScreen({Key? key, required this.status}) : super(key: key);

  @override
  State<AllOrdersTabScreen> createState() => _AllOrdersTabScreenState();
}

class _AllOrdersTabScreenState extends State<AllOrdersTabScreen> {

  OrderController orderController = Get.find<OrderController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderController.getOrders(status: widget.status);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            if(orderController.isOrdersFetching.value){
              return const CustomLoader();
            }else {
              return ListView.builder(
                  itemCount: orderController.orders.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return OrderItem(order: orderController.orders[index]);
                  }
              );
            }
          })
        )
    );
  }
}
