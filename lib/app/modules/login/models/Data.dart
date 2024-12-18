import '../../home/model/driver_available_way_bill/DriverProceduresPending.dart';
import 'FinancialYears.dart';
import 'HrLeaveStatus.dart';
import 'HrTransactionType.dart';
import 'PaidTypes.dart';

class Data {
  Data({
    this.userName,
    this.driverId,
    this.currentFinancialYearId,
    this.employeeId,
    this.erpUserId,
    this.loginDate,
    this.languages,
    this.userId,
    this.paidTypes,
    this.hrLeaveStatus,
    this.financialYear,
    this.companyId,
    this.branchId,
    this.showTransportationCurrentWaybill,
    this.showTransportationWaybillLog,
    this.showTransportationDriverDues,
    this.showHumanResourcesHolidayRequest,
    this.showHumanResourcesAddLocation,
    this.showHumanResourcesHolidayLog,
    this.showHumanResourcesHolidayBalance,
    this.showHumanResourcesLoanRequest,
    this.showHumanResourcesLoanLog,
    this.showHumanResourcesLoanBalance,
    this.showHumanResourcesDelayPermission,
    this.showHumanResourcesDeraturePermission,
    this.showHumanResourcesAbsence,
    this.showHumanResourcesEmpStatement,
    this.showHumanResourcesEmpLoanStatement,
    this.showHumanResourcesAttendanceDeparture,
    this.showAlertOnAutoArrivedAtPickupLocation,
    this.showAlertOnAutoArrivedAtDeliveryLocation,
    this.showAlertOnCompletedTipWithoutRecipientSigning,
    this.showSalesRetailInvoice,
    this.showSalesRetailCustomers,
    this.showSalesRetailItemsGroups,
    this.showSalesRetailItems,
    this.showSalesRetailDiscountTypes,
    this.showSettingDetermineLocation,
    this.showSettingChangeLanguage,
    this.driverName,
    this.employeeName,
    this.erpUserName,
    this.mobileUserName,
    this.mobileUserA,
    this.mobileUserE,
    this.defaultCompanyId,
    this.defaultBranchId,
    this.defaultFinancialYearId,
    this.computerName,
    this.waybillDriverProcedures,
    this.waybillDriverProceduresEnglish,
    this.waybillDriverProceduresUrdu,
    this.waybillDriverProceduresHindi,
    this.financialYears,
    this.hrTransactionType,
    this.waybillDriverProceduresFrance,
  });

  Data.fromJson(dynamic json) {
    userName = json['userName'];
    driverId = json['driverId'];
    employeeId = json['employeeId'];
    erpUserId = json['erpUserId'];
    loginDate = json['loginDate'];
    languages = json['languages'];
    currentFinancialYearId = json['current_FinancialYearId'];
    userId = json['userId'];
    financialYear = json['financialYear'];
    companyId = json['companyId'];
    branchId = json['branchId'];
    driverName = json['driverName'];
    employeeName = json['employeeName'];
    showTransportationCurrentWaybill =
    json['show_Transportation_Current_Waybill'];
    showTransportationWaybillLog = json['show_Transportation_Waybill_Log'];
    showTransportationDriverDues = json['show_Transportation_Driver_Dues'];
    showHumanResourcesHolidayRequest =
    json['show_Human_Resources_Holiday_Request'];
    showHumanResourcesAddLocation = json['show_Human_Resources_AddLocation'];
    showHumanResourcesHolidayLog = json['show_Human_Resources_Holiday_Log'];
    showHumanResourcesHolidayBalance =
    json['show_Human_Resources_Holiday_Balance'];
    showHumanResourcesLoanRequest = json['show_Human_Resources_Loan_Request'];
    showHumanResourcesLoanLog = json['show_Human_Resources_Loan_Log'];
    showHumanResourcesLoanBalance = json['show_Human_Resources_Loan_Balance'];
    showHumanResourcesDelayPermission =
    json['show_Human_Resources_DelayPermission'];
    showHumanResourcesDeraturePermission =
    json['show_Human_Resources_DeraturePermission'];
    showHumanResourcesAbsence = json['show_Human_Resources_Absence'];
    showHumanResourcesEmpStatement = json['show_Human_Resources_EmpStatement'];
    showHumanResourcesEmpLoanStatement =
    json['show_Human_Resources_EmpLoanStatement'];
    showHumanResourcesAttendanceDeparture =
    json['show_Human_Resources_AttendanceDeparture'];
    showAlertOnAutoArrivedAtPickupLocation =
    json['show_Alert_On_Auto_Arrived_At_Pick_up_Location'];
    showAlertOnAutoArrivedAtDeliveryLocation =
    json['show_Alert_On_Auto_Arrived_At_Delivery_Location'];
    showAlertOnCompletedTipWithoutRecipientSigning =
    json['show_Alert_On_Completed_Tip_Without_Recipient_Signing'];
    showSalesRetailInvoice = json['show_SalesRetail_Invoice'];
    showSalesRetailCustomers = json['show_SalesRetail_Customers'];
    showSalesRetailItemsGroups = json['show_SalesRetail_ItemsGroups'];
    showSalesRetailItems = json['show_SalesRetail_Items'];
    showSalesRetailDiscountTypes = json['show_SalesRetail_DiscountTypes'];
    showSettingDetermineLocation = json['show_Setting_Determine_Location'];
    showSettingChangeLanguage = json['show_Setting_Change_Language'];
    erpUserName = json['erpUserName'];
    mobileUserName = json['mobileUserName'];
    mobileUserA = json['mobileUserA'];
    mobileUserE = json['mobileUserE'];
    defaultCompanyId = json['default_CompanyId'];
    defaultBranchId = json['default_BranchId'];
    defaultFinancialYearId = json['default_FinancialYearId'];
    computerName = json['computerName'];
    if (json['waybill_DriverProcedures'] != null) {
      waybillDriverProcedures = [];
      json['waybill_DriverProcedures'].forEach((v) {
        waybillDriverProcedures?.add(DriverProceduresPending.fromJson(v));
      });
    }
    if (json['waybill_DriverProceduresEnglish'] != null) {
      waybillDriverProceduresEnglish = [];
      json['waybill_DriverProceduresEnglish'].forEach((v) {
        waybillDriverProceduresEnglish
            ?.add(DriverProceduresPending.fromJson(v));
      });
    }
    if (json['waybill_DriverProceduresUrdu'] != null) {
      waybillDriverProceduresUrdu = [];
      json['waybill_DriverProceduresUrdu'].forEach((v) {
        waybillDriverProceduresUrdu?.add(DriverProceduresPending.fromJson(v));
      });
    }
    if (json['waybill_DriverProceduresHindi'] != null) {
      waybillDriverProceduresHindi = [];
      json['waybill_DriverProceduresHindi'].forEach((v) {
        waybillDriverProceduresHindi?.add(DriverProceduresPending.fromJson(v));
      });
    }
    if (json['waybill_DriverProceduresFrance'] != null) {
      waybillDriverProceduresFrance = [];
      json['waybill_DriverProceduresFrance'].forEach((v) {
        waybillDriverProceduresFrance?.add(DriverProceduresPending.fromJson(v));
      });
    }

    if (json['financialYears'] != null) {
      financialYears = [];
      json['financialYears'].forEach((v) {
        financialYears?.add(FinancialYears.fromJson(v));
      });
    }

    if (json['hrTransactionType'] != null) {
      hrTransactionType = [];
      json['hrTransactionType'].forEach((v) {
        hrTransactionType?.add(HrTransactionType.fromJson(v));
      });
    }

    if (json['paid_Types'] != null) {
      paidTypes = [];
      json['paid_Types'].forEach((v) {
        paidTypes?.add(PaidTypes.fromJson(v));
      });
    }
    if (json['hrLeaveStatus'] != null) {
      hrLeaveStatus = [];
      json['hrLeaveStatus'].forEach((v) {
        hrLeaveStatus?.add(HrLeaveStatus.fromJson(v));
      });
    }
  }

  String? userName;
  int? driverId;
  int? employeeId;
  int? erpUserId;
  String? loginDate;
  int? languages;
  int? userId;
  int? currentFinancialYearId;
  int? financialYear;
  int? companyId;
  int? branchId;
  bool? showTransportationCurrentWaybill;
  bool? showTransportationWaybillLog;
  bool? showTransportationDriverDues;
  bool? showHumanResourcesHolidayRequest;
  bool? showHumanResourcesAddLocation;
  bool? showHumanResourcesHolidayLog;
  bool? showHumanResourcesHolidayBalance;
  bool? showHumanResourcesLoanRequest;
  bool? showHumanResourcesLoanLog;
  bool? showHumanResourcesLoanBalance;
  bool? showHumanResourcesDelayPermission;
  bool? showHumanResourcesDeraturePermission;
  bool? showHumanResourcesAbsence;
  bool? showHumanResourcesEmpStatement;
  bool? showHumanResourcesEmpLoanStatement;
  bool? showHumanResourcesAttendanceDeparture;
  bool? showAlertOnAutoArrivedAtPickupLocation;
  bool? showAlertOnAutoArrivedAtDeliveryLocation;
  bool? showAlertOnCompletedTipWithoutRecipientSigning;
  bool? showSalesRetailInvoice;
  bool? showSalesRetailCustomers;
  bool? showSalesRetailItemsGroups;
  bool? showSalesRetailItems;
  bool? showSalesRetailDiscountTypes;
  bool? showSettingDetermineLocation;
  bool? showSettingChangeLanguage;
  String? driverName;
  String? employeeName;
  String? erpUserName;
  String? mobileUserName;
  String? mobileUserA;
  String? mobileUserE;
  dynamic defaultCompanyId;
  dynamic defaultBranchId;
  dynamic defaultFinancialYearId;
  dynamic computerName;
  List<DriverProceduresPending>? waybillDriverProcedures;
  List<DriverProceduresPending>? waybillDriverProceduresEnglish;
  List<DriverProceduresPending>? waybillDriverProceduresUrdu;
  List<DriverProceduresPending>? waybillDriverProceduresHindi;
  List<DriverProceduresPending>? waybillDriverProceduresFrance;
  List<FinancialYears>? financialYears;
  List<HrTransactionType>? hrTransactionType;
  List<PaidTypes>? paidTypes;
  List<HrLeaveStatus>? hrLeaveStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['driverId'] = driverId;
    map['employeeId'] = employeeId;
    map['erpUserId'] = erpUserId;
    map['loginDate'] = loginDate;
    map['languages'] = languages;
    map['userId'] = userId;
    map['financialYear'] = financialYear;
    map['companyId'] = companyId;
    map['current_FinancialYearId'] = currentFinancialYearId;
    map['branchId'] = branchId;
    map['driverName'] = driverName;
    map['employeeName'] = employeeName;
    map['erpUserName'] = erpUserName;
    map['show_Transportation_Current_Waybill'] =
        showTransportationCurrentWaybill;
    map['show_Transportation_Waybill_Log'] = showTransportationWaybillLog;
    map['show_Transportation_Driver_Dues'] = showTransportationDriverDues;
    map['show_Human_Resources_Holiday_Request'] =
        showHumanResourcesHolidayRequest;
    map['show_Human_Resources_AddLocation'] = showHumanResourcesAddLocation;
    map['show_Human_Resources_Holiday_Log'] = showHumanResourcesHolidayLog;
    map['show_Human_Resources_Holiday_Balance'] =
        showHumanResourcesHolidayBalance;
    map['show_Human_Resources_Loan_Request'] = showHumanResourcesLoanRequest;
    map['show_Human_Resources_Loan_Log'] = showHumanResourcesLoanLog;
    map['show_Human_Resources_Loan_Balance'] = showHumanResourcesLoanBalance;
    map['show_Human_Resources_DelayPermission'] =
        showHumanResourcesDelayPermission;
    map['show_Human_Resources_DeraturePermission'] =
        showHumanResourcesDeraturePermission;
    map['show_Human_Resources_Absence'] = showHumanResourcesAbsence;
    map['show_Human_Resources_EmpStatement'] = showHumanResourcesEmpStatement;
    map['show_Human_Resources_EmpLoanStatement'] =
        showHumanResourcesEmpLoanStatement;
    map['show_Human_Resources_AttendanceDeparture'] =
        showHumanResourcesAttendanceDeparture;
    map['show_Alert_On_Auto_Arrived_At_Pick_up_Location'] =
        showAlertOnAutoArrivedAtPickupLocation;
    map['show_Alert_On_Auto_Arrived_At_Delivery_Location'] =
        showAlertOnAutoArrivedAtDeliveryLocation;
    map['show_Alert_On_Completed_Tip_Without_Recipient_Signing'] =
        showAlertOnCompletedTipWithoutRecipientSigning;
    map['show_SalesRetail_Invoice'] = showSalesRetailInvoice;
    map['show_SalesRetail_Customers'] = showSalesRetailCustomers;
    map['show_SalesRetail_ItemsGroups'] = showSalesRetailItemsGroups;
    map['show_SalesRetail_Items'] = showSalesRetailItems;
    map['show_SalesRetail_DiscountTypes'] = showSalesRetailDiscountTypes;
    map['show_Setting_Determine_Location'] = showSettingDetermineLocation;
    map['show_Setting_Change_Language'] = showSettingChangeLanguage;
    map['mobileUserName'] = mobileUserName;
    map['mobileUserE'] = mobileUserE;
    map['mobileUserA'] = mobileUserA;
    map['default_CompanyId'] = defaultCompanyId;
    map['default_BranchId'] = defaultBranchId;
    map['default_FinancialYearId'] = defaultFinancialYearId;
    map['computerName'] = computerName;
    if (waybillDriverProcedures != null) {
      map['waybill_DriverProcedures'] =
          waybillDriverProcedures?.map((v) => v.toJson()).toList();
    }
    if (waybillDriverProceduresEnglish != null) {
      map['waybill_DriverProceduresEnglish'] =
          waybillDriverProceduresEnglish?.map((v) => v.toJson()).toList();
    }
    if (waybillDriverProceduresUrdu != null) {
      map['waybill_DriverProceduresUrdu'] =
          waybillDriverProceduresUrdu?.map((v) => v.toJson()).toList();
    }
    if (waybillDriverProceduresHindi != null) {
      map['waybill_DriverProceduresHindi'] =
          waybillDriverProceduresHindi?.map((v) => v.toJson()).toList();
    }
    if (waybillDriverProceduresFrance != null) {
      map['waybill_DriverProceduresFrance'] =
          waybillDriverProceduresFrance?.map((v) => v.toJson()).toList();
    }

    if (financialYears != null) {
      map['financialYears'] = financialYears?.map((v) => v.toJson()).toList();
    }

    if (hrTransactionType != null) {
      map['hrTransactionType'] =
          hrTransactionType?.map((v) => v.toJson()).toList();
    }

    if (paidTypes != null) {
      map['paid_Types'] = paidTypes?.map((v) => v.toJson()).toList();
    }
    if (hrLeaveStatus != null) {
      map['hrLeaveStatus'] = hrLeaveStatus?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
