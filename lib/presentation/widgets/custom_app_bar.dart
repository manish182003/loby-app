import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';

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
              SizedBox(
                width: 42,
                height: 42,
                child: MaterialButton(
                  shape: const CircleBorder(),
                  color: textCharcoalBlueColor,
                  onPressed: () {
                    if(onBack == null){
                      Navigator.pop(context);
                    }else{
                      onBack!();
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
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
                    style: textTheme.headline2
                        ?.copyWith(color: txtColor ?? textWhiteColor),
                  ),
                ),
              ),
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
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Row(
          children: [
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
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                appBarName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headline2?.copyWith(color: txtColor ?? textWhiteColor),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
