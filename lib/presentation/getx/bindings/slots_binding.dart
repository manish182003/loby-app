import 'package:get/get.dart';
import 'package:loby/domain/usecases/slots/add_slots.dart';
import 'package:loby/domain/usecases/slots/copy_slots_to_all_days.dart';
import 'package:loby/domain/usecases/slots/delete_slot.dart';
import 'package:loby/domain/usecases/slots/edit_slot.dart';
import 'package:loby/domain/usecases/slots/get_buyer_slots.dart';
import 'package:loby/domain/usecases/slots/get_slots.dart';
import 'package:loby/presentation/getx/controllers/slots_controller.dart';

class SlotsBinding extends Bindings {
  @override
  void dependencies() {
    final addSlots = Get.find<AddSlots>();
    final getSlots = Get.find<GetSlots>();
    final getBuyerSlots = Get.find<GetBuyerSlots>();
    final deleteSlot = Get.find<DeleteSlots>();
    final editSlot = Get.find<EditSlot>();
    final copySlots = Get.find<CopyToAlldaysSlots>();

    Get.lazyPut(() => SlotsController(
          addSlots: addSlots,
          getSlots: getSlots,
          getBuyerSlots: getBuyerSlots,
          editSlot: editSlot,
          deleteSlots: deleteSlot,
          copySlots: copySlots,
        ));
  }
}
