import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/domain/entities/slots/get_slots_for_buyer.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/getx/controllers/slots_controller.dart';
import 'package:loby/presentation/screens/main/profile/time_slots/widget/buyer_time_slot_box.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:drop_shadow/drop_shadow.dart';

class BuyerTimeSlot extends StatefulWidget {
  bool? isEditing;
  final int id;
  BuyerTimeSlot({super.key, required this.id, this.isEditing = false});

  @override
  State<BuyerTimeSlot> createState() => _BuyerTimeSlotState();
}

class _BuyerTimeSlotState extends State<BuyerTimeSlot> {
  SlotsController slotsController = Get.find<SlotsController>();
  AuthController authController = Get.find<AuthController>();
  OrderController orderController = Get.find<OrderController>();
  final controller = ScrollController();
  Rx<DateFormat> format2 = DateFormat('MMMM yyyy').obs;

  DateTime _currentDate = DateTime.now();

  Future<void> getBuyerSlots() async {
    // slotsController.getSlots();
    slotsController.areMoreSlotsAvailable.value = true;
    // slotsController.editSlot(
    //     date: orderController.orders.first.bookDate,
    //     orderId: orderController.orders.first.id,
    //     slotId: orderController.orders.first.slotId);
    slotsController.getBuyerSlots(
        providerId: widget.id,
        date: "${DateFormat('yyyy-MM-dd').format(_currentDate)}");
  }

  // final selectedIndex = 0.obs;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    slotsController.selectDateofCale.value = [
      DateFormat('yyyy-MM-dd').format(DateTime.now())
    ];
    slotsController.selectDateofCale.refresh();
    getBuyerSlots();
    // getBuyerSlots();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   slotsController.getSlots(sellerId: 1);

    //   controller.addListener(() {
    //     if (controller.position.maxScrollExtent == controller.offset) {
    //       slotsController.getSlots();
    //     }
    //   });
    // });
  }

  // Future<void> getBuyerSlots() async {
  //   slotsController.providerid.value = 1;
  //   slotsController.areMoreSlotsAvailable.value = true;
  //   slotsController.getBuyerSlots();
  // }

  void _initializeDateFormat() {
    // initializeDateFormat('fr_FR');
  }

  void _changeMonth(int monthsToAdd) {
    setState(() {
      _currentDate =
          DateTime(_currentDate.year, _currentDate.month + monthsToAdd);
    });
  }

  bool _isBeforeCurrentDate(DateTime date) {
    final today = DateTime.now();
    return date.isBefore(DateTime(today.year, today.month, today.day));
  }

  @override
  Widget build(BuildContext context) {
    print("slecteddddd ${slotsController.selectSlotArr}");
    print("lenghttttttttttttttttttttt >> ${slotsController.buyerSlots.length}");
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          // appBar(context: context,isBackIcon: true),
          
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/login_bg_img.jpeg"),
                    opacity: 0.5,
                    fit: BoxFit.fill)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                width: 42,
                height: 42,
                child: MaterialButton(
                  shape: const CircleBorder(),
                  color: textCharcoalBlueColor,
                  onPressed: () {
                      Navigator.pop(context);
                    
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
                    GestureDetector(
                  onTap: () {
                    context.pushNamed(searchScreenPage);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: textCharcoalBlueColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Icon(CupertinoIcons.search, size: 23, color: Colors.white,),
                  ),
                ),
                  ],
                ),
              
              ),
            )),
            
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Align(
                      child: SizedBox(
                        width: 100.w,
                        // height: 30.h,
                        child: Image.asset(
                          "assets/images/calender_container.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0.w),
                    child: Align(
                      child: SizedBox(
                        child: 
                        orderController.selectedOrder.value.userGameService?.user?.image != null ?
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: whiteColor,
                          backgroundImage: NetworkImage("${orderController.selectedOrder.value.userGameService?.user?.image}"),
                          // backgroundImage: AssetImage("assets/images/view.png"),
                        ) : CircleAvatar(
                          radius: 32,
                          backgroundColor: whiteColor,
                          backgroundImage: AssetImage("assets/images/user_placeholder.png"),
                          // backgroundImage: AssetImage("assets/images/view.png"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 23.0.w),
                    child: Align(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "${orderController.selectedOrder.value.userGameService?.user?.name}",
                              style: textTheme.headline4
                                  ?.copyWith(color: textWhiteColor),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _changeMonth(-1);
                                    return;
                                  },
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: lavaRedColor,
                                    child: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: whiteColor,
                                      size: 10,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  format2.value.format(_currentDate),
                                  style: textTheme.headline4
                                      ?.copyWith(color: textWhiteColor),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    _changeMonth(1);
        
                                    return;
                                  },
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: lavaRedColor,
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: whiteColor,
                                      size: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 320,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                child: Obx(() {
                                  if (slotsController
                                      .selectDateofCale.isNotEmpty) {
                                    return Container(
                                      height: 100,
                                      padding: const EdgeInsets.only(
                                        top: 4.0,
                                      ),
                                      child: Row(
                                        children: List.generate(
                                          DateTime(_currentDate.year,
                                                  _currentDate.month + 1, 0)
                                              .day,
                                          (index) {
                                            DateTime date = DateTime(
                                                _currentDate.year,
                                                _currentDate.month,
                                                index + 1);
                                            if (_isBeforeCurrentDate(date)) {
                                              return SizedBox();
                                            } else {
                                              // availbale
                                              //     .availableDoctor.value.availabilities!
                                              //     .clear();
                                            }
                                            String formattedDate =
                                                DateFormat('dd').format(date);
                                            String selectDateApi =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date);
                                            String formattedDatee =
                                                DateFormat('EEEE').format(date);
                                            String dateSlect =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date);
                                            String formattedDateSort =
                                                DateFormat('ccccc').format(date);
                                            String month =
                                                DateFormat('MMMM').format(date);
        
                                            print("storeLanguagetttt");
                                            String formattedDay =
                                                DateFormat('E').format(date);
                                            // return SizedBox();
                                            return selectDate(
                                              pId: widget.id,
                                              index,
                                              formDay: formattedDay,
                                              title:
                                                  formattedDatee.toUpperCase() ??
                                                      "",
                                              date: formattedDate,
                                              sortName: formattedDateSort,
                                              selectDate: dateSlect,
                                              chooseDate: selectDateApi,
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                  return Text("Date hi empty aai");
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  // Image(image: AssetImage("assets/images/calender_container.png"), ),
                  // Positioned(
                  //   top: 12,
                  //   left: 124,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: CircleAvatar(
                  //         foregroundColor: aquaGreenColor,
                  //         backgroundColor: aquaGreenColor,
                  //         radius: 35,
                  //         backgroundImage: AssetImage("assets/images/user_placeholder.png"),
                  //       ),
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 100,
                  //   left: 110,
                  //   child: Text("Akshay gupta ✅", style: textTheme.headline4
                  //                                 ?.copyWith(color: textWhiteColor))),
                  //                                 Positioned(
                  //                                   top: 130,
                  //                                   left: 75,
                  //                                   child: Row(
                  //                                     mainAxisAlignment: MainAxisAlignment.center,
                  //                                     crossAxisAlignment: CrossAxisAlignment.center,
                  //                                     children: [
                  //                                       CircleAvatar(
                  //                                         radius: 8,
                  //                                         backgroundColor: lavaRedColor,
                  //                                         child: Text("<" , style: TextStyle(color: whiteColor, fontSize: 8),),
                  //                                       ),
                  //                                       SizedBox(width: 5.w,),
                  //                                       Text("November 2023" , style: textTheme.headline4
                  //                                 ?.copyWith(color: textWhiteColor)),
                  //                                 SizedBox(width: 5.w,),
                  //                                 CircleAvatar(
                  //                                         radius: 8,
                  //                                         backgroundColor: lavaRedColor,
                  //                                         child: Text(">", style: TextStyle(color: whiteColor ,fontSize: 8)),
                  //                                       ),
                  //                                     ],
                  //                                   ))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(

                padding: const EdgeInsets.only(top: 2),
                child: Container(
                  height: 52.h,
                  width: MediaQuery.of(context).size.width,
                  // child: Text("hellooo", style: TextStyle(color: Colors.amber , fontSize: 60),),
                  decoration: const BoxDecoration(
                      color: backgroundColor,
                      // border: Border(top: BorderSide(color: Colors.white)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  // child: Text("Login", style: textTheme.headline2?.copyWith(color: textWhiteColor)),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                          child: Obx(() {
                            if (slotsController.buyerSlots.isNotEmpty) {
                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 3.h),
                                    height: 40.h,
                                    child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: slotsController.buyerSlots.length,
                                          itemBuilder: (context, index) {
                                            return BuyerTimeSlotBox(
                                                getBuyerSlots:
                                                    slotsController.buyerSlots[index]);
                                          },
                                        ),
                                    // ),
                                    // ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  CustomButton(
                                      name: "Confirm Slot",
                                      textColor: textWhiteColor,
                                      color: purpleLightIndigoColor,
                                      left: 4.w,
                                      right: 4.w,
                                      // bottom: 1.h,
                                      onTap: () async {
                                        slotsController.editSlot(
                                          date: slotsController
                                                  .selectDateofCale.first
                                                  .toString(),
                                          orderId: orderController
                                                  .selectedOrder.value.id,
                                                  
                                          slotId: slotsController.selectSlotArr.first.id,
                                              // isUpdatingTime: true,
                                              // listingId: orderController
                                              //     .selectedOrder
                                              //     .value
                                              //     .userGameServiceId!,
                                              // quantity: orderController
                                              //     .selectedOrder.value.quantity!,
                                              // price: orderController
                                              //     .selectedOrder.value.price
                                              //     .toString(),
                                              // bookDate: slotsController
                                              //     .selectDateofCale.first
                                              //     .toString(),
                                              // bookFromTime: slotsController
                                              //     .selectSlotArr.first.from,
                                              // bookToTime: slotsController
                                              //     .selectSlotArr.first.to,
                                            )
                                            .then(
                                                (value) => _successDialog(context));
                                        print(
                                            " buyerdatepage >>>  ${slotsController.selectDateofCale.first.toString()}");
                                      }),
                                ],
                              );
                            }
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              child: Center(
                                child: Text("No slots found!"),
                              ),
                            );
                          }))
                    ],
                  ),
                ),
              ),
            ],
          )
          // Positioned(
          //   top: 80,
          //   child: Image(image: AssetImage("assets/images/calender_container.png"))
        
          // ),
          // Positioned(
          //   bottom: 0,
          //   child: Container(
          //     height: 50.h,
          //     width: MediaQuery.of(context).size.width,
          //     // child: Text("hellooo", style: TextStyle(color: Colors.amber , fontSize: 60),),
          //     decoration: const BoxDecoration(
          //         color: backgroundColor,
          //         // border: Border(top: BorderSide(color: Colors.white)),
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(30),
          //           topRight: Radius.circular(30),
          //         )),
          //     // child: Text("Login", style: textTheme.headline2?.copyWith(color: textWhiteColor)),
          //     child: Column(
          //       children: [
          //         Padding(
          //             padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
          //             child: Column(
          //               children: [
          //                 ListView.builder(
          //                   shrinkWrap: true,
          //                   itemCount: 4,
          //                   itemBuilder: (context, index) {
          //                     return Padding(
          //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
          //                       child: Column(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Container(
          //                                 height: 40,
          //                                 width: MediaQuery.of(context).size.width,
          //                                 decoration: BoxDecoration(
          //                                   borderRadius: BorderRadius.circular(5),
          //                                     border: Border.all(color: aquaGreenColor, strokeAlign: 1)),
          //                                 child: Center(
          //                                   child: Text(
          //                                     "08:00 am - 10:00 am",
          //                                     style: textTheme.headline4
          //                                         ?.copyWith(color: textWhiteColor),
          //                                   ),
          //                                 ),
          //                               ),
          //                           SizedBox(height: 1.h,),
          //                           Text("Available",style: textTheme.headline6?.copyWith(
          //                                 color: aquaGreenColor,
          //                                 fontWeight: FontWeight.w100) ),
          //                                 SizedBox(height: 1.h,),
          //                         ],
          //                       ),
          //                     );
          //                   },
          //                 ),
          //                 SizedBox(height: 1.h,),
          //                 CustomButton(
          //           name: "Confirm Slot",
          //           textColor: textWhiteColor,
          //           color: purpleLightIndigoColor,
          //           left: 4.w,
          //           right: 4.w,
          //           bottom: 5.h,
          //           onTap: () async{
          //             // _loginDialog(context);
          //           }),
          //               ],
          //             )),
          //       ],
          //     ),
          //   ),
          // )
        ]),
      ),
    );
  }

  Future<void> _successDialog(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundDarkJungleGreenColor,

          // title: Text('Delete Slot'),

          content: SingleChildScrollView(
            child: 
            Column(
              children: <Widget>[
                Text("Slot Booking Done", style: textTheme.headline2?.copyWith(color: textWhiteColor, fontSize: 17.sp, fontWeight: FontWeight.w500)),
                SizedBox(height: 2.h,),
                Image(image: AssetImage("assets/images/success_logo.png")),
                SizedBox(height: 2.h,),
              ],
            ),
          ),
          
          actions: <Widget>[
            CustomButton(
                                  height: 8.h,
                                  fontSize: 15.sp,
                                  name: "Done",
                                  color: aquaGreenColor,

                                  // left: 0.w,
                                  // right: 0.w,
                                  bottom: 3.h,
                                  top: 2.h,
                                  onTap: () async {
                                    context.pushNamed(myOrderPage);
                                  }),
          ],
          //   Column(
          //     children: <Widget>[
          //       Image(image: AssetImage("assets/images/success.jpg"))
          //     ],
          //   ),
          // ),
          // actions: <Widget>[
          //   TextButton(
          //     child: Text(
          //       'Done',
          //       style: TextStyle(color: aquaGreenColor),
          //     ),
          //     onPressed: () {
          //       context.pushNamed(mainPage);
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}

Widget selectDate(int i,
    {required String chooseDate,
    required String title,
    required String formDay,
    required String date,
    Color? colors,
    required String sortName,
    required String selectDate,
    required int pId}) {
  String? currentDate;
  int? selectDateIndex = 0;
  String? dateStore;
  int selectDateIndexDefult = 0;
  String selectValue = "";
  RxString dayValue = "".obs;
  String dateSelect = "";
  int eveningSelectIndex = -1;
  int afterNoonSelectIndex = -1;
  int morselectIndex = -1;
  int nightSelectIndex = -1;
  dynamic theme = GoogleFonts.poppins(
    fontSize: 10.2,
    fontWeight: FontWeight.w700,
    height: 1.5,
    color: currentDate == chooseDate && currentDate != ""
        ? whiteColor
        : selectDateIndex != i
            ? textBlackColor
            : textBlackColor,
  );
  dynamic theme1 = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: currentDate == chooseDate && currentDate != ""
        ? whiteColor
        : selectDateIndex != i
            ? whiteColor
            : const Color(0xffffffff),
  );

  SlotsController slotsController = Get.find<SlotsController>();
  print("slecwdjckjcbck >>>> ${chooseDate}");
  return GestureDetector(
    onTap: () {
      // dateStore = chooseDate;
      // print("chooseDate");
      // print(dateStore);
      // print(chooseDate);
      // print("chooseDate");
      // currentDate = "";
      // selectDateIndexDefult = -1;
      // // availbale.getAvailablity(doctorId: widget.doctorId, date: chooseDate);
      // selectDateIndex = i;
      // selectValue = title;
      // dayValue.value = title;
      // dateSelect = selectDate;
      // print("selectDate");
      // print(selectDate);
      // print(title);
      // print("selectDate");
      // eveningSelectIndex = -1;
      // afterNoonSelectIndex = -1;
      // morselectIndex = -1;
      // nightSelectIndex = -1;
      slotsController.selectDateofCale.value = ['$chooseDate'];
      slotsController.selectDateofCale.refresh();
      slotsController.getBuyerSlots(date: chooseDate, providerId: pId);
      print("chooosseeee >> $chooseDate");
      // setState(() {});
    },
    child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.fromLTRB(4, 5, 4, 6),
        width: 36,
        height: 61,
        decoration: BoxDecoration(
          color: slotsController.selectDateofCale.contains(chooseDate)
              ? orangeColor
              : textCharcoalBlueColor,
          // color: chooseDate.isNotEmpty ? orangeColor : textCharcoalBlueColor,

          //  currentDate == chooseDate && currentDate != ""
          //     ? orangeColor
          //     : i != selectDateIndex
          //         ? textCharcoalBlueColor
          //         : orangeColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            width: double.infinity,
            height: 25,
            decoration: BoxDecoration(
              color: currentDate == chooseDate && currentDate != ""
                  ? whiteColor
                  : selectDateIndex != i
                      ? whiteColor
                      : whiteColor,
              borderRadius: BorderRadius.circular(12.5),
            ),
            child: Center(
              child: Text(
                formDay,
                style: theme,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 1, 0),
            child: Text(
              date,
              style: theme1,
            ),
          ),
        ])),
  );
}
