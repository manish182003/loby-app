import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/presentation/screens/auth/sign_in_screen.dart';
import 'package:loby/presentation/screens/main/home/home_screen.dart';
import 'package:loby/services/routing_service/router.dart';
import 'package:loby/services/routing_service/routes.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

import 'core/theme/theme.dart';

void main() async {
  final router = MyRouter();
  GoRouter appRouter = await router.appRouter();
  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  GoRouter appRouter;
  MyApp({Key? key, required this.appRouter}) : super(key: key);
  /*final _router = GoRouter(
    routes: [
      GoRoute(
        name: initialPage,
        path: initialRoute,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        name: homePage,
        path: homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );*/


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Loby',
        theme: ApplicationTheme.getAppThemeData(),
        routeInformationProvider: appRouter.routeInformationProvider,
        routeInformationParser: appRouter.routeInformationParser,
        routerDelegate: appRouter.routerDelegate,
      );
    });
  }
}
