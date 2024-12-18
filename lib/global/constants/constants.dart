import 'package:flutter/material.dart';

// colors
const purpleColor = Color(0xff7367F0);
const blueColor = Color(0xff0D6EFD);
const redColor = Colors.red;
const greenColor = Colors.green;
const darkBlueColor = Color(0xff3D7FA2);
const restaurantBlueColor = Color(0xff0000FF);
const greyColor = Color(0xff6C757D);

// get storage keys
const String hostKey = 'host';
const String languageKey = 'languagess';
const String userKey = "user";
const String rememberMeKey = 'rememberMe';
const String autoLoginKey = 'autoLogin2';
const String offlineInvoicesKey = 'offlineInvoicesKey';

// default host
const String defaultHost = "http://169.63.214.158/API";

// user urls
const String loginUserUrl = '/User/Login_Inner';
const String driverAvailableWayBillUrl = '/Waybill/DriverAvailableWaybill';
const String lastWaybillFileDataUrl = '/Waybill/LastWaybillFileData';
const String lastWaybillAccedentFileDataUrl = '/Waybill/LastWaybillAccedentFileData';
const String firstWaybillFileDataUrl = '/Waybill/FirstWaybillFileData';
const String firstWaybillAccedentFileDataUrl = '/Waybill/FirstWaybillAccedentFileData';
const String nextWaybillFileDataUrl = '/Waybill/NextWaybillFileData';
const String nextWaybillAccedentFileDataUrl = '/Waybill/NextWaybillAccedentFileData';
const String prevWaybillFileDataUrl = '/Waybill/PrevWaybillFileData';
const String prevWaybillAccedentFileDataUrl = '/Waybill/PrevWaybillAccedentFileData';
const String changePasswordUrl = '/Waybill/ChangePassword';
const String refusedReasonUrl = '/Waybill/GetRefusedReasons';
const String openDocumentTestUrl = '/Waybill/DownloadTrip';
const String openWaybillUrl = '/Waybill/DownloadWaybill';
const String getWaybillDetailsBillUrl = '/Waybill/GetWaybillDetails';
const String getDetailsDuesWayBillUrl = '/Waybill/GetDetailsDues';
const String getDetailsTotallyWayBillUrl = '/Waybill/GetTotallyDues';
const String getSigntureWayBillUrl = '/Waybill/GetSignture';
const String getLastWaybillFileUrl = '/Waybill/LastWaybillFile';
const String getLastAccedentFileUrl = '/Waybill/LastWaybillAccedentFile';
const String getPrevWaybillFileUrl = '/Waybill/PrevWaybillFile';
const String getPrevWaybillAccedentFileUrl = '/Waybill/PrevWaybillAccedentFile';
const String getNextWaybillFileUrl = '/Waybill/NextWaybillFile';
const String getNextWaybillAccedentFileUrl = '/Waybill/NextWaybillAccedentFile';
const String getFirstWaybillFileUrl = '/Waybill/FirstWaybillFile';
const String getFirstWaybillAccedentFileUrl = '/Waybill/FirstWaybillAccedentFile';
const String saveSigntureWayBillUrl =
    'http://169.63.214.158/API/Waybill/SaveSignture';
const String saveWayBillFileUrl = 'http://169.63.214.158/API/Waybill/SaveWaybillFile';
const String saveWaybillAccedentFileUrl = 'http://169.63.214.158/API/Waybill/SaveWaybillAccedentFile';
const String getEmployeesLeavesUrl = '/HR/GetEmployeesLeaves';
const String getTodayCheckUrl = '/HR/GetTodayCheck';
const String getEmployeesDelayPermissionUrl =
    '/HR/GetEmployeesDelayPermissions';
const String getEmployeesAbsencePermissionUrl =
    '/HR/GetEmployeesAbsencePermissions';
const String getEmployeesDeparturePermissionsUrl =
    '/HR/GetEmployeesDeparturePermissions';
const String getEmployeesLoansUrl = '/HR/GetEmployeesLoans';
const String getEmployeesLeavesRequestUrl = '/HR/GetEmployeesLeavesRequest';
const String getEmployeeDelayPermissionRequestUrl =
    '/HR/GetEmployeesDelayPermissionsRequest';
const String getEmployeeDeparutrePermRequestUrl =
    '/HR/GetEmployeesDeparturePermissionsRequest';
const String getEmployeesLoansRequestUrl = '/HR/GetEmployeesLoansRequest';
const String getVacationsBalanceUrl = '/HR/GetVacationsBalance';
const String getEmployeeStatementUrl = '/HR/GetEmployeesStatement';
const String getEmployeeLoanStatementUrl = '/HR/GetEmployeesLoanStatement';
const String getVacationBalanceUrl = '/HR/GetVacationBalance';
const String updateTruckerStatusUrl = '/Waybill/UpdateAppDriverOperation';
const String updateCheckinLocationUrl = '/HR/CheckInByLocation';
const String getMonthUrl = '/HR/GetMonthCheck';
const String updateTruckerStatusRefusedUrl =
    '/Waybill/UpdateWaybillDriverStatus';
const String lastNotificationUrl = '/Waybill/LastDriverWaybills';
const String lastDriverWaybillsMajorAccidentUrl = '/Waybill/LastDriverWaybillsMajorAccident';
const String firstNotificationUrl = '/Waybill/FirstDriverWaybills';
const String firstDriverWaybillsMajorAccidentUrl = '/Waybill/FirstDriverWaybillsMajorAccident';
const String nextNotificationUrl = '/Waybill/NextDriverWaybills';
const String nextDriverWaybillsMajorAccidentUrl = '/Waybill/NextDriverWaybillsMajorAccident';
const String previousNotificationUrl = '/Waybill/PrevDriverWaybills';
const String previousDriverWaybillsMajorAccidentUrl = '/Waybill/PrevDriverWaybillsMajorAccident';
const String getSelectOneWayBillByCodeDataURL = '/Waybill/PrevDriverWaybills';
const String addLeaveRequestURL = '/HR/AddLeaveRequest';
const String addDPermissionRequesttURL = '/HR/AddDelayPermissionsRequest';
const String addAPermissionRequesttURL = '/HR/AddAbsencePermissionsRequest';
const String addDeparturePermissionRequestURL =
    '/HR/AddDeparturePermissionsRequest';
const String addLoanRequestURL = '/HR/AddLoanRequest';
const String addLocationRequestURL = '/HR/AddLocationRequest';
const String saveAccedentStatusURL = '/Waybill/SaveAccedentStatus';
const String editLeaveRequestURL = '/HR/EditLeaveRequest';
const String editEmployeeDelayPermissionURL = '/HR/EditDelayPermissionsRequest';
const String editEmployeeDeparturePermissionURL =
    '/HR/EditDeparturePermissionsRequest';
const String editLoanRequestURL = '/HR/EditLoanRequest';
const String deleteLeaveRequestURL = '/HR/DeleteLeaveRequest';
const String deleteDPermissionRequestURL = '/HR/DeleteDelayPermissionsRequest';
const String deleteDeparturePermissionRequestURL =
    '/HR/DeleteDeparturePermissionsRequest';
const String deleteLoanRequestURL = '/HR/DeleteLoanRequest';
