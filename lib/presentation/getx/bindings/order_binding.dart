import 'package:get/get.dart';
import 'package:loby/domain/usecases/order/change_order_status.dart';
import 'package:loby/domain/usecases/order/select_duel_winner.dart';
import 'package:loby/domain/usecases/order/submit_rating.dart';
import 'package:loby/domain/usecases/order/upload_delivery_proof.dart';


import '../../../domain/usecases/order/create_order.dart';
import '../../../domain/usecases/order/get_orders.dart';
import '../controllers/order_controller.dart';

class OrderBinding extends Bindings {

  @override
  void dependencies() {

    final createOrder = Get.find<CreateOrder>();
    final getOrders = Get.find<GetOrders>();
    final changeOrderStatus = Get.find<ChangeOrderStatus>();
    final uploadDeliveryProof = Get.find<UploadDeliveryProof>();
    final submitRating = Get.find<SubmitRating>();
    final selectDuelWinner = Get.find<SelectDuelWinner>();

    Get.lazyPut(() => OrderController(
      createOrder: createOrder,
      getOrders: getOrders,
      changeOrderStatus: changeOrderStatus,
      uploadDeliveryProof: uploadDeliveryProof,
      submitRating: submitRating,
      selectWinnerDuel: selectDuelWinner,
    ));
  }

}