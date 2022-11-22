import 'dart:async';
import 'dart:convert';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/environment.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/core_controller.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_loading_widget.dart';
import 'package:loby/services/routing_service/router.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'core/theme/colors.dart';
import 'core/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'di/injection.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'firebase_options.dart';
import 'package:loby/services/firebase_dynamic_link.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/cupertino.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =   FlutterLocalNotificationsPlugin();
GlobalKey<ScaffoldState> contextKey = GlobalKey<ScaffoldState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.messageId}');
  debugPrint('${message.data}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description : 'This channel is used for important notifications.', // description
  importance: Importance.max,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.fileName);
  bool isDeviceConnected = await InternetConnectionChecker().hasConnection;
  if (!isDeviceConnected) {
    runApp(const NoInternetConnection());
  }else{
    runMainApp();
  }
}

Future<void> runMainApp()async{
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  PendingDynamicLinkData? initialLink;

  DependencyInjector.inject();

  final router = MyRouter();
  GoRouter appRouter = await router.appRouter(initialLink: initialLink);

  AuthController authController = Get.find<AuthController>();
  await authController.saveProfileDetails();

  Helpers.hideLoader();
  runApp(MyApp(appRouter: appRouter, initialLink: initialLink));

}

class MyApp extends StatefulWidget {
  final GoRouter appRouter;
  final PendingDynamicLinkData? initialLink;
  const MyApp({Key? key, required this.appRouter, this.initialLink}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  CoreController coreController = Get.find<CoreController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePushNotification();
    _handleDynamicLink();
  }


  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Loby',
        theme: ApplicationTheme.getAppThemeData(),
        routeInformationProvider: widget.appRouter.routeInformationProvider,
        routeInformationParser: widget.appRouter.routeInformationParser,
        routerDelegate: widget.appRouter.routerDelegate,
        builder: FlutterSmartDialog.init(
          loadingBuilder: (String msg) => const CustomLoadingWidget(),
        ),
      );
    });
  }



  Future<void> initializePushNotification()async{

    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (data){
      Get.find<CoreController>().onNotificationClick(data!, contextKey.currentContext!);
    });

    FirebaseMessaging.onMessage.listen(_showNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_showNotification);
    FirebaseMessaging.instance.getInitialMessage();
    getToken();
  }


  Future getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fcmToken", token!);
    debugPrint('FCM Notification Token ${prefs.getString('fcmToken')}');
  }


  void _showNotification(RemoteMessage message){
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    final data = jsonEncode(message.data);
    debugPrint("Notification Data $data");
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription : channel.description,
            icon: android.smallIcon,
            importance: Importance.high,
            ongoing: true,
            styleInformation: const BigTextStyleInformation(''),
          ),
          iOS: const IOSNotificationDetails(),
        ),
        payload: data,
      );
    }
  }

  void _handleDynamicLink(){
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      bool isListingPage = deepLink.pathSegments.contains('user-game-service');
      String? id = deepLink.queryParameters['listingId'];

      if (isListingPage) {
        contextKey.currentContext?.goNamed(gameDetailPage, queryParams: {'serviceListingId' : "$id"});
      } else {
        contextKey.currentContext?.goNamed(gameDetailPage, queryParams: {'serviceListingId' : "$id"});
      }
    }).onError((error){
      print(error);
    });


    if(widget.initialLink != null){
      final Uri deepLink = widget.initialLink!.link;
      bool isListingPage = deepLink.pathSegments.contains('user-game-service');
      String? id = deepLink.queryParameters['listingId'];
      if (isListingPage) {
        contextKey.currentContext?.goNamed(gameDetailPage, queryParams: {'serviceListingId' : "$id"});
      } else {
        contextKey.currentContext?.goNamed(gameDetailPage, queryParams: {'serviceListingId' : "$id"});
      }
    }
  }
}

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loby',
        theme: ApplicationTheme.getAppThemeData(),
        builder: FlutterSmartDialog.init(
          loadingBuilder: (String msg) => const CustomLoadingWidget(),
        ),
        home: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/no_internet.png', width: 10.h,height: 10.h,),
              // SvgPicture.asset(
              //   'assets/icons/tick.svg',
              //   width: 10.h,
              //   height: 10.h,
              // ),
              SizedBox(height: 2.h,),
              Text('No Internet Connection',
                  textAlign: TextAlign.center,
                  style: textTheme.subtitle1?.copyWith(color: whiteColor)),
              SizedBox(height: 5.h,),
              CustomButton(
                  name: "Retry",
                  color: aquaGreenColor,
                  left: 10.w,
                  right: 10.w,
                  bottom: 5.h,
                  onTap: () async{
                    bool isDeviceConnected = await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      Helpers.toast('Internet Not Connected');
                    }else{
                      Helpers.loader();
                      runMainApp();
                    }
                  }),
            ],
          ),
        ),
      );
    });
  }
}

