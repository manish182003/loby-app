import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:loby/main.dart';
import 'package:loby/services/routing_service/routes.dart';
import 'routing_service/routes_name.dart';


class FirebaseDynamicLinkService{


  static Future<String?> initDynamicLink(BuildContext context, PendingDynamicLinkData? initialLink)async {


    if(initialLink != null){
      final Uri deepLink = initialLink.link;
      bool isListingPage = deepLink.pathSegments.contains('user-game-service');
      String? id = deepLink.queryParameters['listingId'];
      if (isListingPage) {
        context.pushNamed(gameDetailPage, queryParams: {'serviceListingId' : "$id"});
      } else {
        context.pushNamed(gameDetailPage, queryParams: {'serviceListingId' : "$id"});
      }
    }
    return null;
  }

}