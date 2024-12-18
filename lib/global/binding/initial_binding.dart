import 'package:chameleon/app/modules/interner_contectivity.dart';
import 'package:get/get.dart';

import '../../../../global/networking/dio_helper.dart';
import '../../app/modules/home/controllers/calculate_receiver_location_controller.dart';
import '../../app/modules/home/controllers/calculate_sender_location_controller.dart';
import '../../app/modules/home/controllers/current_waybill_controller.dart';
import '../controllers/language_controller.dart';
import '../controllers/loading_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DioHelper(), permanent: true);

    // put loading controller and language controller because they are used in all pages
    Get.put(LoadingController(), permanent: true);
    Get.put(LanguageController(), permanent: true);
    Get.put(InternetController(), permanent: true);
    Get.delete<CurrentWaybillController>();
    Get.delete<CalculateSenderLocationController>();
    Get.delete<CalculateReceiverLocationController>();
    //Get.delete<CalculateReturnContainerController>();

  }
}
