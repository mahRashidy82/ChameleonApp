import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart' as intl;
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../../../../../global/controllers/language_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../model/hr/check_in_location/check_in/HrEmployeesCheckInOutLocations.dart';

class CheckinTable extends GetView {

  final List<HrEmployeesCheckInOutLocations> selectedItems;

  CheckinTable({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return kIsWeb
          ? SizedBox(
              height: selectedItems.length == 1
              ? 80
              : selectedItems.length == 2
              ? 130
              : 160,
          child: HorizontalDataTable(
            enableRTL: Get
                .find<LanguageController>()
                .isArabic ||
                Get
                    .find<LanguageController>()
                    .isUrdo ||
                Get
                    .find<LanguageController>()
                    .isHindi
                ? true
                : false,
            verticalScrollbarStyle: const ScrollbarStyle(
              thumbColor: Colors.black,
              thickness: 3.0,
            ),
            horizontalScrollbarStyle: const ScrollbarStyle(
              thumbColor: Colors.black,
              thickness: 3.0,
            ),
            leftHandSideColumnWidth: 170,
            rightHandSideColumnWidth: 10,
            isFixedHeader: true,
            isFixedFooter: false,
            headerWidgets: _getTitleWidget(),
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: selectedItems.length,

            leftHandSideColBackgroundColor: Colors.white,
            rightHandSideColBackgroundColor: Colors.white,
            itemExtent: 55,
          ),
        )
            :
        SizedBox(
          height: selectedItems.length == 1
              ? 80
              : selectedItems.length == 2
              ? 130
              : 160,

          child: HorizontalDataTable(
            enableRTL: Get
                .find<LanguageController>()
                .isArabic ||
                Get
                    .find<LanguageController>()
                    .isUrdo ||
                Get
                    .find<LanguageController>()
                    .isHindi
                ? true
                : false,
            verticalScrollbarStyle: const ScrollbarStyle(
              thumbColor: Colors.black,
              thickness: 3.0,
            ),
            horizontalScrollbarStyle: const ScrollbarStyle(
              thumbColor: Colors.black,
              thickness: 3.0,
            ),
            leftHandSideColumnWidth: 240,
                rightHandSideColumnWidth: 10,
                isFixedHeader: true,
                isFixedFooter: false,
                headerWidgets: _getTitleWidget(),
                leftSideItemBuilder: _generateFirstColumnRow,
                rightSideItemBuilder: _generateRightHandSideColumnRow,
                itemCount: selectedItems.length,
                leftHandSideColBackgroundColor: Colors.white,
                rightHandSideColBackgroundColor: Colors.white,
                itemExtent: 40,
              ),
        );
    });
  }
}

List<Widget> _getTitleWidget() {
  var homeController = Get.put(HomeController());
  return [

    _getTitleFirstColumnWidget(
        Get.find<LanguageController>().isArabic ||
                Get.find<LanguageController>().isUrdo ||
                Get.find<LanguageController>().isHindi
            ? intl.DateFormat('yyyy/MM/dd', 'ar').format(DateTime.parse(
                homeController.allCheckInLocation.value.data?[0].dateToday ??
                    ''))
            : intl.DateFormat('dd/MM/yyyy', 'en').format(DateTime.parse(
                homeController.allCheckInLocation.value.data?[0].dateToday ??
                    '')),
        240),
  ];
}

Widget _getTitleFirstColumnWidget(String label, double width) {
  var homeController = Get.put(HomeController());
  return Container(
    color: const Color.fromRGBO(58, 116, 170, 1),
    width: width,
    height: 40,
    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        homeController.allCheckInLocation.value.data?[0].dateToday == null
            ? const Text('')
            : Get
            .find<LanguageController>()
            .isArabic ||
            Get
                .find<LanguageController>()
                .isUrdo ||
            Get
                .find<LanguageController>()
                .isHindi
            ? Text(
            intl.DateFormat('EEEE', 'ar').format(DateTime.parse(
                homeController.allCheckInLocation.value.data?[0].dateToday ??
                            ''))
            ,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)
        )
            : Text(
            intl.DateFormat('EEEE', 'en').format(DateTime.parse(
                homeController
                                .allCheckInLocation.value.data?[0].dateToday ??
                            ''))
            ,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)
        ),
        SizedBox(
          width: 10,
        ),
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)
        ),
      ],
    ),
  );
}


Widget _generateFirstColumnRow(BuildContext context, int index) {
  return GetBuilder<HomeController>(builder: (controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3),
                      color: controller
                                  .allCheckInLocation
                                  .value
                                  .data?[0]
                                  .hREmployeesCheckInOutLocations?[index]
                                  .checkType ==
                              1
                          ? Colors.green
                          : Colors.red),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    Get.find<LanguageController>().isArabic ||
                            Get.find<LanguageController>().isUrdo ||
                            Get.find<LanguageController>().isHindi
                        ? intl.DateFormat('mm : hh  a', 'ar').format(
                            DateTime.parse(controller
                                    .allCheckInLocation
                                    .value
                                    .data?[0]
                                    .hREmployeesCheckInOutLocations?[index]
                                    .checkInOutTime ??
                                ''))
                        : intl.DateFormat('hh : mm  a').format(DateTime.parse(
                            controller
                                    .allCheckInLocation
                                    .value
                                    .data?[0]
                                    .hREmployeesCheckInOutLocations?[index]
                                    .checkInOutTime ??
                                '')),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                    onTap: () async {
                      await MapsLauncher.launchCoordinates(
                          double.parse(controller
                                  .allCheckInLocation
                                  .value
                                  .data?[0]
                                  .hREmployeesCheckInOutLocations?[index]
                                  .latitude ??
                              ''),
                          double.parse(controller
                                  .allCheckInLocation
                                  .value
                                  .data?[0]
                                  .hREmployeesCheckInOutLocations?[index]
                                  .longitude ??
                              ''));
                    },
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.blue,
                      size: 20,
                    )),
                SizedBox(
                  width: 3,
                ),
                Expanded(
                  child: Text(
                    '${controller.allCheckInLocation.value.data?[0].hREmployeesCheckInOutLocations?[index].locatioName}',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  });
}

Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
  return GetBuilder<HomeController>(builder: (controller) {
    return Container();
  });
}
