import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chameleon/app/modules/home/model/hr/emp_loan_statment/EmployeeLoanStatementList.dart';
import 'package:chameleon/app/modules/login/controllers/login_controller.dart';
import 'package:chameleon/generated/locales.g.dart';
import 'package:chameleon/global/controllers/language_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';

import '../../../../global/constants/constants.dart';
import '../../login/data_sources/login_local_data_source.dart';
import '../../login/models/FinancialYears.dart';
import '../../login/models/HrLeaveStatus.dart';
import '../../login/models/HrTransactionType.dart';
import '../../login/models/PaidTypes.dart';
import '../../login/models/file_data.dart';
import '../data_source/home_remote_data_source.dart';
import '../model/Details_album.dart';
import '../model/change_password/ChangePassword.dart';
import '../model/detailsDues/DetailsDues.dart';
import '../model/driver_available_way_bill/DriverAvailable.dart';
import '../model/hr/check_in_location/add_location/AddLocation.dart';
import '../model/hr/check_in_location/check_in/CheckIn.dart';
import '../model/hr/check_in_location/month_check/MonthCheck.dart';
import '../model/hr/emp_loan_statment/GetEmpLoanStatment.dart';
import '../model/hr/employee_permission_absence/GetEmployeePerAbsence.dart';
import '../model/hr/employee_statement/EmployeeStatementList.dart';
import '../model/hr/employee_statement/GetEmployeeStatement.dart';
import '../model/hr/get_em_loan_request/GetEmpLoanRequest.dart';
import '../model/hr/get_employee_delay_permission/GetEmployeeDelayPermission.dart';
import '../model/hr/get_employee_leaves/GetEmployeeLeaves.dart';
import '../model/hr/get_employee_leaves/HrEmployees.dart';
import '../model/hr/get_employee_leaves/HrLeaveTypes.dart';
import '../model/hr/get_employee_leaves_request/GetEmployeeLeavesRequest.dart';
import '../model/hr/get_employee_loan/GetEmployeeLoans.dart';
import '../model/hr/get_employee_loan/HrLoanTypes.dart';
import '../model/hr/get_vacation-balance/GetVactionBalance.dart';
import '../model/hr/vacation_balance/VacationBalance.dart';
import '../model/notification_navigate/NotificationModel.dart';
import '../model/refused_reason/Data.dart';
import '../model/refused_reason/RefusedReason.dart';
import '../model/totalluDues/Data.dart';
import '../model/totalluDues/DetailsDataList.dart';
import '../model/totalluDues/TotallyDues.dart';
import 'current_waybill_controller.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final myPosition = Position(
    latitude: 0,
    longitude: 0,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1,
    altitudeAccuracy: 1,
    headingAccuracy: 1,
  ).obs;

  final LoginLocalDataSource localDataSource = LoginLocalDataSource();

  final HomeRemoteDataSource remoteDataSource = HomeRemoteDataSource();
  final LanguageController lang = LanguageController();

  // final LoginController login = LoginController();

  IconData icon = Icons.emoji_transportation;

  void updateIcon(IconData iconData) {
    icon = iconData;
    update();
  }

  Timer? timer1;
  Timer? timerSenderLocation;
  Timer? timerReturnContainer;
  Timer? timerReceiverLocation;
  final image = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  final allDriverAvailableWayBill = DriverAvailable().obs;
  final availableWayBillFromAccident = DriverAvailable().obs;
  final hrLeavesType = HrLeaveTypes().obs;
  final hrLoansType = HrLoanTypes().obs;
  final hrLeavesStatus = HrLeaveStatus().obs;
  final hrLeavesPaid = PaidTypes().obs;
  final hrEmployees = HrEmployees().obs;
  final detailsAlbum = DetailsAlbum().obs;
  final detailsAcceident = DetailsAlbum().obs;

  final allChangePassword = ChangePassword().obs;
  final allRefusedReason = RefusedReason().obs;
  final dataRefusedReason = DataReasonRefused().obs;
  final dataFinancialYears = FinancialYears().obs;
  final dataFYLoanStatment = FinancialYears().obs;

  //final dataFinancialYearsLeaveRequt = FinancialYears().obs;
  final getWaybillDetails = DriverAvailable().obs;
  final allDetailsDues = DetailsDues().obs;

  List<DetailsDataList> selectedProducts = <DetailsDataList>[].obs;
  List<dynamic> hrTransactionType = <dynamic>[].obs;
  var selectedItemsTransactionTypes = <HrTransactionType>[].obs;
  var transactionTypes = <HrTransactionType>[].obs;
  List<DataTotally> selectedProductsTotallyDetails = <DataTotally>[].obs;
  final allTotallyDues = TotallyDues().obs;
  final allEmployeesLeaves = GetEmployeeLeaves().obs;
  final allCheckInLocation = CheckIn().obs;
  final selectedIndexOfLocation = (-1).obs;
  final allMonthCheck = MonthCheck().obs;
  final allEmployeesDelayPermission = GetEmployeeDelayPermission().obs;
  final allEmployeesAbsencePermission = GetEmployeePerAbsence().obs;
  final allEmployeesDeparturePermission = GetEmployeeDelayPermission().obs;
  final allEmployeesDeparturePermissionReq = GetEmployeeDelayPermission().obs;
  final allEmployeesAccountStatement = GetEmployeeStatement().obs;
  final allEmployeesLoanStatement = GetEmpLoanStatment().obs;
  final allEmployeesLoans = GetEmployeeLoans().obs;
  final allEmployeesLeavesReq = GetEmployeeLeavesRequest().obs;
  final allEmployeesDelayPermissionReq = GetEmployeeDelayPermission().obs;
  final allEmployeesLoansReq = GetEmpLoanRequest().obs;
  final allAddLocation = AddLocation().obs;
  final allGetVactionBalance = GetVactionBalance().obs;
  final allVactionBalance = VacationBalance().obs;
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  final lastNavigateData = NotificationModel().obs;
  final isPermissionGranted = false.obs;

  final getTransactionTypeIds = ''.obs;
  final systemName = ''.obs;
  final noData = false.obs;
  final isMinorChecked = false.obs;
  final isMajorChecked = false.obs;
  final isLoadingPdf = false.obs;
  final openPanelCamera = false.obs;
  final dataIsEmpty = false.obs;
  final dataIsthqaqatIsEmpty = false.obs;
  final dataEmployeesLeavesIsEmpty = false.obs;
  final dataTodayCheckIsEmpty = false.obs;
  final checkInNotAllowed = false.obs;
  final dataMonthCheckIsEmpty = false.obs;
  final dataEmployeesDelayPermissionIsEmpty = false.obs;
  final dataEmployeesAbsencePermissionIsEmpty = false.obs;
  final dataEmployeesDeparturePermissionIsEmpty = false.obs;
  final dataEmployeesDPIsEmpty = false.obs;
  final dataEmployeesAccountStateIsEmpty = false.obs;
  final dataEmployeesLoanStateIsEmpty = false.obs;
  final dataAdvancePaymentsIsEmpty = false.obs;
  final dataEmployeesLeavesReqIsEmpty = false.obs;
  final dataAdvanceReqIsEmpty = false.obs;
  final dataGetVactionBalance = false.obs;
  final dataVactionBalance = false.obs;
  final dataLogsEmpty = false.obs;
  final showWayBillDetails = false.obs;
  final detaily = false.obs;
  final idForDetails = 0.obs;
  final totally = false.obs;
  final showMore = false.obs;
  final showHorizontal = false.obs;
  final showVertical = true.obs;
  final showGrid = false.obs;
  final showNavi = false.obs;
  final currentNotific = false.obs;
  final load = false.obs;
  final solfa = false.obs;
  final addRequestForHoliday = false.obs;
  final addRequestForHoliday2 = false.obs;
  final addOrderDelayPermission = false.obs;
  final addOrderAPermission = false.obs;
  final addOrderEarlyPermission = false.obs;
  final editOrderEarlyPermission = false.obs;
  final editOrderDelayPermission = false.obs;
  final expandedLDelayPermission = false.obs;
  final expandedLEarlyPermission = false.obs;
  final expandedChenkInMonth = false.obs;
  final expandedDelayPermission = false.obs;
  final expandedEarlyPermission = false.obs;
  final expandedabsencePermission = false.obs;
  final expandedAccountStatment = false.obs;
  final expandedLoanStatment = false.obs;
  final expandedOrder = false.obs;
  final expandedCheckIn = false.obs;
  final expandedOrderEPermission = false.obs;
  final expandedHolidayRequest = false.obs;
  final expandedLoanRequest = false.obs;
  final expandedChangePassword = false.obs;
  final addRequestForSolfa = false.obs;
  final addRequestForSolfa2 = false.obs;
  final editRequestForHoliday = false.obs;
  final editRequestForHoliday2 = false.obs;
  final editRequestForSolfa = false.obs;
  final editRequestForSolfa2 = false.obs;
  final checkIn = false.obs;
  final logsForHoliday = false.obs;
  final holidayRequest = false.obs;
  final solfaRequest = false.obs;
  final allHolidays = false.obs;
  final logsForSolfa = false.obs;
  final accountsKahfForSolfa = false.obs;
  final accountsKahfForHoliday = false.obs;
  final notificLog = false.obs;
  final salesInvoice = false.obs;
  final salesCustomer = false.obs;
  final salesItemsGroup = false.obs;
  final salesItems = false.obs;
  final addCustomersSales = false.obs;
  final editCustomersSales = false.obs;
  final addInvoiceSales = false.obs;
  final editInvoiceSales = false.obs;
  final expandedInvoiceRequest = false.obs;
  final expandedCustomerRequest = false.obs;
  final codeCustomersSales = TextEditingController();
  final enNameCustomersSales = TextEditingController();
  final arNameCustomersSales = TextEditingController();
  final addressCustomersSales = TextEditingController();
  final emailCustomersSales = TextEditingController();
  final telCustomersSales = TextEditingController();
  final birthDayCustomersSales = TextEditingController();
  final taxCustomersSales = TextEditingController();
  final salesdiscountType = false.obs;
  final addItemsSales = false.obs;
  final editItemsSales = false.obs;
  final expandedItemsRequest = false.obs;
  final codeaItemsSales = TextEditingController();
  final enNameItemsSales = TextEditingController();
  final arNameItemsSales = TextEditingController();
  final unitItemsSales = TextEditingController();
  final priceItemsSales = TextEditingController();
  final barcodeItemsSales = TextEditingController();
  final addItemsGroupsSales = false.obs;
  final editItemsGroupsSales = false.obs;
  final expandedItemsGroupsRequest = false.obs;
  final codeaItemsGroupSales = TextEditingController();
  final enNameItemsGroupSales = TextEditingController();
  final arNameItemsGroupSales = TextEditingController();
  final addDiscountSales = false.obs;
  final editDiscountSales = false.obs;
  final expandedDiscountRequest = false.obs;
  final codeaDiscountSales = TextEditingController();
  final enNameDiscountSales = TextEditingController();
  final arNameDiscountSales = TextEditingController();
  final typesDiscountSales = TextEditingController();
  final valueDiscountSales = TextEditingController();
  final maxValueDiscountSales = TextEditingController();
  final accidentLog = false.obs;
  final holiday = false.obs;
  final activateIndex = (-1).obs;
  final activateIndexDetails = (-1).obs;
  final money = false.obs;
  final auzonat = false.obs;
  final depayPermission = false.obs;
  final departurePermission = false.obs;
  final absentPermission = false.obs;
  final transport = false.obs;
  final hr = false.obs;
  final settings = false.obs;
  final sales = false.obs;
  final acceptOrRefused = false.obs;
  final monthEst = ''.obs;

  DateTime currentTime = DateTime.now();

  selectOneLocationF(int index) {
    selectedIndexOfLocation.value = index;
  }

  void onChangeMinor(bool? value) {
    isMinorChecked.value = value ?? false;

    if (isMajorChecked.value) {
      isMajorChecked.value = false;
    }
    update();
  }

  void onChangeMajor(bool? value) {
    isMajorChecked.value = value ?? false;

    if (isMinorChecked.value) {
      isMinorChecked.value = false;
    }
    update();
  }

  //CurrentWaybillController? c  ;
  final noDataDriverAvailWayBill = false.obs;
  final noDataRefusedReason = false.obs;
  final noDataWayBillDetails = false.obs;
  final noDataGetDetailsDues = false.obs;
  final noDataGetTotallyDues = false.obs;
  final noDataGetEmployeesLeaves = false.obs;
  final noDataGetEmployeesDelayPermission = false.obs;
  final noDataGetEmployeesLoans = false.obs;
  final noDataGetEmployeesLeavesReq = false.obs;
  final noDataGetVactionBalance = false.obs;
  final noDataVactionBalance = false.obs;
  final showEmployeesLeaves = false.obs;
  final showEmployeesDelayPermission = false.obs;
  final showEmployeesAPermission = false.obs;
  final showEmployeesDeparturePermissions = false.obs;
  final showEmployeesDelayPermissionReq = false.obs;
  final showEmployeesDeparturePermissionReq = false.obs;
  final showAdvanceDetails = false.obs;
  final showLeaveRequests = false.obs;
  final showAdvanceRequests = false.obs;
  final indexHoliday = 0.obs;
  final indexLoan = 0.obs;

  final dateFromText = DateTime
      .now()
      .toString()
      .obs;
  final permissionFrom = DateTime
      .now()
      .toString()
      .obs;
  final employeeAccountStatFrom = DateTime(DateTime
      .now()
      .year)
      .toString()
      .obs;

  //final employeeAccountStatFrom = DateTime.now().toString().obs;
  final employeeAccountStatTo = DateTime(DateTime
      .now()
      .year,
      DateTime
          .now()
          .month, DateTime
          .now()
          .day, 23, 59, 59)
      .toString()
      .obs;
  final fromDateAbsence = DateTime
      .now()
      .toString()
      .obs;
  final toDateAbsence = DateTime
      .now()
      .toString()
      .obs;
  final orderDateFrom = DateTime
      .now()
      .toString()
      .obs;
  final orderDateDeparureFrom = DateTime
      .now()
      .toString()
      .obs;
  final orderDateV = DateTime
      .now()
      .toString()
      .obs;
  final orderDateDepartureV = DateTime
      .now()
      .toString()
      .obs;
  final orderDateTo = DateTime
      .now()
      .toString()
      .obs;
  final orderDateDeparureTo = DateTime
      .now()
      .toString()
      .obs;
  final startMonthsLoans = DateTime
      .now()
      .obs;
  final permissionTo = DateTime
      .now().toString().obs;
  final difference = 0.obs;
  final minitsNo = 0.obs;
  final minitsDeparureNo = 0.obs;
  DateTime? startDate;

  DateTime? endDate;

  final hrLoanTypes = TextEditingController();
  final addItemsInvoiceSales = false.obs;
  final customerNameInvoice = TextEditingController();
  final taxsInvoice = TextEditingController();
  final priceItemInvoice = TextEditingController();
  final quantityItemInvoice = TextEditingController();
  final netInvoice = TextEditingController();
  final invoiceDate = TextEditingController();
  final invoiceDateV = DateTime.now().toString().obs;
  final hrLeaveTypes = TextEditingController();
  final hrLeaveStatus = TextEditingController();
  final hrLeavePaid = TextEditingController();
  final hrEmployee = TextEditingController();
  final searchNotification = TextEditingController();
  final refusedReasonText = TextEditingController();
  final solfaValue = TextEditingController();
  final monthNo = TextEditingController();
  final reason = TextEditingController();
  final accedentNotes = TextEditingController();
  final dPermissionReason = TextEditingController();
  final dPermissionDeparureReason = TextEditingController();
  final reasonLoans = TextEditingController();
  final nofMonths = TextEditingController();
  final notesAddLocation = TextEditingController();
  final addressAddLocation = TextEditingController();
  final locationNameAddLocation = TextEditingController();
  final loanValue = TextEditingController();
  final dateFrom = TextEditingController();
  final dateFromHoliday = TextEditingController();
  final dateFromEmployeeAcountStat = TextEditingController(
      text: Get
          .find<LanguageController>()
          .isArabic ||
          Get
              .find<LanguageController>()
              .isUrdo ||
          Get
              .find<LanguageController>()
              .isHindi
          ? intl.DateFormat('dd-MM-yyyy')
          .format(DateTime.parse(DateTime(DateTime
          .now()
          .year).toString()))
          : intl.DateFormat('yyyy-MM-dd').format(
          DateTime.parse(DateTime(DateTime
              .now()
              .year).toString())));
  final dateToEmployeeAcountStat = TextEditingController(
      text: Get
          .find<LanguageController>()
          .isArabic ||
          Get
              .find<LanguageController>()
              .isUrdo ||
          Get
              .find<LanguageController>()
              .isHindi
          ? intl.DateFormat('dd-MM-yyyy')
          .format(DateTime.parse(DateTime.now().toString()))
          : intl.DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(DateTime.now().toString())));
  final dateFromOrder = TextEditingController();
  final dateFromDeparure = TextEditingController();
  final dateToOrder = TextEditingController();
  final dateToDeparure = TextEditingController();
  final orderDate = TextEditingController();
  final orderDateDeparure = TextEditingController();
  final dateToHoliday = TextEditingController();

  //GetStorage storageTest = GetStorage();
  final FocusNode usernameFocusNode1 = FocusNode();
  final FocusNode usernameFocusNode2 = FocusNode();
  final FocusNode usernameFocusNode3 = FocusNode();

  final isInternetConnected = false.obs;
  final signtureImage = Rx<Uint8List?>(null);
  final navigateImageAlbum = Rx<Uint8List?>(null);
  final navigateImageAcciedent = Rx<Uint8List?>(null);
  final navigateImageAlbum2 = Rx<Uint8List?>(null);
  final navigateImageAcciedent2 = Rx<Uint8List?>(null);

  List<String> imagesHr = [];

  static const platform = MethodChannel('developer_options/check');

  var isDeveloperOptionsEnabled = false.obs;

  Future<void> changeIndexOfServicesHr(int index, BuildContext context) async {
    log('length textHr = ${imagesHr.length}');
    if (imagesHr[index] == 'assets/images/attendance.png') {
      await loadGetTodayCheck(
        context,
        () {
          Get.find<LoginController>().loginPinCodeController.clear();
        },
        Get.find<LanguageController>().selectedLanguage?.id ?? 2,
      ).then((value) {
        checkDeveloperOptions();
        checkIn.value = true;
        expandedCheckIn.value = true;
        addRequestForSolfa.value = false;
        logsForSolfa.value = false;
        accountsKahfForSolfa.value = false;

        absentPermission.value = false;
        expandedabsencePermission.value = false;
        addOrderAPermission.value = false;
        addRequestForHoliday.value = false;
        logsForHoliday.value = false;
        accountsKahfForHoliday.value = false;
      });
    } else if (imagesHr[index] == 'assets/images/journey.png') {
      await loadGetEmployeesLeaves(
        context,
        () {
          Get.find<LoginController>().loginPinCodeController.clear();
        },
        Get.find<LanguageController>().selectedLanguage?.id ?? 2,
      ).then((value) {
        addRequestForSolfa.value = false;
        logsForSolfa.value = false;
        accountsKahfForSolfa.value = false;

        addRequestForHoliday.value = false;
        logsForHoliday.value = true;
        accountsKahfForHoliday.value = false;
      });
    } else if (imagesHr[index] == 'assets/images/loans.png') {
      await loadGetEmployeesLoans(
        context,
        () {
          Get.find<LoginController>().loginPinCodeController.clear();
        },
        Get.find<LanguageController>().selectedLanguage?.id ?? 2,
      ).then((value) {
        addRequestForSolfa.value = false;
        logsForSolfa.value = true;
        accountsKahfForSolfa.value = false;

        addRequestForHoliday.value = false;
        logsForHoliday.value = false;
        accountsKahfForHoliday.value = false;
      });
    } else if (imagesHr[index] == 'assets/images/delay.png') {
      addRequestForSolfa.value = false;
      logsForSolfa.value = false;
      accountsKahfForSolfa.value = false;
      depayPermission.value = true;
      expandedDelayPermission.value = false;
      expandedOrder.value = false;
      editOrderDelayPermission.value = false;
      addOrderDelayPermission.value = false;
      addRequestForHoliday.value = false;
      logsForHoliday.value = false;
      accountsKahfForHoliday.value = false;
    } else if (imagesHr[index] == 'assets/images/permission.png') {
      addRequestForSolfa.value = false;
      logsForSolfa.value = false;
      accountsKahfForSolfa.value = false;
      departurePermission.value = true;
      expandedEarlyPermission.value = false;
      expandedOrderEPermission.value = false;
      editOrderEarlyPermission.value = false;
      addOrderEarlyPermission.value = false;
      addRequestForHoliday.value = false;
      logsForHoliday.value = false;
      accountsKahfForHoliday.value = false;
    } else if (imagesHr[index] == 'assets/images/absent.png') {
      await loadGetEmployeesAbsencePermission(
        context,
        () {
          Get.find<LoginController>().loginPinCodeController.clear();
        },
        Get.find<LanguageController>().selectedLanguage?.id ?? 2,
      ).whenComplete(() {
        addRequestForSolfa.value = false;
        logsForSolfa.value = false;
        accountsKahfForSolfa.value = false;

        absentPermission.value = true;
        expandedabsencePermission.value = false;
        addOrderAPermission.value = false;
        addRequestForHoliday.value = false;
        logsForHoliday.value = false;
        accountsKahfForHoliday.value = false;
      });
    } else if (imagesHr[index] == 'assets/images/account_stattement.png') {
      addRequestForSolfa.value = false;
      logsForSolfa.value = false;
      accountsKahfForSolfa.value = true;

      addRequestForHoliday.value = false;
      logsForHoliday.value = false;
      accountsKahfForHoliday.value = false;
    }
  }

  // Method to check if developer options are enabled
  Future<void> checkDeveloperOptions() async {
    try {
      isDeveloperOptionsEnabled.value =
          await platform.invokeMethod('checkDeveloperOptions');
      if (isDeveloperOptionsEnabled.value == true) {
        log('isDeveloperOptionsEnabled = true');

        Get.rawSnackbar(
            titleText: SizedBox(
              width: double.infinity,
              height: Get.size.height * (.900),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                          if (Get.isRegistered<CurrentWaybillController>()) {
                            timer1?.cancel();
                            Get.delete<CurrentWaybillController>();
                          }
                          checkIn.value = false;
                          currentNotific.value = false;
                          notificLog.value = false;
                          accidentLog.value = false;
                          money.value = false;
                          showWayBillDetails.value = false;
                          expandedCheckIn.value = false;
                          addRequestForSolfa.value = false;
                          logsForSolfa.value = false;
                          accountsKahfForSolfa.value = false;

                          absentPermission.value = false;
                          expandedabsencePermission.value = false;
                          addOrderAPermission.value = false;
                          addRequestForHoliday.value = false;
                          logsForHoliday.value = false;
                          accountsKahfForHoliday.value = false;
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                          size: 35,
                        ),
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/ShortIcon.png',
                        height: 170,
                        width: 220,
                      ),
                    ),
                    const Text(
                      'Chameleon',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Security Issue',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.red,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.security_outlined,
                            size: 50,
                            color: Colors.blue),


                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      'يتعذر استخدام التطبيق علي هاتف يسمح بوضع المطور',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    const Text('Developer Option ON',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                  ],
                ),
              ),
            ),
            messageText: Container(),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            isDismissible: false,
            duration: const Duration(days: 1)
        );
      }
      else {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
        log('isDeveloperOptionsEnabled = false');
      }
    } on PlatformException catch (e) {
      log("Failed to get developer options: '${e.message}'");
    }
  }


  void updateSelectedMonthDate(DateTime date) {
    startMonthsLoans.value = date;
    update();
  }

  String getDisplayText() {
    if (selectedItemsTransactionTypes.isEmpty) {
      return LocaleKeys.noSelection.tr;
    } else if (selectedItemsTransactionTypes.length == 1) {
      return Get
          .find<LanguageController>()
          .isArabic
          ? selectedItemsTransactionTypes.first.nameA ?? ''
          : Get
          .find<LanguageController>()
          .isEn ? selectedItemsTransactionTypes.first.nameE ?? ''
          : Get
          .find<LanguageController>()
          .isHindi ? selectedItemsTransactionTypes.first.nameH ?? ''
          : Get
          .find<LanguageController>()
          .isFr
          ? selectedItemsTransactionTypes.first.nameF ?? ''
          : selectedItemsTransactionTypes.first.nameU ?? '';
    }
    else {
      return LocaleKeys.multipleOptions.tr;
    }
  }

  void toggleSelectionTransactionTypes(HrTransactionType item) {
    if (item.id == -2) {
      if (selectedItemsTransactionTypes.contains(item)) {
        selectedItemsTransactionTypes.remove(item);
      }
      else {
        selectedItemsTransactionTypes.clear();
        selectedItemsTransactionTypes.add(item);
      }
    }

    else {
      if (selectedItemsTransactionTypes.contains(item)) {
        selectedItemsTransactionTypes.remove(item);
      }

      else {
        if (!selectedItemsTransactionTypes.any((element) => element.id == -2)) {
          selectedItemsTransactionTypes.add(item);
        }
      }
    }

    update();
  }

  void onSaveItemGroupList2() {
    if (selectedItemsTransactionTypes.isEmpty) {
      loadGetEmployeesAccountStatementWithoutContext(() {
        Get
            .find<LoginController>()
            .loginPinCodeController
            .clear();
      }, Get
          .find<LanguageController>()
          .selectedLanguage
          ?.id ?? 2, '-2');
    }
    else {
      getTransactionTypeIds.value =
          selectedItemsTransactionTypes.map((e) => e.id.toString()).join(',');
      log('getTransactionTypeIds = ${getTransactionTypeIds.value}');

      loadGetEmployeesAccountStatementWithoutContext(() {
        Get
            .find<LoginController>()
            .loginPinCodeController
            .clear();
      }, Get
          .find<LanguageController>()
          .selectedLanguage
          ?.id ?? 2,
          getTransactionTypeIds.value);
    }
    update();
  }

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.white,
  );

  Future<void> writeActivateIndexWeb(int contents) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('activateIndex', contents);
  }

  Future<void> writeTypeOfOperationWeb(TypeOfOperation contents) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String jsonContent = jsonEncode(contents.toJson());
    await pref.setString('typeOfOperation', jsonContent);
  }

  Future<int?> readActivateIndexWeb() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getInt('activateIndex');
    } catch (e) {
      return 0;
    }
  }

  Future<TypeOfOperation> readTypeOfOperationWeb() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      String? fileData = pref.getString('typeOfOperation') ?? '';

      Map<String, dynamic> jsonData = jsonDecode(fileData);
      TypeOfOperation data = TypeOfOperation.fromJson(jsonData);

      return data;
    } catch (e) {
      return TypeOfOperation();
    }
  }

  void onPressSystem() {
    if (Get.isRegistered<CurrentWaybillController>()) {
      timer1?.cancel();
      Get.delete<CurrentWaybillController>();
    }
    auzonat.value = false;
    checkIn.value = false;
    depayPermission.value = false;
    departurePermission.value = false;
    absentPermission.value = false;
    editRequestForHoliday2.value = false;
    editRequestForSolfa2.value = false;
    addRequestForSolfa2.value = false;
    addRequestForHoliday2.value = false;

    expandedHolidayRequest.value = false;
    expandedChenkInMonth.value = false;
    expandedCheckIn.value = false;
    expandedDelayPermission.value = false;
    expandedabsencePermission.value = false;
    expandedLoanStatment.value = false;
    expandedAccountStatment.value = false;
    expandedLDelayPermission.value = false;
    expandedOrder.value = false;

    expandedEarlyPermission.value = false;
    expandedLEarlyPermission.value = false;
    expandedOrderEPermission.value = false;
    expandedLoanRequest.value = false;
    editRequestForSolfa.value = false;
    editRequestForHoliday.value = false;
    addRequestForHoliday.value = false;
    addRequestForSolfa.value = false;
    showEmployeesLeaves.value = false;
    showEmployeesDelayPermissionReq.value = false;
    showEmployeesDelayPermission.value = false;
    addRequestForSolfa.value = false;
    solfaRequest.value = false;
    logsForSolfa.value = false;
    showAdvanceRequests.value = false;
    showAdvanceDetails.value = false;
    showLeaveRequests.value = false;
    holidayRequest.value = false;
    allHolidays.value = false;
  }

  Future<void> fetchSigntureImage(int id, String fileName) async {
    try {
      final response = await http.get(
          Uri.parse('$defaultHost$getSigntureWayBillUrl?Id=$id'),
          headers: {
            'Authorization': 'Bearer ' + Get.find<LoginController>().user.token!
          });
      if (response.statusCode == 200) {
        signtureImage.value = response.bodyBytes;
        log('statusCode = ${response.statusCode}');
      } else {
        log('faild to load signtureImage');
        signtureImage.value = null;
      }
    } catch (e) {
      log('error = ${e.toString()}');
      signtureImage.value = null;
    }
  }


  Future<void> loadLastNavigateAlbum(int id, String fileName) async {
    try {
      var body = jsonEncode({"id": id, "langId": 0});
      final response =
          await http.post(Uri.parse('$defaultHost$getLastWaybillFileUrl'),
              headers: {
                'Authorization':
                    'Bearer ' + Get.find<LoginController>().user.token!,
                "Accept": "application/json",
                "content-type": "application/json"
              },
              body: body);

      if (response.statusCode == 200) {
        navigateImageAlbum.value = response.bodyBytes;
        final file = await createFileIfNotExist(fileName);

        await file.writeAsBytes(response.bodyBytes);

        log('statusCode = ${response.statusCode}');
      } else {
        log('faild to load loadLastNavigateAlbum');
        navigateImageAlbum.value = null;
      }
    } catch (e) {
      log('error first album= ${e.toString()}');
      navigateImageAlbum.value = null;
    }
  }

  Future<void> loadLastNavigateAcceident(int id, String fileName) async {
    try {
      var body = jsonEncode({"id": id, "langId": 0});
      final response =
      await http.post(Uri.parse('$defaultHost$getLastAccedentFileUrl'),
          headers: {
            'Authorization':
            'Bearer ' + Get
                .find<LoginController>()
                .user
                .token!,
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: body);

      if (response.statusCode == 200) {
        navigateImageAcciedent.value = response.bodyBytes;
        final file = await createFileAccidentIfNotExist(fileName);

        await file.writeAsBytes(response.bodyBytes);

        log('statusCode = ${response.statusCode}');
      } else {
        log('faild to load loadLastNavigateAcciedent');
        navigateImageAlbum.value = null;
      }
    } catch (e) {
      log('error loadLastNavigateAcceident = ${e.toString()}');
      navigateImageAcciedent.value = null;
    }
  }

  Future<File> createFileIfNotExist(String fileName) async {
    final direcotry = await getApplicationDocumentsDirectory();

    final filePath = path.join(direcotry.path, fileName);
    final file = File(filePath);

    if (!(await file.parent.exists())) {
      log('create file successfull...........');
      await file.parent.create(recursive: true);
    }
    return file;
  }

  Future<File> createFileAccidentIfNotExist(String fileName) async {
    final direcotry = await getApplicationDocumentsDirectory();

    final filePath = path.join(direcotry.path, fileName);
    final file = File(filePath);

    if (!(await file.parent.exists())) {
      log('create file successfull...........');
      await file.parent.create(recursive: true);
    }
    return file;
  }

  Future<Uint8List?> loadNavigateAlbumLocally(String fileName) async {
    final file = await createFileIfNotExist(fileName);

    if (await file.exists()) {
      log('file is exist.......');

      return await file.readAsBytes();
    } else {
      log('file is not exist.......');
      return null;
    }
  }

  Future<Uint8List?> loadNavigateAcciedentLocally(String fileName) async {
    final file = await createFileAccidentIfNotExist(fileName);

    if (await file.exists()) {
      log('file acceident is exist.......');

      return await file.readAsBytes();
    } else {
      log('file acceident is not exist.......');
      return null;
    }
  }

  Future<void> shareImage(Uint8List image, String fileName) async {
    try {
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/$fileName';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(image);

      await Share.shareFiles([imagePath]);
    } catch (e) {
      log('error sharing image = ${e.toString()}');
    }
  }

  Future<DetailsAlbum?> loadLastNavigateDataAlbum(int id) async {
    final dataAlbum = await remoteDataSource.lastNavigateDataAlbum(id);

    log('loadLastNavigateDataAlbum execute...');
    if (dataAlbum == null) {} else {
      final data = dataAlbum;
      detailsAlbum.value = data;
      log('detais album dId = ${detailsAlbum.value.dId}');
      update();

      return data;
    }
  }

  Future<DetailsAlbum?> loadLastNavigateDataAccident(int id) async {
    log('id LastNavigateDataAccident = $id');
    final dataAlbum = await remoteDataSource.lastNavigateDataAccident(id);

    log('loadLastNavigateDataAccident execute...');
    if (dataAlbum == null) {
      return null;
    } else {
      final data = dataAlbum;
      detailsAcceident.value = data;
      log('details acceident dId = ${detailsAcceident.value.dId}');
      update();

      return data;
    }
  }

  Future<void> loadFirstNavigateAlbum(int id, String fileName) async {
    try {
      var body = jsonEncode({"id": id, "langId": 0});
      final response =
      await http.post(Uri.parse('$defaultHost$getFirstWaybillFileUrl'),
          headers: {
            'Authorization':
            'Bearer ' + Get
                .find<LoginController>()
                .user
                .token!,
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: body);
      if (response.statusCode == 200) {
        navigateImageAlbum.value = response.bodyBytes;
        final file = await createFileIfNotExist(fileName);

        await file.writeAsBytes(response.bodyBytes);
        log('statusCode = ${response.statusCode}');
      } else {
        log('faild to load loadFirstNavigateAlbum');
        navigateImageAlbum.value = null;
      }
    } catch (e) {
      log('error first album= ${e.toString()}');
      navigateImageAlbum.value = null;
    }
  }

  Future<void> loadFirstNavigateAccident(int id, String fileName) async {
    try {
      var body = jsonEncode({"id": id, "langId": 0});
      final response = await http.post(
          Uri.parse('$defaultHost$getFirstWaybillAccedentFileUrl'),
          headers: {
            'Authorization':
            'Bearer ' + Get
                .find<LoginController>()
                .user
                .token!,
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: body);
      if (response.statusCode == 200) {
        navigateImageAcciedent.value = response.bodyBytes;
        final file = await createFileAccidentIfNotExist(fileName);

        await file.writeAsBytes(response.bodyBytes);
        log('statusCode = ${response.statusCode}');
      } else {
        log('faild to load loadFirstNavigateAccident');
        navigateImageAcciedent.value = null;
      }
    } catch (e) {
      log('error first accident = ${e.toString()}');
      navigateImageAcciedent.value = null;
    }
  }

  Future<void> getFirstImagesByBytes(int id, String fileName) async {
    Uint8List? localImageBytes = await loadNavigateAlbumLocally(fileName);

    if (localImageBytes != null) {
      navigateImageAlbum.value = localImageBytes;
    } else {
      await loadFirstNavigateAlbum(id, fileName);
    }
  }

  Future<void> getFirstImagesAccidentByBytes(int id, String fileName) async {
    Uint8List? localImageBytes = await loadNavigateAcciedentLocally(fileName);

    if (localImageBytes != null) {
      navigateImageAcciedent.value = localImageBytes;
    } else {
      await loadFirstNavigateAccident(id, fileName);
    }
  }

  Future<String> localPath() async {
    final direcotry = await getApplicationDocumentsDirectory();

    return direcotry.path;
  }

  Future<File> localFile(String fileName) async {
    final lPath = await localPath();
    return File(path.join(lPath, fileName));
  }

  Future<bool> existLocally(String fileName) async {
    final file = await localFile(fileName);
    return file.existsSync();
  }

  Future<void> getSignatureByBytes(int id, String fileName) async {
    if (await existLocally(fileName)) {
      log('exist image , fetch locally..............');
      final file = await localFile(fileName);
      signtureImage.value = await file.readAsBytes();
      log('local signature = ${signtureImage.value}');
    } else {
      await fetchSigntureImage(id, fileName);
      log('signature fetch api ........');
    }
  }

  Future<void> getLastImagesByBytes(int id, String fileName) async {
    Uint8List? localImageBytes = await loadNavigateAlbumLocally(fileName);

    if (localImageBytes != null) {
      navigateImageAlbum.value = localImageBytes;
    } else {
      await loadLastNavigateAlbum(id, fileName);
    }
  }

  Future<void> getLastAcceidentByBytes(int id, String fileName) async {
    Uint8List? localImageBytes = await loadNavigateAcciedentLocally(fileName);

    if (localImageBytes != null) {
      log('localImageBytes != null ..........');
      navigateImageAcciedent.value = localImageBytes;
    } else {
      log('localImageBytes = null ..........');
      await loadLastNavigateAcceident(id, fileName);
    }
  }

  Future<void> getNextImagesByBytes(int id, int did, String fileName) async {
    Uint8List? localImageBytes = await loadNavigateAlbumLocally(fileName);

    if (localImageBytes != null) {
      navigateImageAlbum.value = localImageBytes;
    } else {
      await loadNextNavigateAlbum(id, did, fileName);
    }
  }

  Future<void> getNextAcciedentByBytes(int id, int did, String fileName) async {
    Uint8List? localImageBytes = await loadNavigateAcciedentLocally(fileName);

    if (localImageBytes != null) {
      navigateImageAcciedent.value = localImageBytes;
    } else {
      await loadNextNavigateAcciedent(id, did, fileName);
    }
  }

  Future<void> getPrevImagesByBytes(int id, int did, String fileName) async {
    Uint8List? localImageBytes = await loadNavigateAlbumLocally(fileName);

    if (localImageBytes != null) {
      navigateImageAlbum.value = localImageBytes;
    } else {
      await loadPrevNavigateAlbum(id, did, fileName);
    }
  }

  Future<void> getPrevAcceidentByBytes(int id, int did, String fileName) async {
    Uint8List? localImageBytes = await loadNavigateAcciedentLocally(fileName);

    if (localImageBytes != null) {
      navigateImageAcciedent.value = localImageBytes;
    } else {
      await loadPrevNavigateAcceident(id, did, fileName);
    }
  }

  Future<DetailsAlbum?> loadFirstNavigateDataAlbum(int id) async {
    final dataAlbum = await remoteDataSource.firstNavigateDataAlbum(id);

    log('loadFirstNavigateDataAlbum execute...');
    if (dataAlbum == null) {} else {
      final data = dataAlbum;
      detailsAlbum.value = data;
      log('detais album dId = ${detailsAlbum.value.dId}');
      update();

      return data;
    }
  }

  Future<DetailsAlbum?> loadFirstNavigateDataAccident(int id) async {
    final dataAlbum = await remoteDataSource.firstNavigateDataAccident(id);

    log('loadFirstNavigateDataAccident execute...');
    if (dataAlbum == null) {} else {
      final data = dataAlbum;
      detailsAcceident.value = data;
      log('details acceident dId = ${detailsAcceident.value.dId}');
      update();

      return data;
    }
  }

  Future<DetailsAlbum?> loadNextNavigateDataAlbum(int id,
      int dId,) async {
    final dataAlbum = await remoteDataSource.nextNavigateDataAlbum(id, dId);

    log('loadNextNavigateDataAlbum execute...');
    if (dataAlbum == null) {} else {
      final data = dataAlbum;
      detailsAlbum.value = data;
      log('detais album dId = ${detailsAlbum.value.dId}');
      update();

      return data;
    }
  }

  Future<DetailsAlbum?> loadNextNavigateDataAcciedent(int id,
      int dId,) async {
    final dataAlbum = await remoteDataSource.nextNavigateDataAcceident(id, dId);

    log('loadNextNavigateDataAcciedent execute...');
    if (dataAlbum == null) {} else {
      final data = dataAlbum;
      detailsAcceident.value = data;
      log('details Acceident dId = ${detailsAcceident.value.dId}');
      update();

      return data;
    }
  }

  Future<DetailsAlbum?> loadPrevNavigateDataAlbum(int id, int dId) async {
    final dataAlbum = await remoteDataSource.prevNavigateDataAlbum(id, dId);

    log('loadPrevNavigateDataAlbum execute...');
    if (dataAlbum == null) {} else {
      final data = dataAlbum;
      detailsAlbum.value = data;
      log('detais album dId = ${detailsAlbum.value.dId}');
      update();

      return data;
    }
  }

  Future<DetailsAlbum?> loadPrevNavigateDataAcceident(int id, int dId) async {
    final dataAlbum = await remoteDataSource.prevNavigateDataAcceident(id, dId);

    log('loadPrevNavigateDataAcceident execute...');
    if (dataAlbum == null) {} else {
      final data = dataAlbum;
      detailsAcceident.value = data;
      log('detais acceident dId = ${detailsAcceident.value.dId}');
      update();

      return data;
    }
  }

  Future<void> loadNextNavigateAlbum(int id, int dId, String fileName) async {
    try {
      var body = jsonEncode({"id": id, "dId": dId, "langId": 0});
      final response =
      await http.post(Uri.parse('$defaultHost$getNextWaybillFileUrl'),
          headers: {
            'Authorization':
            'Bearer ' + Get
                .find<LoginController>()
                .user
                .token!,
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: body);
      if (response.statusCode == 200) {
        navigateImageAlbum.value = response.bodyBytes;
        final file = await createFileIfNotExist(fileName);

        await file.writeAsBytes(response.bodyBytes);
        log('statusCode = ${response.statusCode}');
      } else {
        log('faild to load loadNextNavigateAlbum');
      }
    } catch (e) {
      log('error next album= ${e.toString()}');
    }
  }

  Future<void> loadNextNavigateAcciedent(int id, int dId,
      String fileName) async {
    try {
      var body = jsonEncode({"id": id, "dId": dId, "langId": 0});
      final response = await http.post(
          Uri.parse('$defaultHost$getNextWaybillAccedentFileUrl'),
          headers: {
            'Authorization':
            'Bearer ' + Get
                .find<LoginController>()
                .user
                .token!,
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: body);
      if (response.statusCode == 200) {
        navigateImageAcciedent.value = response.bodyBytes;
        final file = await createFileAccidentIfNotExist(fileName);

        await file.writeAsBytes(response.bodyBytes);
        log('statusCode = ${response.statusCode}');
      } else {
        log('faild to load loadNextNavigateAcciedent');
      }
    } catch (e) {
      log('error loadNextNavigateAcciedent = ${e.toString()}');
    }
  }

  Future<void> loadPrevNavigateAlbum(int id, int dId, String fileName) async {
    try {
      var body = jsonEncode({"id": id, "dId": dId, "langId": 0});
      final response =
      await http.post(Uri.parse('$defaultHost$getPrevWaybillFileUrl'),
          headers: {
            'Authorization':
            'Bearer ' + Get
                .find<LoginController>()
                .user
                .token!,
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: body);
      if (response.statusCode == 200) {
        navigateImageAlbum.value = response.bodyBytes;
        final file = await createFileIfNotExist(fileName);

        await file.writeAsBytes(response.bodyBytes);
        log('statusCode = ${response.statusCode}');
      } else {
        log('faild to load loadPrevNavigateAlbum');
      }
    } catch (e) {
      log('error prev album= ${e.toString()}');
    }
  }

  Future<void> loadPrevNavigateAcceident(int id, int dId,
      String fileName) async {
    try {
      var body = jsonEncode({"id": id, "dId": dId, "langId": 0});
      final response = await http.post(
          Uri.parse('$defaultHost$getPrevWaybillAccedentFileUrl'),
          headers: {
            'Authorization':
            'Bearer ' + Get
                .find<LoginController>()
                .user
                .token!,
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: body);
      if (response.statusCode == 200) {
        navigateImageAcciedent.value = response.bodyBytes;
        final file = await createFileAccidentIfNotExist(fileName);

        await file.writeAsBytes(response.bodyBytes);
        log('statusCode = ${response.statusCode}');
      } else {
        log('faild to load loadPrevNavigateAcceident');
      }
    } catch (e) {
      log('error loadPrevNavigateAcceident = ${e.toString()}');
    }
  }

  Future<void> saveSignture(int id, String fileN) async {
    if (signatureController.isNotEmpty) {
      var signture = await signatureController.toPngBytes();

      if (signture != null) {
        log('*******************************');
        log('***************ff****************');
        await sendSigntureToApi(signture, id, fileN);
      }
    }
  }

  Future<void> sendSigntureToApi(
      Uint8List signture, int id, String fileN) async {
    final uri = Uri.parse(saveSigntureWayBillUrl);
    String fileName = 'signature';
    String fileByte = base64Encode(signture);

    var body = jsonEncode({
      "id": id,
      "fileName": fileName,
      "fileExtension": 1,
      "fileByte": fileByte,
      "description": ""
    });

    final response = await http.post(uri,
        headers: {
          'Authorization': 'Bearer ' + Get.find<LoginController>().user.token!,
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: body);

    if (response.statusCode == 200) {
      signtureImage.value = response.bodyBytes;

      log('signature not empty............');
      log('signature api = ${signtureImage.value}');
      update();

      // final res = await http.get(
      //     Uri.parse('$defaultHost$getSigntureWayBillUrl?Id=$id'),
      //     headers: {
      //       'Authorization': 'Bearer ' + Get.find<LoginController>().user.token!
      //     });
      // if (res.statusCode == 200) {
      //   final file = await localFile(fileN);
      //   await file.writeAsBytes(res.bodyBytes);
      // } else {
      //   log('faild to load signtureImage');
      //   signtureImage.value = null;
      // }
    } else {
      log('faild to save signature');
    }
  }

  Future<void> saveWaybillFile(Uint8List signture, int id) async {
    final uri = Uri.parse(saveWayBillFileUrl);
    String fileName = 'pickedFile';
    String fileByte = base64Encode(signture);

    var body = jsonEncode({
      "langId": 0,
      "id": id,
      "fileName": fileName,
      "fileExtension": 0,
      "fileByte": fileByte,
      "description": ""
    });

    log('file byte b=${fileByte}');
    try {
      final response = await http.post(uri,
          headers: {
            'Authorization':
                'Bearer ' + Get.find<LoginController>().user.token!,
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: body);

      log('statusCode saveWaybillFile = ${response.statusCode}');
      if (response.statusCode == 200) {
        log('save successfully........');
      } else {
        log('faild to save file');
      }
    } catch (e) {
      log('catch error when save waybill file');
    } finally {
      image.value = null;
    }
  }

  Future<void> saveWaybillAcceidentFile(Uint8List signture, int id) async {
    final uri = Uri.parse(saveWaybillAccedentFileUrl);
    String fileName = 'pickedAccidentFile';
    String fileByte = base64Encode(signture);

    var body = jsonEncode({
      "langId": 0,
      "id": id,
      "fileName": fileName,
      "fileExtension": 0,
      "fileByte": fileByte,
      "description": ""
    });

    log('file byte accident =${fileByte}');
    try {
      final response = await http.post(uri,
          headers: {
            'Authorization':
            'Bearer ' + Get
                .find<LoginController>()
                .user
                .token!,
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: body);

      log('statusCode saveWaybillAccidentFile = ${response.statusCode}');
      if (response.statusCode == 200) {
        log('save successfully........');
      } else {
        log('faild to save file');
      }
    } catch (e) {
      log('catch error when save waybill file');
    } finally {
      image.value = null;
    }
  }

  Future<DriverAvailable?> saveAccedentStatus(BuildContext context,
      VoidCallback voidCallback, int langId, int id) async {
    final parms = {
      "langId": langId,
      "id": id,
      "accedentNotes": accedentNotes.text,
      "isMajorAccedent": isMajorChecked.value
    };

    final addLeaveRequest =
    await remoteDataSource.addAccidentStatus(parms, context, voidCallback);

    if (addLeaveRequest == null) {
      log('addAccidentStatus null aaaaaaaaaaaaaa');
      return null;
    } else {
      availableWayBillFromAccident.value = addLeaveRequest;
      update();
      return addLeaveRequest;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    log('cccccccccccccccccccc');
    XFile? compresedFile;

    final pickedFile = await picker.pickImage(source: source);
    log('picked file name = ${pickedFile?.name}');
    log('picked file = $pickedFile');
    log('picked file path = ${pickedFile?.path}');
    try {
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
        pickedFile.path
            .split('.')
            .last
            .toLowerCase();

        int filesizeinbytes = await image.value?.length() ?? 12;
        double filesizeKB = filesizeinbytes / 1024;
        double filesizeMB = filesizeKB / 1024;

        log('filesizeMB  =$filesizeMB MB');

        int maxSizeInByte = 1024 * 1024;
        int quality = 90;
        int minWidth = 1200;
          int minHeight = 1200;

          compresedFile = await FlutterImageCompress.compressAndGetFile(
              image.value!.absolute.path, '${image.value!.path}_compresse.jpg',
              minHeight: minHeight,
              minWidth: minWidth,
              quality: quality,
              format: CompressFormat.jpeg);

          while (compresedFile != null &&
              await compresedFile.length() > maxSizeInByte) {
            quality -= 10;
            compresedFile = await FlutterImageCompress.compressAndGetFile(
                image.value!.absolute.path,
                '${image.value!.path}_compresse.jpg',
                minHeight: minHeight,
                minWidth: minWidth,
                quality: quality,
                format: CompressFormat.jpeg);
          }

        if (compresedFile != null) {
          log('final image size : ${await compresedFile.length() /
              (1024 * 1024)} MB');
        } else {
          log('faild to compress image under 1 MB');
        }
        navigateImageAlbum.value = await compresedFile?.readAsBytes();

        update();
      } else {
        log('pickedFile  = null.........');
      }
    } catch (e) {
      log('catch error  = ${e.toString()}');
    }

    update();
  }

  Future<void> pickImageAcceident(ImageSource source) async {
    log('cccccccccccccccccccc');
    XFile? compresedFile;

    final pickedFile = await picker.pickImage(source: source);
    log('picked file name = ${pickedFile?.name}');
    log('picked file = $pickedFile');
    log('picked file path = ${pickedFile?.path}');
    try {
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
        pickedFile.path
            .split('.')
            .last
            .toLowerCase();

        int filesizeinbytes = await image.value?.length() ?? 12;
        double filesizeKB = filesizeinbytes / 1024;
        double filesizeMB = filesizeKB / 1024;

        log('filesizeMB  =$filesizeMB MB');

        int maxSizeInByte = 1024 * 1024;
        int quality = 90;
        int minWidth = 1200;
        int minHeight = 1200;

        compresedFile = await FlutterImageCompress.compressAndGetFile(
            image.value!.absolute.path, '${image.value!.path}_compresse.jpg',
            minHeight: minHeight,
            minWidth: minWidth,
            quality: quality,
            format: CompressFormat.jpeg);

        while (compresedFile != null &&
            await compresedFile.length() > maxSizeInByte) {
          quality -= 10;
          compresedFile = await FlutterImageCompress.compressAndGetFile(
              image.value!.absolute.path, '${image.value!.path}_compresse.jpg',
              minHeight: minHeight,
              minWidth: minWidth,
              quality: quality,
              format: CompressFormat.jpeg);
        }

        if (compresedFile != null) {
          log('final image size : ${await compresedFile.length() /
              (1024 * 1024)} MB');
        } else {
          log('faild to compress image under 1 MB');
        }
        navigateImageAcciedent.value = await compresedFile?.readAsBytes();

        update();
      } else {
        log('pickedFile  = null.........');
      }
    } catch (e) {
      log('catch error  = ${e.toString()}');
    }

    update();
  }

  void setSelectedHrLeaveTypes(HrLeaveTypes hrLeaves) {
    hrLeaveTypes.text = Get.find<LanguageController>().isArabic
        ? hrLeaves.nameA ?? ''
        : hrLeaves.nameE ?? '';
    hrLeavesType.value = hrLeaves;
  }

  void setSelectedHrLoanTypes(HrLoanTypes hrLoans) {
    hrLoanTypes.text = Get.find<LanguageController>().isArabic
        ? hrLoans.nameA ?? ''
        : hrLoans.nameE ?? '';
    hrLoansType.value = hrLoans;
  }

  void setSelectedHrLeavesStatus(HrLeaveStatus hrLeaves) {
    hrLeaveStatus.text = Get.find<LanguageController>().isArabic
        ? hrLeaves.nameA ?? ''
        : hrLeaves.nameE ?? '';
    hrLeavesStatus.value = hrLeaves;
  }

  void setSelectedHrLeavesPaid(PaidTypes hrLeaves) {
    hrLeavePaid.text = Get.find<LanguageController>().isArabic
        ? hrLeaves.nameA ?? ''
        : hrLeaves.nameE ?? '';
    hrLeavesPaid.value = hrLeaves;
  }

  void setSelectedHrEmployees(HrEmployees hrLeaves) {
    hrEmployee.text = Get.find<LanguageController>().isArabic
        ? hrLeaves.nameA ?? ''
        : hrLeaves.nameE ?? '';
    hrEmployees.value = hrLeaves;
  }

  void clearItems() {
    hrEmployee.clear();
    allVactionBalance.value.data = '';
    hrLeavePaid.clear();
    hrLeaveStatus.clear();
    dateFrom.clear();
    dateFromHoliday.clear();
    dateToHoliday.clear();
    hrLeaveTypes.clear();
    reason.clear();
    monthNo.clear();
    difference.value = 0;
    startDate = null;
    endDate = null;
  }

  void clearItemsLoans() {
    loanValue.clear();
    startMonthsLoans.value = DateTime.now();
    nofMonths.clear();
    hrLoanTypes.clear();
    reasonLoans.clear();
    monthEst.value = '';
  }

  void clearItemsAddCustomers() {
    codeCustomersSales.clear();
    //startMonthsLoans.value = DateTime.now();
    enNameCustomersSales.clear();
    arNameCustomersSales.clear();
    addressCustomersSales.clear();
    taxCustomersSales.clear();
    emailCustomersSales.clear();
    telCustomersSales.clear();
  }

  void clearItemsAddInvoice() {
    invoiceDate.clear();
    invoiceDateV.value = '';
    taxsInvoice.clear();
    customerNameInvoice.clear();
    netInvoice.clear();
  }

  void clearItemsAddedToInvoice() {
    priceItemInvoice.clear();
    quantityItemInvoice.clear();
    customerNameInvoice.clear();
    netInvoice.clear();
  }

  void clearItemsAddItems() {
    codeaItemsSales.clear();
    //startMonthsLoans.value = DateTime.now();
    enNameItemsSales.clear();
    arNameItemsSales.clear();
    unitItemsSales.clear();
    priceItemsSales.clear();
    barcodeItemsSales.clear();
  }

  void clearItemsAddItemsGroup() {
    codeaItemsGroupSales.clear();
    enNameItemsGroupSales.clear();
    arNameItemsGroupSales.clear();
  }

  void clearItemsAddNewDiscount() {
    codeaItemsGroupSales.clear();
    enNameItemsGroupSales.clear();
    arNameItemsGroupSales.clear();
  }

  void clearItemsDPermission() {
    orderDate.clear();
    dPermissionReason.clear();
    startDate = null;
    endDate = null;
    dateFromOrder.clear();
    dateToOrder.clear();
    minitsNo.value = 0;
  }

  void clearItemsDeprPermission() {
    orderDateDeparure.clear();
    dPermissionDeparureReason.clear();
    startDate = null;
    endDate = null;
    dateFromDeparure.clear();
    dateToDeparure.clear();
    minitsDeparureNo.value = 0;
  }

  void clearItemsLocationRequest() {
    locationNameAddLocation.clear();
    addressAddLocation.clear();
    notesAddLocation.clear();
  }

  Future<AddLocation?> saveLocationRequest(BuildContext context,
      VoidCallback voidCallback, int langId, String long, String lat) async {
    final parms = {
      "locatioName": locationNameAddLocation.text,
      "address": addressAddLocation.text,
      "notes": notesAddLocation.text,
      "longitude": long,
      "latitude": lat,
      "langId": langId
    };
    final addLeaveRequest =
        await remoteDataSource.addLocation(parms, context, voidCallback);

    if (addLeaveRequest == null) {
      log('add Location null aaaaaaaaaaaaaa');
      return null;
    } else {
      allAddLocation.value = addLeaveRequest;
      checkIn.value = true;
      expandedCheckIn.value = true;
      Get.back();

      clearItemsLocationRequest();

      update();
      return addLeaveRequest;
    }
  }

  Future<GetEmpLoanRequest?> saveRequstLoan(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    if (hrLoanTypes.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterLoanType.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }
    if (loanValue.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterLoanValue.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }
    if (nofMonths.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterNofMonth.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    final parms = {
      "langId": langId,
      "loanId": hrLoansType.value.id ?? 0,
      "loanValue": int.tryParse(loanValue.text) ?? 0,
      "nofMonths": int.tryParse(nofMonths.text) ?? 0,
      "startMonths":
          DateTime.parse(startMonthsLoans.value.toString()).toIso8601String(),
      "reason": reasonLoans.text
    };
    final addLeaveRequest =
        await remoteDataSource.addRequestLoan(parms, context, voidCallback);

    if (addLeaveRequest == null) {
      log('add request holiday null aaaaaaaaaaaaaa');
      return null;
    } else {
      dataAdvanceReqIsEmpty.value = false;
      allEmployeesLoansReq.value = addLeaveRequest;

      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.saveDone.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );

      editRequestForSolfa2.value = false;
      editRequestForSolfa.value = false;
      addRequestForSolfa.value = false;
      addRequestForSolfa2.value = false;
      logsForSolfa.value = true;
      solfaRequest.value = false;
      expandedLoanRequest.value = true;

      clearItemsLoans();

      update();
      return addLeaveRequest;
    }
  }

  Future<GetEmployeeLeavesRequest?> saveRequstHoliday(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    if (hrLeaveTypes.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterHolidayType.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateFromHoliday.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.startDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateToHoliday.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.endDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }


    final parms = {
      "langId": langId,
      "leaveId": hrLeavesType.value.id ?? 0,
      "permissionFrom_Gregi":
          DateTime.parse(permissionFrom.value).toIso8601String(),
      "permissionTo_Gregi":
          DateTime.parse(permissionTo.value).toIso8601String(),
      "replaceableId": hrEmployees.value.id ?? 0,
      "reason": reason.text
    };
    final addLeaveRequest =
        await remoteDataSource.addRequestHoliday(parms, context, voidCallback);

    if (addLeaveRequest == null) {
      log('add request holiday null aaaaaaaaaaaaaa');
      return null;
    } else {
      dataEmployeesLeavesReqIsEmpty.value = false;
      allEmployeesLeavesReq.value = addLeaveRequest;


      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.saveDone.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );

      addRequestForHoliday2.value = false;
      editRequestForHoliday2.value = false;
      logsForHoliday.value = true;
      holidayRequest.value = false;
      expandedHolidayRequest.value = true;
      clearItems();

      update();
      return addLeaveRequest;
    }
  }

  Future<GetEmployeeDelayPermission?> saveDelayPermissionsRequest(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    if (orderDate.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterOrderDate.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateFromOrder.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.startDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateToOrder.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.endDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    final parms = {
      "langId": langId,
      "permissionDate_Gregi":
          DateTime.parse(orderDateV.value).toIso8601String(),
      "permissionFrom": DateTime.parse(orderDateFrom.value).toIso8601String(),
      "permissionTo": DateTime.parse(orderDateTo.value).toIso8601String(),
      "reason": dPermissionReason.text,
    };
    final addLeaveRequest = await remoteDataSource.addDPermissionRequest(
        parms, context, voidCallback, addDPermissionRequesttURL);

    if (addLeaveRequest == null) {
      log('addDPermissionRequest null aaaaaaaaaaaaaa');
      return null;
    } else {
      dataEmployeesDelayPermissionIsEmpty.value = false;
      allEmployeesDelayPermissionReq.value = addLeaveRequest;

      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.saveDone.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );

      showEmployeesDelayPermissionReq.value = false;
      addOrderDelayPermission.value = false;
      editOrderDelayPermission.value = false;
      depayPermission.value = true;
      holidayRequest.value = false;
      expandedOrder.value = true;
      clearItemsDPermission();

      update();
      return addLeaveRequest;
    }
  }

  Future<GetEmployeeDelayPermission?> saveDeparturePermissionsRequest(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    if (orderDateDeparure.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterOrderDate.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateFromDeparure.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.startDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateToDeparure.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.endDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    final parms = {
      "langId": langId,
      "permissionDate_Gregi":
          DateTime.parse(orderDateDepartureV.value).toIso8601String(),
      "permissionFrom":
          DateTime.parse(orderDateDeparureFrom.value).toIso8601String(),
      "permissionTo":
          DateTime.parse(orderDateDeparureTo.value).toIso8601String(),
      "reason": dPermissionDeparureReason.text,
    };
    final addLeaveRequest = await remoteDataSource.addDPermissionRequest(
        parms, context, voidCallback, addDeparturePermissionRequestURL);

    if (addLeaveRequest == null) {
      log('addDPermissionRequest null aaaaaaaaaaaaaa');
      return null;
    } else {
      dataEmployeesDeparturePermissionIsEmpty.value = false;
      allEmployeesDeparturePermissionReq.value = addLeaveRequest;

      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.saveDone.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );

      addOrderEarlyPermission.value = false;
      editOrderEarlyPermission.value = false;
      departurePermission.value = true;
      expandedOrderEPermission.value = true;
      showEmployeesDeparturePermissionReq.value = false;
      clearItemsDeprPermission();

      update();
      return addLeaveRequest;
    }
  }

  Future<GetEmployeeDelayPermission?> editDelayPermissionsRequest(
      BuildContext context,
      VoidCallback voidCallback,
      int langId,
      int id) async {
    if (orderDate.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterOrderDate.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateFromOrder.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.startDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateToOrder.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.endDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    final parms = {
      "id": id,
      "langId": langId,
      "permissionDate_Gregi":
          DateTime.parse(orderDateV.value).toIso8601String(),
      "permissionFrom": DateTime.parse(orderDateFrom.value).toIso8601String(),
      "permissionTo": DateTime.parse(orderDateTo.value).toIso8601String(),
      "reason": dPermissionReason.text,
    };
    final addLeaveRequest = await remoteDataSource.editEmployeeDelayPermission(
        parms, context, voidCallback, editEmployeeDelayPermissionURL);

    if (addLeaveRequest == null) {
      log('editDPermissionRequest null aaaaaaaaaaaaaa');
      return null;
    } else {
      dataEmployeesDelayPermissionIsEmpty.value = false;
      allEmployeesDelayPermissionReq.value = addLeaveRequest;

      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.editDone.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );

      addOrderDelayPermission.value = false;
      editOrderDelayPermission.value = false;
      depayPermission.value = true;
      expandedOrder.value = true;
      showEmployeesDelayPermissionReq.value = true;
      clearItemsDPermission();

      update();
      return addLeaveRequest;
    }
  }

  Future<GetEmployeeDelayPermission?> editDeparturePermissionsRequest(
      BuildContext context,
      VoidCallback voidCallback,
      int langId,
      int id) async {
    if (orderDateDeparure.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterOrderDate.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateFromDeparure.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.startDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateToDeparure.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.endDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    final parms = {
      "id": id,
      "langId": langId,
      "permissionDate_Gregi":
          DateTime.parse(orderDateDepartureV.value).toIso8601String(),
      "permissionFrom":
          DateTime.parse(orderDateDeparureFrom.value).toIso8601String(),
      "permissionTo":
          DateTime.parse(orderDateDeparureTo.value).toIso8601String(),
      "reason": dPermissionDeparureReason.text,
    };
    final addLeaveRequest = await remoteDataSource.editEmployeeDelayPermission(
        parms, context, voidCallback, editEmployeeDeparturePermissionURL);

    if (addLeaveRequest == null) {
      log('editDPermissionRequest null aaaaaaaaaaaaaa');
      return null;
    } else {
      dataEmployeesDeparturePermissionIsEmpty.value = false;
      allEmployeesDeparturePermissionReq.value = addLeaveRequest;

      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.editDone.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );

      addOrderEarlyPermission.value = false;
      editOrderEarlyPermission.value = false;
      departurePermission.value = true;
      expandedOrderEPermission.value = true;
      showEmployeesDeparturePermissionReq.value = true;
      clearItemsDeprPermission();

      update();
      return addLeaveRequest;
    }
  }

  Future<GetEmployeeDelayPermission?> deleteDelayPermissionsRequest(
      BuildContext context,
      VoidCallback voidCallback,
      int langId,
      int id) async {
    final parms = {"langId": 0, "id": id};
    final deleteLeaveRequest =
        await remoteDataSource.deleteEmployeeDelayPermission(
            parms, context, voidCallback, deleteDPermissionRequestURL);

    if (deleteLeaveRequest == null) {
      dataEmployeesDelayPermissionIsEmpty.value = true;
      update();
      log('deleteDelayPermissionsRequest null aaaaaaaaaaaaaa');
      return null;
    } else {
      if (deleteLeaveRequest.data![0].employeesPermissions!.isEmpty) {
        log('deleteDelayPermissionsRequest = isEmpty ..........');
        dataEmployeesDelayPermissionIsEmpty.value = true;

        update();
      } else {
        dataEmployeesDelayPermissionIsEmpty.value = false;
        allEmployeesDelayPermissionReq.value = deleteLeaveRequest;

        var snackBar = SnackBar(
          content: Text(
            LocaleKeys.deleDone.tr,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );

        addOrderDelayPermission.value = false;
        editOrderDelayPermission.value = false;
        depayPermission.value = true;
        showEmployeesDelayPermissionReq.value = true;

        update();
        return deleteLeaveRequest;
      }
    }
  }

  Future<GetEmployeeDelayPermission?> deleteDeparturePermissionsRequest(
      BuildContext context,
      VoidCallback voidCallback,
      int langId,
      int id) async {
    final parms = {"langId": 0, "id": id};
    final deleteLeaveRequest =
        await remoteDataSource.deleteEmployeeDelayPermission(
            parms, context, voidCallback, deleteDeparturePermissionRequestURL);

    if (deleteLeaveRequest == null) {
      dataEmployeesDeparturePermissionIsEmpty.value = true;
      update();
      log('deleteDelayPermissionsRequest null aaaaaaaaaaaaaa');
      return null;
    } else {
      if (deleteLeaveRequest.data![0].employeesPermissions!.isEmpty) {
        log('deleteDelayPermissionsRequest = isEmpty ..........');
        dataEmployeesDeparturePermissionIsEmpty.value = true;

        update();
      } else {
        dataEmployeesDeparturePermissionIsEmpty.value = false;
        allEmployeesDeparturePermissionReq.value = deleteLeaveRequest;

        var snackBar = SnackBar(
          content: Text(
            LocaleKeys.deleDone.tr,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );

        addOrderEarlyPermission.value = false;
        editOrderEarlyPermission.value = false;
        departurePermission.value = true;
        showEmployeesDeparturePermissionReq.value = true;

        update();
        return deleteLeaveRequest;
      }
    }
  }

  Future<GetEmployeeLeavesRequest?> editRequstHoliday(BuildContext context,
      VoidCallback voidCallback, int langId, int id) async {
    if (hrLeaveTypes.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterHolidayType.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateFromHoliday.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.startDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    if (dateToHoliday.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.endDateRequired.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }


    final parms = {
      "id": id,
      "langId": langId,
      "leaveId": hrLeavesType.value.id ?? 0,
      "permissionFrom_Gregi":
      DateTime.parse(permissionFrom.value).toIso8601String(),
      "permissionTo_Gregi":
      DateTime.parse(permissionTo.value).toIso8601String(),
      "replaceableId": hrEmployees.value.id ?? 0,
      "reason": reason.text
    };
    final addLeaveRequest =
    await remoteDataSource.editRequestHoliday(parms, context, voidCallback);

    if (addLeaveRequest == null) {
      log('edit request holiday null aaaaaaaaaaaaaa');
      return null;
    } else {
      dataEmployeesLeavesReqIsEmpty.value = false;
      allEmployeesLeavesReq.value = addLeaveRequest;

      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.editDone.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );

      addRequestForHoliday2.value = false;
      editRequestForHoliday2.value = false;
      logsForHoliday.value = true;
      holidayRequest.value = false;
      expandedHolidayRequest.value = true;
      showLeaveRequests.value = true;
      clearItems();

      update();
      return addLeaveRequest;
    }
  }

  Future<GetEmployeeLeavesRequest?> deleteRequstHoliday(BuildContext context,
      VoidCallback voidCallback, int langId, int id) async {
    final parms = {"langId": 0, "id": id};
    final deleteLeaveRequest = await remoteDataSource.deleteRequestHoliday(
        parms, context, voidCallback);

    if (deleteLeaveRequest == null) {
      dataEmployeesLeavesReqIsEmpty.value = true;
      update();
      log('delete request holiday null aaaaaaaaaaaaaa');
      return null;
    } else {
      if (deleteLeaveRequest.data!.isEmpty) {
        log('EmployeesLeavesRequest = isEmpty ..........');
        dataEmployeesLeavesReqIsEmpty.value = true;

        update();
      } else {
        dataEmployeesLeavesReqIsEmpty.value = false;
        allEmployeesLeavesReq.value = deleteLeaveRequest;


        var snackBar = SnackBar(
          content: Text(
            LocaleKeys.deleDone.tr,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );

        addRequestForHoliday.value = false;
        logsForHoliday.value = false;
        holidayRequest.value = true;

        update();
        return deleteLeaveRequest;
      }
    }
  }

  Future<GetEmpLoanRequest?> editRequstLoan(BuildContext context,
      VoidCallback voidCallback, int langId, int id) async {
    if (hrLoanTypes.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterLoanType.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }
    if (loanValue.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterLoanValue.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }
    if (nofMonths.text.isEmpty) {
      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.enterNofMonth.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return null;
    }

    final parms = {
      "id": id,
      "langId": langId,
      "loanId": hrLoansType.value.id ?? 0,
      "loanValue": int.tryParse(loanValue.text) ?? 0,
      "nofMonths": int.tryParse(nofMonths.text) ?? 0,
      "startMonths":
          DateTime.parse(startMonthsLoans.value.toString()).toIso8601String(),
      "reason": reasonLoans.text
    };
    final addLeaveRequest =
        await remoteDataSource.editRequestLoan(parms, context, voidCallback);

    if (addLeaveRequest == null) {
      log('edit request holiday null aaaaaaaaaaaaaa');
      return null;
    } else {
      dataAdvanceReqIsEmpty.value = false;
      allEmployeesLoansReq.value = addLeaveRequest;

      var snackBar = SnackBar(
        content: Text(
          LocaleKeys.editDone.tr,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );

      addRequestForHoliday2.value = false;
      addRequestForSolfa.value = false;
      addRequestForSolfa2.value = false;
      editRequestForHoliday2.value = false;
      editRequestForSolfa.value = false;
      editRequestForSolfa2.value = false;
      logsForSolfa.value = true;
      expandedLoanRequest.value = true;
      showAdvanceRequests.value = true;

      clearItemsLoans();

      update();
      return addLeaveRequest;
    }
  }

  Future<GetEmpLoanRequest?> deleteRequstLoan(BuildContext context,
      VoidCallback voidCallback, int langId, int id) async {
    final parms = {"langId": 0, "id": id};
    final deleteLeaveRequest =
        await remoteDataSource.deleteRequestLoan(parms, context, voidCallback);

    if (deleteLeaveRequest == null) {
      dataAdvanceReqIsEmpty.value = true;
      update();
      log('delete request loan null aaaaaaaaaaaaaa');
      return null;
    } else {
      if (deleteLeaveRequest.data!.isEmpty) {
        log('EmployeesLoanRequest = isEmpty ..........');
        dataAdvanceReqIsEmpty.value = true;

        update();
      } else {
        dataAdvanceReqIsEmpty.value = false;
        allEmployeesLoansReq.value = deleteLeaveRequest;

        var snackBar = SnackBar(
          content: Text(
            LocaleKeys.deleDone.tr,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );

        addRequestForSolfa.value = false;
        logsForSolfa.value = false;
        solfaRequest.value = true;

        update();
        return deleteLeaveRequest;
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<String> getLocalPath() async {
    var folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }

  Future<DriverAvailable?> loadDriverAvailWayBillWithoutContext(
      VoidCallback voidCallback, int langId) async {
    final driverWayBill = await remoteDataSource
        .driverAvailableWayBillWithoutContext(voidCallback, langId);

    if (driverWayBill == null) {
      noDataDriverAvailWayBill.value = true;

      update();
      return null;
    } else {
      if (driverWayBill.data!.isEmpty) {
        dataIsEmpty.value = true;

        update();
      } else {
        dataIsEmpty.value = false;

        final data = driverWayBill;
        allDriverAvailableWayBill.value = data;

        update();

        return data;
      }
    }
  }

  Future<File> getLocalTypeOfScreen() async {
    String path = await getLocalPath();
    return File('$path/activate.txt');
  }

  Future<File> getTypeOfOperation() async {
    String path = await getLocalPath();
    return File('$path/typeOfOperation.txt');
  }

  Future<File> writeTypeOfOperation(TypeOfOperation contents) async {
    File file = await getTypeOfOperation();
    String jsonContent = jsonEncode(contents.toJson());
    return await file.writeAsString(jsonContent);
  }



  Future<TypeOfOperation> readTypeOfOperation() async {
    try {
      final file = await getTypeOfOperation();
      String content = await file.readAsString();

      Map<String, dynamic> jsonData = jsonDecode(content);
      TypeOfOperation data = TypeOfOperation.fromJson(jsonData);
      return data;
    } catch (e) {
      return TypeOfOperation();
    }
  }


  bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 700;
  }

  bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 700 &&
        MediaQuery.of(context).size.width <= 1000;
  }

  bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1000 &&
        MediaQuery.of(context).size.width <= 1200;
  }

  bool isVeryLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  Future<File> writeActivateIndex(int contents) async {
    File file = await getLocalTypeOfScreen();
    return await file.writeAsString('$contents');
  }

  Future<int> readActivateIndex() async {
    try {
      final file = await getLocalTypeOfScreen();
      String content = await file.readAsString();

      return int.parse(content);
    } catch (e) {
      return 0;
    }
  }

  Future<void> refreshList(BuildContext context, VoidCallback voidCallback, int langId) async {
    log('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 3));

    if (currentNotific.value == true &&
        notificLog.value == false &&
        money.value == false) {
      // showWayBillDetails.value = false;

      await loadDriverAvailWayBill(context, voidCallback, langId);
    } else if (currentNotific.value == false &&
        notificLog.value == true &&
        money.value == false){
      // showWayBillDetails.value = false;

      await loadLastNotification(context, () {
        Get.find<LoginController>().loginPinCodeController.clear();
      }, '', Get.find<LanguageController>().selectedLanguage?.id ?? 2);
    } else if (currentNotific.value == false &&
        notificLog.value == false &&
        money.value == true) {
      // showWayBillDetails.value = false;

      await loadGetTotallyDues(context, () {
        Get.find<LoginController>().loginPinCodeController.clear();
      }, Get
              .find<LanguageController>()
              .selectedLanguage
              ?.id ??
              2, dataFinancialYears.value.financialYear ?? '');
    }

    else if (addRequestForSolfa.value == true &&
        logsForSolfa.value == false &&
        accountsKahfForSolfa.value == false) {
    } else if (addRequestForHoliday.value == false &&
        logsForHoliday.value == true &&
        accountsKahfForHoliday.value == false) {
      if (dataFinancialYears.value.financialYear ==
          Get.find<LoginController>().user.getDefaultFinancialYears) {
        dataFinancialYears.value =
            Get.find<LoginController>().user.getDefaultFinancialYears;
      }

      await loadGetEmployeesLeaves(context, () {
        Get.find<LoginController>().loginPinCodeController.clear();
      }, Get.find<LanguageController>().selectedLanguage?.id ?? 2);
    } else if (addRequestForSolfa.value == false &&
        logsForSolfa.value == true &&
        accountsKahfForSolfa.value == false) {
      await loadGetEmployeesLoans(context, () {
        Get.find<LoginController>().loginPinCodeController.clear();
      }, Get.find<LanguageController>().selectedLanguage?.id ?? 2);
    }

    update();
  }

  Future<DriverAvailable?> loadDriverAvailWayBill(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill = await remoteDataSource.driverAvailableWayBill(
        context, voidCallback, langId);

    if (driverWayBill == null) {
      noDataDriverAvailWayBill.value = true;

      log('message driverWayBill = $driverWayBill');

      update();
      return null;
    }
    else {
      if (driverWayBill.data!.isEmpty) {
        dataIsEmpty.value = true;

        update();
      }
      else {
        dataIsEmpty.value = false;

        final data = driverWayBill;
        allDriverAvailableWayBill.value = data;

        // streamController.value.close();
        // streamController.value = StreamController<DriverAvailable>();
        // streamController.value.sink.add(data);

        update();

        return data;
      }
    }
  }

  Future<DriverAvailable?> loadDriverAvailWayBillTe(int langId) async {
    final driverWayBill =
        await remoteDataSource.driverAvailableWayBillListen(langId);

    if (driverWayBill == null) {
      noDataDriverAvailWayBill.value = true;

      log('message driverWayBill = $driverWayBill');

      update();
      return null;
    } else {
      if (driverWayBill.data!.isEmpty) {
        dataIsEmpty.value = true;

        update();
      } else {
        dataIsEmpty.value = false;

        final data = driverWayBill;
        allDriverAvailableWayBill.value = data;

        // streamController.value.close();
        // streamController.value = StreamController<DriverAvailable>();
        // streamController.value.sink.add(data);

        update();

        return data;
      }
    }
  }

  Future<void> openFile(String url) async {
    var status = await Permission.manageExternalStorage.request();
    if (status.isDenied) {
      log('status is denied.................');
      Permission.manageExternalStorage.request();
    } else {
      log('status is not denied bbbbbbbbbbbbbbbbbbbbb');
      try {
        final file = await downloadFile(url);
        if (file == null) return;
        final res = await OpenFile.open(file.path);
        log(res.message);
      } catch (e) {
        log('errror open file = ${e.toString()}');
      }
    }
  }

  Future<File?> downloadFile(String url) async {
    try {
      Directory directory = await getTemporaryDirectory();
      await getExternalStorageDirectory();
      final file = File('${directory.path}/filex.pdf');
      final options =
      Options(followRedirects: false, responseType: ResponseType.bytes);
      final res = await Dio().get(url, options: options);

      // remoteDataSource.openDocument(path, id);
      final ref = file.openSync(mode: FileMode.write);
      ref.writeFromSync(res.data);
      await ref.close();
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<ChangePassword?> loadChangePassword(BuildContext context,
      VoidCallback voidCallback, String oldPass, String newPass) async {
    final driverWayBill = await remoteDataSource.changePassword(
        context, voidCallback, oldPass, newPass);

    if (driverWayBill == null) {
      log('message change password = $driverWayBill');

      update();
      return null;
    } else {
      final data = driverWayBill;
      allChangePassword.value = data;

      update();

      return data;
    }
  }

  Future<void> loadOpenDocument(int id, BuildContext ctx) async {
    log('*************************');
    remoteDataSource.openDocument(id, ctx);

    update();
  }

  Future<void> loadOpenWaybill(int id, BuildContext ctx) async {
    log('********* loadOpenWaybill *******');
    remoteDataSource.openWaybill(id, ctx);

    update();
  }

  void onchangeRefusedReason(value) {
    dataRefusedReason.value = value;
    update();
  }

  void onchangeFY(value) {
    dataFinancialYears.value = value;

    update();
  }

  void onchangeFYLoanStatment(value) {
    dataFYLoanStatment.value = value;

    update();
  }

  Future<RefusedReason?> loadRefusedReason(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill =
        await remoteDataSource.getRefusedReason(context, voidCallback, langId);

    if (driverWayBill == null) {
      noDataRefusedReason.value = true;

      log('message driverWayBill = $driverWayBill');

      update();
      return null;
    } else {
      final data = driverWayBill;
      allRefusedReason.value = data;

      update();

      return data;
    }
  }


  Future<DriverAvailable?> loadGetWaybillDetails(BuildContext context,
      VoidCallback voidCallback, int id, int langId) async {
    final driverWayBillDetails = await remoteDataSource.driverWaybillDetails(
        context, voidCallback, id, langId);

    if (driverWayBillDetails == null) {
      noDataWayBillDetails.value = true;

      log('message GetWaybillDetails = $driverWayBillDetails');

      update();
      return null;
    }
    else {
      final data = driverWayBillDetails;
      getWaybillDetails.value = data;

      update();

      return data;
    }

  }

  String allTotalBadelDezalTotally() {
    double totalBadelDezalTotally = 0.0;
    for (var data in selectedProductsTotallyDetails) {
      totalBadelDezalTotally += data.dieselAllowances;
    }
    return totalBadelDezalTotally.toStringAsFixed(
        totalBadelDezalTotally.truncateToDouble() == totalBadelDezalTotally
            ? 0
            : 1);
  }


  String allTotalBadelTariqTotally() {
    double totalBadelDezalTotally = 0.0;
    for (var data in selectedProductsTotallyDetails) {
      totalBadelDezalTotally += data.transportAllowances;
    }
    return totalBadelDezalTotally.toStringAsFixed(
        totalBadelDezalTotally.truncateToDouble() == totalBadelDezalTotally
            ? 0
            : 1);
  }

  String allTotalPaymentTotally() {
    double totalBadelDezal = 0.0;
    for (var data in selectedProductsTotallyDetails) {
      totalBadelDezal += data.paidValue;
    }
    return totalBadelDezal.toStringAsFixed(
        totalBadelDezal.truncateToDouble() == totalBadelDezal ? 0 : 1);
  }

  String countTransportTotally() {
    double totalBadelDezal = 0.0;
    for (var data in selectedProductsTotallyDetails) {
      totalBadelDezal += data.countTransport;
    }
    return totalBadelDezal.toStringAsFixed(
        totalBadelDezal.truncateToDouble() == totalBadelDezal ? 0 : 1);
  }


  String allTotalNetTotally() {
    double totalBadelDezal = 0.0;
    for (var data in selectedProductsTotallyDetails) {
      totalBadelDezal += data.net;
    }
    return totalBadelDezal.toStringAsFixed(
        totalBadelDezal.truncateToDouble() == totalBadelDezal ? 0 : 1);
  }


  String allTotalCostTotally() {
    double totalBadelDezalTotally = 0.0;
    for (var data in selectedProductsTotallyDetails) {
      totalBadelDezalTotally += data.additionalAllowance;
    }
    return totalBadelDezalTotally.toStringAsFixed(
        totalBadelDezalTotally.truncateToDouble() == totalBadelDezalTotally
            ? 0
            : 1);
  }

  String allTotalTotally() {
    double totalBadelDezal = 0.0;
    for (var data in selectedProductsTotallyDetails) {
      totalBadelDezal += data.total;
    }
    return totalBadelDezal.toStringAsFixed(
        totalBadelDezal.truncateToDouble() == totalBadelDezal ? 0 : 1);
  }


  Future<TotallyDues?> loadGetTotallyDues(BuildContext context,
      VoidCallback voidCallback, int langId, String fy) async {
    final driverWayBill =
    await remoteDataSource.getTotallyDues(context, voidCallback, langId, fy);

    if (driverWayBill == null) {
      log('loadGetTotallyDues = null .......');
      noDataGetTotallyDues.value = true;

      update();
      return null;
    } else {
      if (driverWayBill.data!.isEmpty) {
        log('loadGetTotallyDues = isEmpty ..........');
        dataIsthqaqatIsEmpty.value = true;

        update();
      } else {
        log('loadGetTotallyDues = isnotEmpty ..........');
        dataIsthqaqatIsEmpty.value = false;

        final data = driverWayBill;
        allTotallyDues.value = data;

        selectedProductsTotallyDetails = allTotallyDues.value.data ?? [];
        update();

        return data;
      }
    }
  }

  Future<GetEmployeeLoans?> loadGetEmployeesLoans(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill =
        await remoteDataSource.getEmployeesLoans(context, voidCallback, langId);

    if (driverWayBill == null) {
      log('EmployeesLeaves = null .......');
      noDataGetEmployeesLoans.value = true;

      update();
      return null;
    } else {
      if (driverWayBill.data![0].employeesLoans!.isEmpty) {
        log('EmployeesLeaves = isEmpty ..........');
        dataAdvancePaymentsIsEmpty.value = true;

        update();
      } else {
        log('EmployeesLeaves = isnotEmpty ..........');
        dataAdvancePaymentsIsEmpty.value = false;

        final data = driverWayBill;
        allEmployeesLoans.value = data;

        update();

        return data;
      }
    }
  }

  Future<GetEmployeeLeaves?> loadGetEmployeesLeaves(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill = await remoteDataSource.getEmployeesLeaves(
        context, voidCallback, langId);

    if (driverWayBill == null) {
      log('EmployeesLeaves = null .......');
      noDataGetEmployeesLeaves.value = true;

      update();
      return null;
    } else {
      if (driverWayBill.data![0].employeesLeaves!.isEmpty) {
        log('EmployeesLeaves = isEmpty ..........');
        dataEmployeesLeavesIsEmpty.value = true;

        update();
      } else {
        log('EmployeesLeaves = isnotEmpty ..........');
        dataEmployeesLeavesIsEmpty.value = false;

        final data = driverWayBill;
        allEmployeesLeaves.value = data;

        update();

        return data;
      }
    }
  }

  Future<GetEmployeeDelayPermission?> loadGetEmployeesDelayPermission(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill = await remoteDataSource.getEmployeesDelayPermission(
        context, voidCallback, langId, getEmployeesDelayPermissionUrl);

    if (driverWayBill == null) {
      log('EmployeesDelayPermission = null .......');
      noDataGetEmployeesDelayPermission.value = true;

      update();
      return null;
    } else {
      try {
        if (driverWayBill.data![0].employeesPermissions!.isEmpty) {
          log('EmployeesDelayPermission = isEmpty ..........');
          dataEmployeesDPIsEmpty.value = true;

          update();
        } else {
          log('EmployeesDelayPermission = isnotEmpty ..........');
          dataEmployeesDPIsEmpty.value = false;

          final data = driverWayBill;
          allEmployeesDelayPermission.value = data;

          update();

          return data;
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<GetEmployeePerAbsence?> loadGetEmployeesAbsencePermission(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill = await remoteDataSource.getEmployeesAbsencePermission(
        context, voidCallback, langId);

    if (driverWayBill == null) {
      log('EmployeesAbsencePermission = null .......');
      dataEmployeesAbsencePermissionIsEmpty.value = true;

      update();
      return null;
    } else {
      try {
        if (driverWayBill.data![0].employeesPermissionsAbsence!.isEmpty) {
          log('EmployeesAbsencePermission = isEmpty ..........');
          dataEmployeesAbsencePermissionIsEmpty.value = true;

          update();
        } else {
          log('EmployeesDelayPermission = isnotEmpty ..........');
          dataEmployeesAbsencePermissionIsEmpty.value = false;

          final data = driverWayBill;
          allEmployeesAbsencePermission.value = data;

          update();

          return data;
        }
      } catch (e) {
        log('Error absence = ${e.toString()}');
      } finally {
        dataEmployeesAbsencePermissionIsEmpty.value = false;
      }
    }
  }


  Future<GetEmployeeDelayPermission?> loadGetEmployeesDeparturePermissions(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill = await remoteDataSource
        .getEmployeesDeparturePermissions(context, voidCallback, langId);

    if (driverWayBill == null) {
      log('EmployeesDeparturePermission = null .......');
      dataEmployeesDPIsEmpty.value = true;

      update();
      return null;
    } else {
      try {
        if (driverWayBill.data![0].employeesPermissions!.isEmpty) {
          log('EmployeesDeparturePermission = isEmpty ..........');
          dataEmployeesDPIsEmpty.value = true;

          update();
        } else {
          log('EmployeesDeparturePermission = isnotEmpty ..........');
          dataEmployeesDPIsEmpty.value = false;

          final data = driverWayBill;
          allEmployeesDeparturePermission.value = data;

          update();

          return data;
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<GetEmployeeLeavesRequest?> loadGetEmployeesLeavesRequest(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill = await remoteDataSource.getEmployeesLeavesRequest(
        context, voidCallback, langId);

    if (driverWayBill == null) {
      log('EmployeesLeavesRequest = null .......');
      noDataGetEmployeesLeavesReq.value = true;

      update();
      return null;
    } else {
      if (driverWayBill.data!.isEmpty) {
        log('EmployeesLeavesRequest = isEmpty ..........');
        dataEmployeesLeavesReqIsEmpty.value = true;

        update();
      } else {
        log('EmployeesLeavesRequest = isnotEmpty ..........');
        dataEmployeesLeavesReqIsEmpty.value = false;

        final data = driverWayBill;
        allEmployeesLeavesReq.value = data;

        update();

        return data;
      }
    }
  }

  Future<GetEmployeeDelayPermission?> loadGetEmployeesDelayPermissionsRequest(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill =
        await remoteDataSource.getEmployeesDelayPermissionRequest(context,
            voidCallback, langId, getEmployeeDelayPermissionRequestUrl);

    if (driverWayBill == null) {
      log('GetEmployeeDelayPermission = null .......');
      noDataGetEmployeesDelayPermission.value = true;

      update();
      return null;
    } else {
      try {
        if (driverWayBill.data![0].employeesPermissions!.isEmpty) {
          log('GetEmployeeDelayPermission = isEmpty ..........');
          dataEmployeesDelayPermissionIsEmpty.value = true;

          update();
        } else {
          log('GetEmployeeDelayPermission = isnotEmpty ..........');
          dataEmployeesDelayPermissionIsEmpty.value = false;

          final data = driverWayBill;
          allEmployeesDelayPermissionReq.value = data;

          update();

          return data;
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<CheckIn?> loadGetTodayCheck(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill =
        await remoteDataSource.getTodayCheck(context, voidCallback, langId);

    if (driverWayBill == null) {
      log('loadGetTodayCheck = null .......');
      // noDataGetEmployeesLeaves.value = true;

      update();
      return null;
    } else {
      if (driverWayBill.data!.isEmpty) {
        log('loadGetTodayCheck = isEmpty ..........');
        dataTodayCheckIsEmpty.value = true;

        update();
      } else {
        log('loadGetTodayCheck = isnotEmpty ..........');
        dataTodayCheckIsEmpty.value = false;

        final data = driverWayBill;
        allCheckInLocation.value = data;

        update();

        return data;
      }
    }
  }

  Future<CheckIn?> loadCheckInByLocation(
      BuildContext ctx,
      VoidCallback voidCallback,
      String lat,
      String long,
      int langId,
      int locationId) async {
    final driverWayBill = await remoteDataSource.updateCheckinByLocation(
        ctx, voidCallback, lat, long, langId, locationId);

    try {
      if (driverWayBill == null) {
        log('loadCheckInByLocation = null .......');

        if (checkInNotAllowed.value == true) {
          await Get.dialog(
              AlertDialog(
                title: Text('${LocaleKeys.noAllowToAddLocation.tr}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Get.find<LoginController>()
                                  .user
                                  .data
                                  ?.showHumanResourcesAddLocation ==
                              true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green)),
                                    onPressed: () async {
                                      clearItemsLocationRequest();
                                      await Get.dialog(
                                        barrierDismissible: false,
                                        AlertDialog(
                                            title: Text(
                                                LocaleKeys.addLocation.tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextFormField(
                                                      // focusNode: usernameFocusNode1,
                                                      // onEditingComplete: () =>
                                                      //     FocusScope.of(ctx)
                                                      //         .requestFocus(
                                                      //             usernameFocusNode2),
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                      cursorColor: Colors.black,
                                                      controller:
                                                          locationNameAddLocation,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        labelText: LocaleKeys
                                                            .locationname.tr,
                                                        labelStyle:
                                                            const TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                        border: const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                        disabledBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextFormField(
                                                      // focusNode: usernameFocusNode2,
                                                      // onEditingComplete: () =>
                                                      //     FocusScope.of(ctx)
                                                      //         .requestFocus(
                                                      //             usernameFocusNode3),
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                      cursorColor: Colors.black,
                                                      controller:
                                                          addressAddLocation,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        labelText: LocaleKeys
                                                            .addressSender.tr,
                                                        labelStyle:
                                                            const TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                        border: const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                        disabledBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextFormField(
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                      cursorColor: Colors.black,
                                                      controller:
                                                          notesAddLocation,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        labelText:
                                                            LocaleKeys.note.tr,
                                                        labelStyle:
                                                            const TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                        border: const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                        disabledBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black54,
                                                                    width: 1)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              SizedBox(
                                                width: 120,
                                                // height: 60,
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .green)),
                                                    onPressed: () async {
                                                      await saveLocationRequest(
                                                        ctx,
                                                        () {
                                                          Get.find<
                                                                  LoginController>()
                                                              .loginPinCodeController
                                                              .clear();
                                                        },
                                                        Get.find<LanguageController>()
                                                                .selectedLanguage
                                                                ?.id ??
                                                            2,
                                                        myPosition
                                                            .value.longitude
                                                            .toString(),
                                                        myPosition
                                                            .value.latitude
                                                            .toString(),
                                                      );
                                                    },
                                                    child: Text(
                                                        '${LocaleKeys.addOrder.tr}',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white))),
                                              ),
                                              TextButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.red)),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                      '${LocaleKeys.cancel.tr}',
                                                      style: const TextStyle(
                                                          color: Colors.white)))
                                            ]),
                                      ).then((value) {
                                        Get.back();
                                      });
                                    },
                                    child: Text('${LocaleKeys.addLocation.tr}',
                                        style: const TextStyle(
                                            color: Colors.white))),
                                TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('${LocaleKeys.cancel.tr}',
                                        style: const TextStyle(
                                            color: Colors.white)))
                              ],
                            )
                          : TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('${LocaleKeys.ok.tr}',
                                  style: const TextStyle(color: Colors.white)))
                    ],
                  ),
                ),
              ),
              barrierDismissible: false);
        }

        update();
        return null;
      } else {
        try {
          if (driverWayBill.data!.isEmpty) {
            log('loadCheckInByLocation = isEmpty ..........');
            dataTodayCheckIsEmpty.value = true;

            update();
          } else {
            log('GetEmployeeDeparturePermission = isnotEmpty ..........');
            dataTodayCheckIsEmpty.value = false;

            final data = driverWayBill;
            allCheckInLocation.value = data;

            if (driverWayBill.message == 'Select One Location Of below') {
              log('message = Select One Location Of below');

              log('111111111111111111111 execute');
              Get.dialog(
                AlertDialog(
                    title: Text('${LocaleKeys.selectOneLocation.tr}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            allCheckInLocation.value.data?.length ?? 0,
                            (index) => Obx(() => CheckboxListTile(
                                title: Text(
                                    '${allCheckInLocation.value.data?[0].hREmployeesCheckInOutLocations?[index].locatioName}'),
                                value: selectedIndexOfLocation.value == index,
                                onChanged: (bool? value) async {
                                  log('location id = ${allCheckInLocation.value.data?[0].hREmployeesCheckInOutLocations?[index].id}');
                                  selectOneLocationF(index);

                                  await loadCheckInByLocation(ctx, () {
                                    Get.find<LoginController>()
                                        .loginPinCodeController
                                        .clear();
                                  },
                                      // '30.695708',
                                      // "31.462673",
                                      myPosition.value.latitude.toString(),
                                      myPosition.value.longitude.toString(),
                                      Get.find<LanguageController>()
                                              .selectedLanguage
                                              ?.id ??
                                          2,
                                      allCheckInLocation
                                              .value
                                              .data?[0]
                                              .hREmployeesCheckInOutLocations?[
                                                  index]
                                              .id ??
                                          0);
                                  // Get.back();
                                }))),
                      ),
                    ),
                    actions: [
                      SizedBox(
                        width: 120,
                        // height: 60,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('${LocaleKeys.ok.tr}',
                                style: const TextStyle(color: Colors.white))),
                      ),
                    ]),
              );
            }

            update();

            return data;
          }
        } catch (e) {
          log(e.toString());
        }
      }
    } catch (e) {
      log('${e.toString()}');
    } finally {
      checkInNotAllowed.value = false;
    }
  }

  Future<MonthCheck?> loadGetMonthCheck(BuildContext context,
      VoidCallback voidCallback, int langId, int month, int year) async {
    final driverWayBill = await remoteDataSource.getMonthCheck(
        context, voidCallback, langId, month, year);

    if (driverWayBill == null) {
      log('loadGetMonthCheck = null .......');
      update();
      return null;
    } else {
      try {
        if (driverWayBill.data!.isEmpty) {
          log('loadGetMonthCheck = isEmpty ..........');
          dataMonthCheckIsEmpty.value = true;

          update();
        } else {
          log('loadGetMonthCheck = isnotEmpty ..........');
          dataMonthCheckIsEmpty.value = false;

          final data = driverWayBill;
          allMonthCheck.value = data;

          update();

          return data;
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<GetEmployeeDelayPermission?> loadGetEmployeesDeparturePermisRequest(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill =
    await remoteDataSource.getEmployeesDelayPermissionRequest(
        context, voidCallback, langId, getEmployeeDeparutrePermRequestUrl);

    dataEmployeesDeparturePermissionIsEmpty.value = false;
    if (driverWayBill == null) {
      log('GetEmployeeDeparturePermission = null .......');
      dataEmployeesDeparturePermissionIsEmpty.value = true;

      update();
      return null;
    } else {
      try {
        if (driverWayBill.data![0].employeesPermissions!.isEmpty) {
          log('GetEmployeeDeparturePermission  = isEmpty ..........');
          dataEmployeesDeparturePermissionIsEmpty.value = true;

          update();
        } else {
          log('GetEmployeeDeparturePermission = isnotEmpty ..........');
          dataEmployeesDeparturePermissionIsEmpty.value = false;

          final data = driverWayBill;
          allEmployeesDeparturePermissionReq.value = data;

          update();

          return data;
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<GetEmployeeStatement?> loadGetEmployeesAccountStatement(
    BuildContext context,
    VoidCallback callbackAction,
    int langId,
    String fromDate,
    String toDate,
  ) async {
    final driverWayBill = await remoteDataSource.getEmployeesAccountStatement(
        context, callbackAction, langId, fromDate, toDate);

    if (driverWayBill == null) {
      log('GetEmployeeAccountStatement = null .......');
      dataEmployeesAccountStateIsEmpty.value = true;

      update();
      return null;
    } else {
      try {
        if (driverWayBill.data![0].employeeStatementList!.isEmpty) {
          log('GetEmployeeAccountStatement = isEmpty ..........');
          dataEmployeesAccountStateIsEmpty.value = true;

          update();
        } else {
          log('GetEmployeeAccountStatement = isnotEmpty ..........');
          dataEmployeesAccountStateIsEmpty.value = false;

          final data = driverWayBill;
          allEmployeesAccountStatement.value = data;
          getTotalBalance;

          update();

          return data;
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<GetEmployeeStatement?> loadGetEmployeesAccountStatementWithoutContext(
      VoidCallback voidCallback, int langId, String TransactionTypeId) async {
    final driverWayBill =
        await remoteDataSource.getEmployeesAccountStatementWithoutContext(
            voidCallback, langId, TransactionTypeId);

    if (driverWayBill == null) {
      log('GetEmployeeAccountStatement = null .......');
      dataEmployeesAccountStateIsEmpty.value = true;

      update();
      return null;
    } else {
      try {
        if (driverWayBill.data![0].employeeStatementList!.isEmpty) {
          log('GetEmployeeAccountStatement = isEmpty ..........');
          dataEmployeesAccountStateIsEmpty.value = true;

          update();
        } else {
          log('GetEmployeeAccountStatement = isnotEmpty ..........');
          dataEmployeesAccountStateIsEmpty.value = false;

          final data = driverWayBill;
          allEmployeesAccountStatement.value = data;
          getTotalBalance;

          update();

          return data;
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  double get getTotalDebit {
    try {
      List<EmployeeStatementList> empList =
          allEmployeesAccountStatement.value.data?[0].employeeStatementList ??
              [];
      double totalBalance = empList.fold(
          0.0, (previousValue, element) => previousValue + element.debit!);

      return totalBalance;
    } catch (e) {
      return 0.0;
    }
  }

  double get getTotalCredit {
    try {
      List<EmployeeStatementList> empList =
          allEmployeesAccountStatement.value.data?[0].employeeStatementList ??
              [];
      double totalBalance = empList.fold(
          0.0, (previousValue, element) => previousValue + element.credit!);

      return totalBalance;
    } catch (e) {
      return 0.0;
    }
  }

  double get getTotalBalance {
    try {
      List<EmployeeStatementList> empList =
          allEmployeesAccountStatement.value.data?[0].employeeStatementList ??
              [];
      double totalBalance = empList.last.balance ?? 0.0;

      return totalBalance;
    } catch (e) {
      return 0.0;
    }
  }

  void closeAllTabes() {
    auzonat.value = false;
    accountsKahfForSolfa.value = false;
    checkIn.value = false;
    depayPermission.value = false;
    departurePermission.value = false;
    absentPermission.value = false;
    editRequestForHoliday2.value = false;
    editRequestForSolfa2.value = false;
    addRequestForSolfa2.value = false;
    addRequestForHoliday2.value = false;

    expandedHolidayRequest.value = false;
    expandedChenkInMonth.value = false;
    expandedCheckIn.value = false;
    expandedDelayPermission.value = false;
    expandedabsencePermission.value = false;
    expandedLoanStatment.value = false;
    expandedAccountStatment.value = false;
    expandedLDelayPermission.value = false;
    expandedOrder.value = false;

    expandedEarlyPermission.value = false;
    expandedLEarlyPermission.value = false;
    expandedOrderEPermission.value = false;
    expandedLoanRequest.value = false;
    editRequestForSolfa.value = false;
    editRequestForHoliday.value = false;
    addRequestForHoliday.value = false;
    addRequestForSolfa.value = false;
    showEmployeesLeaves.value = false;
    showEmployeesDelayPermissionReq.value = false;
    showEmployeesDelayPermission.value = false;
    addRequestForSolfa.value = false;
    solfaRequest.value = false;
    logsForSolfa.value = false;
    showAdvanceRequests.value = false;
    showAdvanceDetails.value = false;
    showLeaveRequests.value = false;
    holidayRequest.value = false;
    allHolidays.value = false;
  }

  double get getTotalDebitLoanStatment {
    try {
      List<EmployeeLoanStatementList> empList =
          allEmployeesLoanStatement.value.data?[0].employeeLoanStatementList ??
              [];
      double totalBalance = empList.fold(
          0.0, (previousValue, element) => previousValue + element.debit!);

      return totalBalance;
    } catch (e) {
      return 0.0;
    }
  }

  double get getTotalCreditLoanStatment {
    try {
      List<EmployeeLoanStatementList> empList =
          allEmployeesLoanStatement.value.data?[0].employeeLoanStatementList ??
              [];
      double totalBalance = empList.fold(
          0.0, (previousValue, element) => previousValue + element.credit!);

      return totalBalance;
    } catch (e) {
      return 0.0;
    }
  }

  double get getTotalBalanceLoanStatment {
    try {
      List<EmployeeLoanStatementList> empList =
          allEmployeesLoanStatement.value.data?[0].employeeLoanStatementList ??
              [];
      double totalBalance = empList.last.balance ?? 0.0;

      return totalBalance;
    } catch (e) {
      return 0.0;
    }
  }

  Future<GetEmpLoanStatment?> loadGetEmployeesLoanStatement(
      BuildContext context,
      VoidCallback voidCallback,
      int langId,
      int fY) async {
    final driverWayBill = await remoteDataSource.getEmployeesLoanStatement(
        context, voidCallback, langId, fY);

    if (driverWayBill == null) {
      log('getEmployeesLoanStatement = null .......');
      dataEmployeesLoanStateIsEmpty.value = true;

      update();
      return null;
    } else {
      try {
        if (driverWayBill.data![0].employeeLoanStatementList!.isEmpty) {
          log('getEmployeesLoanStatement = isEmpty ..........');
          dataEmployeesLoanStateIsEmpty.value = true;

          update();
        } else {
          log('getEmployeesLoanStatement = isnotEmpty ..........');
          dataEmployeesLoanStateIsEmpty.value = false;

          final data = driverWayBill;
          allEmployeesLoanStatement.value = data;
          getTotalBalanceLoanStatment;

          update();

          return data;
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<GetEmpLoanRequest?> loadGetEmployeesLoansRequest(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill = await remoteDataSource.getEmployeesLoansRequest(
        context, voidCallback, langId);

    if (driverWayBill == null) {
      log('EmployeesLoansRequest = null .......');
      noDataGetEmployeesLeavesReq.value = true;

      update();
      return null;
    } else {
      if (driverWayBill.data!.isEmpty) {
        log('EmployeesLeavesRequest = isEmpty ..........');
        dataAdvanceReqIsEmpty.value = true;

        update();
      } else {
        log('EmployeesLeavesRequest = isnotEmpty ..........');
        dataAdvanceReqIsEmpty.value = false;

        final data = driverWayBill;
        allEmployeesLoansReq.value = data;

        update();

        return data;
      }
    }
  }

  Future<GetVactionBalance?> loadGetVacationsBalance(
      BuildContext context, VoidCallback voidCallback, int langId) async {
    final driverWayBill = await remoteDataSource.getVacationsBalance(
        context, voidCallback, langId);

    if (driverWayBill == null) {
      log('GetVactionBalance = null .......');
      noDataGetVactionBalance.value = true;

      update();
      return null;
    } else {
      if (driverWayBill.data!.isEmpty) {
        log('GetVactionBalance = isEmpty ..........');
        dataGetVactionBalance.value = true;

        update();
      } else {
        log('GetVactionBalance = isnotEmpty ..........');
        dataGetVactionBalance.value = false;

        final data = driverWayBill;
        allGetVactionBalance.value = data;

        update();

        return data;
      }
    }
  }

  Future<VacationBalance?> loadGetVacationBalance(BuildContext context,
      VoidCallback voidCallback, int langId, int leaveId) async {
    final driverWayBill = await remoteDataSource.getVacationBalance(
        context, voidCallback, langId, leaveId);

    if (driverWayBill == null) {
      noDataVactionBalance.value = true;

      update();
      return null;
    } else {
      if (driverWayBill.data == null) {
        allVactionBalance.value.data = '';
        update();
      } else {
        dataVactionBalance.value = false;

        final data = driverWayBill;
        allVactionBalance.value = data;

        update();

        return data;
      }
    }
  }

  Future<bool> getCurrentLocation() async {
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      myPosition.value = newLocalData;

      log('myPosition long = ${myPosition.value.longitude}');
      log('myPosition lat = ${myPosition.value.latitude}');

      return true;
    } catch (e) {
      log(' catch getCurrentLocation error = ${e.toString()}');

      return false;
    }
  }

  Future<void> checkPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {}
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      log('`````````````LocationPermission always or while in use ``````````');
      isPermissionGranted.value = true;
      await getCurrentLocation();
    } else {
      await requestLocationPermission(context);
    }
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      log('`````````````LocationPermission always or while in use ``````````');
      isPermissionGranted.value = true;
      await getCurrentLocation();
    }
  }

  Future<DriverAvailable?> loadUpdatedTruckerStatus(
      int transportId,
      int truckerStatus,
      BuildContext context,
      VoidCallback voidCallback,
      String lat,
      String long,
      int langId) async {
    final updateState = await remoteDataSource.updateTruckerStatus(
        transportId, truckerStatus, context, voidCallback, lat, long, langId);

    if (updateState == null) {
      update();
      return null;
    } else {
      final data = updateState;
      allDriverAvailableWayBill.value = data;

      update();

      return data;
    }
  }

  Future<DriverAvailable?> loadUpdatedTruckerStatusWithOutCtx(
      int transportId,
      int truckerStatus,
      VoidCallback voidCallback,
      String lat,
      String long,
      int langId) async {
    final updateState =
        await remoteDataSource.updateTruckerStatusWithoutContext(
            transportId, truckerStatus, voidCallback, lat, long, langId);

    if (updateState == null) {
      update();
      return null;
    } else {
      final data = updateState;
      allDriverAvailableWayBill.value = data;

      update();

      return data;
    }
  }

  Future<DriverAvailable?> loadUpdatedTruckerStatusRefused(String refusedReason,
      int transportId,
      int status,
      int refusedReasonId,
      BuildContext context,
      VoidCallback voidCallback,
      int langId) async {
    final updateState = await remoteDataSource.updateTruckerStatusRefused(
        refusedReason,
        transportId,
        status,
        refusedReasonId,
        context,
        voidCallback,
        langId);

    if (updateState == null) {
      noDataDriverAvailWayBill.value = true;
      update();
      return null;
    } else {
      if (updateState.data!.isEmpty) {
        dataIsEmpty.value = true;

        log('true..............');
        log('length true = ${updateState.data?.length}');
        update();
      } else {
        dataIsEmpty.value = false;

        final data = updateState;
        allDriverAvailableWayBill.value = data;

        log('false..............');
        log('length false = ${updateState.data?.length}');
        update();

        return data;
      }
    }
  }

  Future<NotificationModel?> loadLastNotification(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    final lastNavigate = await remoteDataSource.getLastNotification(
        context, voidCallback, searchtxt, langId);
    if (lastNavigate == null) {
      update();
      return null;
    } else if (lastNavigate.message == "No Data") {
      noData.value = true;
      lastNavigate.message = "No Data";
      log('data eqal null in last navigate *************');
      update();
      return null;
    } else {
      if (lastNavigate.data!.isEmpty) {
        dataLogsEmpty.value = true;

        update();
      } else {
        dataLogsEmpty.value = false;
        final data = lastNavigate;
        lastNavigateData.value = data;

        update();

        return data;
      }
    }
  }

  Future<NotificationModel?> loadLastAccidentLog(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    final lastNavigate = await remoteDataSource.getLastAccidentLog(
        context, voidCallback, searchtxt, langId);
    if (lastNavigate == null) {
      update();
      return null;
    } else if (lastNavigate.message == "No Data") {
      noData.value = true;
      lastNavigate.message = "No Data";
      log('data eqal null in last navigate *************');
      update();
      return null;
    } else {
      if (lastNavigate.data!.isEmpty) {
        dataLogsEmpty.value = true;

        update();
      } else {
        dataLogsEmpty.value = false;
        final data = lastNavigate;
        lastNavigateData.value = data;

        update();

        return data;
      }
    }
  }

  Future<NotificationModel?> loadFirstNotification(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    final firstNavigate = await remoteDataSource.getFirstNotification(
        context, voidCallback, searchtxt, langId);
    if (firstNavigate == null) {
      update();
      return null;
    } else if (firstNavigate.message == "No Data") {
      noData.value = true;
      firstNavigate.message = "No Data";
      log('data eqal null in first navigate *************');
      update();
      return null;
    } else {
      final data = firstNavigate;
      lastNavigateData.value = data;
      update();

      return data;
    }
  }

  Future<NotificationModel?> loadFirstAccidentLog(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    final firstNavigate = await remoteDataSource.getFirstAccidentLog(
        context, voidCallback, searchtxt, langId);
    if (firstNavigate == null) {
      update();
      return null;
    } else if (firstNavigate.message == "No Data") {
      noData.value = true;
      firstNavigate.message = "No Data";
      log('data eqal null in FirstAccidentLog *************');
      update();
      return null;
    } else {
      final data = firstNavigate;
      lastNavigateData.value = data;
      update();

      return data;
    }
  }

  Future<NotificationModel?> loadPreviousNotification(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    final prevNavigate = await remoteDataSource.getPreviousNotification(
        context,
        voidCallback,
        searchtxt,
        langId,
        lastNavigateData.value.data?[0].selectedPage ?? 1);
    if (prevNavigate == null) {
      update();
      return null;
    } else if (prevNavigate.message == "No Data") {
      noData.value = true;
      prevNavigate.message = "No Data";
      log('data eqal null in prev navigate *************');
      update();
      return null;
    } else {
      final data = prevNavigate;

      lastNavigateData.value = data;
      update();

      return data;
    }
  }

  Future<NotificationModel?> loadPreviousAccident(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    final prevNavigate = await remoteDataSource.getPreviousAccidentLog(
        context,
        voidCallback,
        searchtxt,
        langId,
        lastNavigateData.value.data?[0].selectedPage ?? 1);
    if (prevNavigate == null) {
      update();
      return null;
    } else if (prevNavigate.message == "No Data") {
      noData.value = true;
      prevNavigate.message = "No Data";
      log('data eqal null in PreviousAccident *************');
      update();
      return null;
    } else {
      final data = prevNavigate;

      lastNavigateData.value = data;
      update();

      return data;
    }
  }

  Future<NotificationModel?> loadNextNotification(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    final nextNavigate = await remoteDataSource.getNextNotification(
        context,
        voidCallback,
        searchtxt,
        langId,
        lastNavigateData.value.data?[0].selectedPage ?? 1);
    if (nextNavigate == null) {
      update();
      return null;
    } else if (nextNavigate.message == "No Data") {
      noData.value = true;
      nextNavigate.message = "No Data";
      log('data eqal null in next navigate *************');
      update();
      return null;
    } else {
      final data = nextNavigate;

      lastNavigateData.value = data;
      update();

      return data;
    }
  }

  Future<NotificationModel?> loadNextAccidentLog(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    final nextNavigate = await remoteDataSource.getNextAccidentLog(
        context,
        voidCallback,
        searchtxt,
        langId,
        lastNavigateData.value.data?[0].selectedPage ?? 1);
    if (nextNavigate == null) {
      update();
      return null;
    } else if (nextNavigate.message == "No Data") {
      noData.value = true;
      nextNavigate.message = "No Data";
      log('data eqal null in NextAccidentLog *************');
      update();
      return null;
    } else {
      final data = nextNavigate;

      lastNavigateData.value = data;
      update();

      return data;
    }
  }
}
