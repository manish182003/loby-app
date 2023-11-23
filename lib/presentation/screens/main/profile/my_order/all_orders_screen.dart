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
  final controller = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        orderController.getOrders(status: widget.status,);
      }
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if(orderController.isOrdersFetching.value){
            return const CustomLoader();
          }else if(orderController.orders.isEmpty){
            return const NoDataFoundWidget();
          }else{
            return ListView.builder(
                itemCount: orderController.orders.length + 1,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: controller,
                itemBuilder: (context, index) {
                  if (index < orderController.orders.length) {
                    return OrderItem(order: orderController.orders[index]);
                  }else {
                    return Obx(() {
                      if (orderController.areMoreOrdersAvailable.value) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return const SizedBox();
                      }
                    });
                  }
                }
            );
          }
        })
    );
  }
}
