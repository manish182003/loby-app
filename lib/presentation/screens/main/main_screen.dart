import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';

import 'widgets/custom_tabbed_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: CustomTabbedAppBar()),
      ),
    );
  }
}
