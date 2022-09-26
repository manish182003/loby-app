import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/buttons/custom_button.dart';
import '../../../../widgets/input_text_widget.dart';

class AddFundsScreen extends StatefulWidget {
  const AddFundsScreen({Key? key}) : super(key: key);

  @override
  State<AddFundsScreen> createState() => _AddFundsScreenState();
}

class _AddFundsScreenState extends State<AddFundsScreen> {

  ProfileController profileController = Get.find<ProfileController>();
  TextEditingController amount = TextEditingController();
  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(preferredSize:Size(double.infinity, 70), child: CustomAppBar(appBarName: "Add Funds")),
        body: BodyPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Card(
                    color: shipGreyColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 140.0,
                        decoration: BoxDecoration(
                          color: aquaGreenColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8.0),
                          child: Column(
                            children: [
                              Text('Current Balance',
                                  textAlign: TextAlign.center,
                                  style: textTheme.headline3?.copyWith(color: textTunaBlueColor, fontWeight: FontWeight.w500)),
                              Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                                child: Text('₹ ${profileController.profile.walletMoney}',
                                    textAlign: TextAlign.center,
                                    style: textTheme.headlineLarge?.copyWith(color: textTunaBlueColor, fontFamily: 'Inter')),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 110.0),
                    child: Card(
                      color: shipGreyColor,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          color: shipGreyColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: InputTextWidget(
                                  hintName: 'Enter Amount (INR)',
                                  keyboardType: TextInputType.number,
                                  controller: amount,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: CustomButton(
                                        color: purpleLightIndigoColor,
                                        textColor: textWhiteColor,
                                        name: "Add Funds",
                                        onTap: _openCheckout,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response)async {
    await profileController.verifyPayment(signature: response.signature, paymentId: response.paymentId, paymentStatus: 'success', orderId: response.orderId);
    await Helpers.hideLoader();
    Helpers.toast("SUCCESS : ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Helpers.hideLoader();
    Helpers.toast("ERROR : ${response.message} with ${response.code}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Helpers.hideLoader();
    Helpers.toast("EXTERNAL WALLET : ${response.walletName}");
  }

  Future<void> _openCheckout()async{
    await Helpers.loader();
    final isSuccess = await profileController.addFunds(amount: int.tryParse(amount.text));
    if(isSuccess){
      var options = {
        'key': 'rzp_test_w3kuff6E1thtE3',
        'amount': int.tryParse("${amount.text}00"),
        'name': 'Loby',
        'order_id': profileController.addFundsResponse['order_id'],
        'description': 'Add Fund to Wallet',
        'timeout': 60,
        'prefill': {
          'contact': '8888888888',
          'email': 'test@razorpay.com'
        }
      };

      try{
        _razorpay.open(options);
      }catch(e){
        debugPrint("Error : $e");
      }
    }

  }
}
