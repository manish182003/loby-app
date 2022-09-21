import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routing_service/routes_name.dart';


class FirebaseDynamicLinkService{


  static Future<void> initDynamicLink(BuildContext context, initialLink)async {


    final Uri deepLink = initialLink.link;
    bool isSeller = deepLink.pathSegments.contains('sellers-catalog');
    bool isLogin = deepLink.pathSegments.contains('login');
    // if (isSeller) {
    //   String? id = deepLink.queryParameters['sellerID'];
    //   return context.goNamed(sellersCatalogPage, queryParams: {'sellerID': id});
    // }else if(isLogin){
    //   String token = deepLink.queryParameters['token'];
    //   if (deepLink != null) {
    //     return context.goNamed(loginPage, extra: token);
    //   }
    // }else{
    //   return ;
    // }

    return ;
  }
}