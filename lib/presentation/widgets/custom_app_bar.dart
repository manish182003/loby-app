import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../core/theme/colors.dart';
import '../../services/routing_service/routes_name.dart';

class CustomAppBar extends StatelessWidget {
  final String? appBarName;
  final IconData? otherIcon;
  final Color? txtColor;
  final Function()? onBack;

  const CustomAppBar({Key? key, this.appBarName, this.otherIcon, this.txtColor, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Row(
        children: [
          Stack(
            children: [
              // SizedBox(
              //   width: 42,
              //   height: 42,
              //   child: MaterialButton(
              //     shape: const CircleBorder(),
              //     color: textCharcoalBlueColor,
              //     onPressed: () {
              //       if(onBack == null){
              //         Navigator.pop(context);
              //       }else{
              //         onBack!();
              //         Navigator.pop(context);
              //       }
              //     },
              //     child: const Icon(
              //       Icons.arrow_back_ios,
              //       size: 18,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 44.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    appBarName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headline2?.copyWith(color: txtColor ?? textWhiteColor),
                  ),
                ),
              ),
              // `InkWell(
              //   onTap: () {
                  
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container( 
              //       color: textCharcoalBlueColor,
              //       child: Icon(Icons.search)),
              //   ),
              // )`
            ],
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget appBar({required BuildContext context, String? appBarName,
  IconData? otherIcon,
  Color? txtColor,
  Function()? onBack,
  bool isBackIcon = true,
}){
  final textTheme = Theme.of(context).textTheme;
  return PreferredSize(
    preferredSize: const Size(double.infinity, 70),
    child: SafeArea(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Stack(
          children: [
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //     onTap: () {
            //       context.pushNamed(searchScreenPage);
            //     },
            //     child: Container(
            //       height: 40,
            //       width: 40,
            //       decoration: BoxDecoration(
            //         color: textCharcoalBlueColor,
            //         borderRadius: BorderRadius.circular(10)
            //       ),
            //       child: const Icon(CupertinoIcons.search, size: 23, color: Colors.white,),
            //     ),
            //   ),
            //   child: SizedBox(
            //   // width: 40,
            //   // height: 42,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: MaterialButton(
            //       shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //       color: textCharcoalBlueColor,
            //       onPressed: () {
            //         if(onBack == null){
            //           Navigator.pop(context);
            //         }else{
            //           onBack();
            //           Navigator.pop(context);
            //         }
            //       },
            //       child: const Icon(
            //           CupertinoIcons.search,                    
            //           size: 25,
            //           color: Colors.white,
            //         ),
            //     ),
            //   ),
            // )
            // ),
            Align(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                appBarName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headline2?.copyWith(color: txtColor ?? aquaGreenColor),
              ),
            ),
            isBackIcon ? SizedBox(
              width: 42,
              height: 42,
              child: MaterialButton(
                shape: const CircleBorder(),
                color: textCharcoalBlueColor,
                onPressed: () {
                  if(onBack == null){
                    Navigator.pop(context);
                  }else{
                    onBack();
                    Navigator.pop(context);
                  }
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ) : const SizedBox() ,
            
          ],
        ),
      ),
    ),
  );
}
