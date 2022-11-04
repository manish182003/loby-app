import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/services/routing_service/router.dart';
import 'package:loby/services/firebase_dynamic_link.dart';
import 'package:loby/services/routing_service/routes_name.dart';

class RoutingService extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  const RoutingService({Key? key, this.initialLink}) : super(key: key);

  @override
  State<RoutingService> createState() => _RoutingServiceState();
}

class _RoutingServiceState extends State<RoutingService> {


  final routerClass = MyRouter();

  @override
  void initState() {
    super.initState();
    asyncFunction();
  }


  Future<void> asyncFunction()async{
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.initialLink != null){
        FirebaseDynamicLinkService.initDynamicLink(context, widget.initialLink);
      }else{
        context.goNamed(mainPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(child: CircularProgressIndicator()),
              Text("Redirecting...!"),
            ],
          ),
        ),
      ),
    );
  }
}
