import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class WalletKyc extends StatefulWidget {
  const WalletKyc({super.key});

  @override
  State<WalletKyc> createState() => _WalletKycState();
}

class _WalletKycState extends State<WalletKyc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        appBarName: 'KYC',
        isBackIcon: true,
        txtColor: textWhiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(3.h),
        child: Container(
          width: 100.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: shipGreyColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 43, vertical: 20),
            child: Column(
              children: [
                Text(
                  'As per Government norms, KYC Verification is mandatory for Loby Users to withdraw money to ensure that their identity & services are not being misused (Prevention of Money Laundering Act, 2002)',
                  style: TextStyle(
                    fontSize: 10.spa,
                    fontWeight: FontWeight.w300,
                    color: textWhiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Please select the preferred KYC method',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textWhiteColor,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Color(0xFF00FF62)),
                    minimumSize: WidgetStatePropertyAll<Size>(
                        Size(double.infinity, 7.h)),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: Text(
                    'AADHAAR OTP',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF263238),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Color(0xFF00FF62)),
                    minimumSize: WidgetStatePropertyAll<Size>(
                        Size(double.infinity, 7.h)),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: Text(
                    'PAN CARD',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF263238),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
