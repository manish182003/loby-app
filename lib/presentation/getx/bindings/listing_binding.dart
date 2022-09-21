import 'package:get/get.dart';
import 'package:loby/domain/usecases/auth/get_cities.dart';
import 'package:loby/domain/usecases/auth/get_countries.dart';
import 'package:loby/domain/usecases/auth/get_profile_tags.dart';
import 'package:loby/domain/usecases/auth/get_states.dart';
import 'package:loby/domain/usecases/auth/signup.dart';
import 'package:loby/domain/usecases/auth/update_profile.dart';
import 'package:loby/domain/usecases/listing/create_listing.dart';
import 'package:loby/domain/usecases/listing/get_buyer_listings.dart';
import 'package:loby/domain/usecases/listing/get_configurations.dart';
import 'package:loby/domain/usecases/listing/report_listing.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';

import '../controllers/listing_controller.dart';

class ListingBinding extends Bindings {

  @override
  void dependencies() {

    final getConfigurations = Get.find<GetConfigurations>();
    final createListing = Get.find<CreateListing>();
    final getBuyerListings = Get.find<GetBuyerListings>();
    final reportListing = Get.find<ReportListing>();


    Get.lazyPut(() => ListingController(
      getConfigurations: getConfigurations,
      createListing: createListing,
      getBuyerListings: getBuyerListings,
      reportListing: reportListing
    ));
  }

}