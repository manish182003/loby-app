import 'package:flutter/material.dart';

import '../widgets/dispute_widget.dart';

class ClosedDisputeScreen extends StatefulWidget {
  const ClosedDisputeScreen({Key? key}) : super(key: key);

  @override
  State<ClosedDisputeScreen> createState() => _ClosedDisputeScreenState();
}

class _ClosedDisputeScreenState extends State<ClosedDisputeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
              },
              child: const DisputeWidget(disputeType: 'Closed', currentStatus: 'Resolved on July 20th 2022'),
            ),
          ),
        )
    );
  }
}
