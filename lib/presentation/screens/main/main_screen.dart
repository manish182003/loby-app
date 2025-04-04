import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

import '../../../main.dart';
import 'widgets/custom_tabbed_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  Future<void> _authenticateOnStartUp() async {
    logger.e('biometric  start');
    final isAuthenticate = await Helpers.biometricAuthenticate();
    logger.e('biometric->$isAuthenticate');
    if (!isAuthenticate) {
      SystemNavigator.pop();
    } else {
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _authenticateOnStartUp();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _authenticateOnStartUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: contextKey,
        resizeToAvoidBottomInset: false,
        body: const SafeArea(child: CustomTabbedAppBar()),
      ),
    );
  }
}
