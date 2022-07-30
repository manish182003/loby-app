import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/profile/my_order/widgets/all_order_item_widget.dart';

class AllOrdersTabScreen extends StatefulWidget {
  const AllOrdersTabScreen({Key? key}) : super(key: key);

  @override
  State<AllOrdersTabScreen> createState() => _AllOrdersTabScreenState();
}

class _AllOrdersTabScreenState extends State<AllOrdersTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: 7,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
              },
              child: const OrderItem(name: 'hello'),
          ),
    ),
        )
    );
  }
}
