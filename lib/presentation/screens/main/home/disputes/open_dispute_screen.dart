import 'package:flutter/material.dart';

import '../widgets/dispute_widget.dart';

class OpenDisputeScreen extends StatefulWidget {
  const OpenDisputeScreen({Key? key}) : super(key: key);

  @override
  State<OpenDisputeScreen> createState() => _OpenDisputeScreenState();
}

class _OpenDisputeScreenState extends State<OpenDisputeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
              },
              child: const DisputeWidget(disputeType: "Open", currentStatus: 'Dispute Raised on July 20th, 2022'),
            ),
          ),
        )
    );
  }
}
