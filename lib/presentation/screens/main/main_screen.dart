import 'package:flutter/material.dart';
import '../../../main.dart';
import 'widgets/custom_tabbed_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: contextKey,
        resizeToAvoidBottomInset: false,
        body: const SafeArea(
            child: CustomTabbedAppBar()
        ),
      ),
    );
  }
}
