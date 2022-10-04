import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/core_controller.dart';

class CoreBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CoreController());
  }

}