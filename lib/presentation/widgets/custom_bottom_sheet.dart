import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vyapar_dost/presentation/widgets/responsive.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final double initialChildSize;
  final double maxChildSize;
  final double minChildSize;
  final bool isDismissible;
  const CustomBottomSheet({Key key, this.child, this.initialChildSize, this.maxChildSize, this.minChildSize, this.isDismissible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool dismiss = isDismissible ?? true;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        dismiss ? Navigator.of(context).pop() : null;
      },
      child: DraggableScrollableSheet(
        initialChildSize: initialChildSize ?? 0.5,
        maxChildSize: maxChildSize ?? 0.5,
        minChildSize: minChildSize ?? 0.5,
        builder:(_, controller) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: EdgeInsets.only(left: Responsive.isDesktop(context) ? 35.w : 15, right: Responsive.isDesktop(context) ? 35.w : 15, top: 4.h, bottom: 0.h),
            child: child,
        ),
      ),
    );
  }
}
