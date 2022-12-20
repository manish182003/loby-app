import 'package:get/get.dart';
import 'package:loby/domain/usecases/listing/change_listing_status.dart';
import 'package:loby/domain/usecases/listing/create_listing.dart';
import 'package:loby/domain/usecases/listing/get_buyer_listings.dart';
import 'package:loby/domain/usecases/listing/get_configurations.dart';
import 'package:loby/domain/usecases/listing/report_listing.dart';

import '../../../domain/usecases/listing/delete_listing_image.dart';
import '../controllers/listing_controller.dart';

class ListingBinding extends Bindings {

  @override
  void dependencies() {

    final getConfigurations = Get.find<GetConfigurations>();
    final createListing = Get.find<CreateListing>();
    final getBuyerListings = Get.find<GetBuyerListings>();
    final reportListing = Get.find<ReportListing>();
    final changeListingStatus = Get.find<ChangeListingStatus>();
    final deleteListingImage = Get.find<DeleteListingImage>();

    Get.lazyPut(() => ListingController(
      getConfigurations: getConfigurations,
      createListing: createListing,
      getBuyerListings: getBuyerListings,
      reportListing: reportListing,
      changeListingStatus: changeListingStatus,
      deleteListingImage: deleteListingImage,
    ));
  }

}