//
// // set satus of the print
// enum PrintStatus {
//   enable,
//   disable,
//   locked,
// }
//
// class PosAndRestCommonController extends GetxController {
//   // set satus of the print to enabled by default
//   final printStatus = Rx<PrintStatus>(PrintStatus.enable);
//
//   // check if is return mode and get the return result
//   // ReturnResult? returnResult;
//   final isReturnMode = false.obs;
//
//   final loadingController = Get.find<LoadingController>();
//
//   final selectedItems = SelectedItems([]).obs;
//
//   // selected customer and selected store
//   late Customer selectedCustomer;
//   late CustomersList selectedCustomer2;
//   late Store selectedStore;
//   late StoresList selectedStore2;
//   late Salesmen salesmen;
//
//   // returns result
//   ReturnResult? returnResult;
//
//   // isLoading
//   final isLoading = false.obs;
//
//   // define scroll controller for list view
//   final scrollController = ScrollController();
//
//   ////////////////////////////////////////////////////////////////////////////////
//   ///                                                                         ////
//   ///                             methods Area                                ////
//   ///                                                                         ////
//   ////////////////////////////////////////////////////////////////////////////////
//
//   void onSuggestionItemSelected(Item suggestion) {
//     // check if selected item is already choosed by ckeck the item id and unit id
//     final itemIndex = selectedItems.value.isItemSelected(suggestion);
//
//     // if index is not equal -1 then the item is already exists
//     bool isItemAlreadyExist = itemIndex != -1;
//
//     // if item already exists we add one to it's quantity
//     if (isItemAlreadyExist) {
//       selectedItems.value.items[itemIndex].increaseQuantityByOne();
//     }
//     // else we add the item to the selected items list
//     else {
//       selectedItems.value.items.add(
//         SelectedItem(
//           item: suggestion,
//         ),
//       );
//     }
//     scrollController.jumpTo(scrollController.position.maxScrollExtent);
//     update();
//   }
//
//   // void onSuggestionItemsListSelected(ItemsList suggestion) {
//   //   // check if selected item is already choosed by ckeck the item id and unit id
//   //   final itemIndex =
//   //       selectedItems2.value.isItemfromSalesBillSelected(suggestion);
//   //
//   //   // if index is not equal -1 then the item is already exists
//   //   bool isItemAlreadyExist = itemIndex != -1;
//   //
//   //   // if item already exists we add one to it's quantity
//   //   if (isItemAlreadyExist) {
//   //     selectedItems2.value.items[itemIndex].increaseQuantityByOne();
//   //   }
//   //   // else we add the item to the selected items list
//   //   else {
//   //     selectedItems2.value.items.add(
//   //       SalesBillSelectedItem(
//   //         item: suggestion,
//   //       ),
//   //     );
//   //   }
//   //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
//   //   update();
//   // }
//
//   // remove item with this index from selected items list
//   // and update ui
//
//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   void onDeleteSelectedItem(int index) {
//     selectedItems.value.items.removeAt(index);
//     update();
//   }
//
//   // increase selected item quantity by one and update ui
//   void onIncreaseSelectedItemQuantity(int index) {
//     selectedItems.value.items[index].increaseQuantityByOne();
//     update();
//   }
//
//   // decrese selected item quantity by one
//   void onDecreaseSelectedItemQuantity(int index) {
//     // if quantity is already one we don't do any thing
//     if (selectedItems.value.items[index].countController.text == '1') {
//       return;
//     }
//
//     // increase item quantity by one and update ui
//     selectedItems.value.items[index].decreaseQuantityByOne();
//     update();
//   }
//
//   // clear all items from selected items list
//   void clearItems() {
//     selectedItems.value.items.clear();
//     update();
//   }
//
//   // disable the return mode and set return result to null
//   void disableReturnMode() {
//     // disable the return mode
//     isReturnMode.value = false;
//
//     // set return result to null
//     returnResult = null;
//
//     // clear the items list and update ui
//     selectedItems.value.items.clear();
//     update();
//   }
//
//   void cancelReturnMode() {
//     disableReturnMode();
//   }
//
//   // toggle the selected checkbox of the items in returns
//   void toggleCheckbox(int i) {
//     returnResult!.returns[i].toggleSelect();
//     update();
//   }
//
//   // set the return items back from our return result to the items list and show it
//   void setReturnToItemList(ReturnResult result, data) {
//     // set the return result to our return result variable
//     returnResult = result;
//
//     // clear the items list
//     selectedItems.value.items.clear();
//
//     // add all item in the result returns to our selected list items
//     log(POS().toString());
//     log(data.toString());
//     selectedItems.value.items.addAll(
//       result.returns.map(
//         (e) => SelectedItem(
//           returnCount: e.quantity.toInt(),
//           returnDiscount: e.discount1,
//           returnPrice: e.price,
//           item: data.toString() == POS().toString()
//               ? e.toItemPOS()
//               : e.toItemRestaurantPOS(),
//         ),
//       ),
//     );
//
//     // set is return mode to true to show bottom bar of returns in pos screen
//     isReturnMode.value = true;
//
//     // update the ui
//     update();
//   }
//
//   ////////////////////////////////////////////////////////////////////
//   ///                                                           //////
//   ///                The Most Important Function                //////
//   ///                                                           //////
//   ////////////////////////////////////////////////////////////////////
//
//   // this function is for send the invoice for backend and get the print results
//   // after get print result we print the items and data we need
//   // after that we go to show the prints we got
//   Future<void> moneyInvoice(remoteDataSource, int posReportNumber,
//       {details, posInvoiceTypeID}) async {
//     try {
//       // check if the selected items list is empty
//       if (selectedItems.value.items.isEmpty) {
//         showFlutterToast('اختار الاصناف اولا', Colors.yellow,
//             textColor: Colors.black);
//         return;
//       }
//
//       // check if the selected customer is null
//       if (selectedCustomer == null) {
//         showFlutterToast('اختار العميل اولا', Colors.yellow,
//             textColor: Colors.black);
//         return;
//       }
//
//       // define the invoice params to send them
//       final params = InvoiceParams(
//         sourceId: 0,
//         invoiceType: 10,
//         amountPaid: selectedItems.value.totalPriceAfterAddTaxAndDiscount,
//         remainingAmount: 0,
//         tableNumber: details == null ? 0 : details.tableNumber,
//         orderNoCounter: details == null ? 0 : details.orderNoCounter,
//         sceId: selectedCustomer.id!,
//         selectedItems: selectedItems.value,
//         posInvoiceTypeId: posInvoiceTypeID == null
//             ? details == null
//                 ? 0
//                 : details.posinvoiceTypeId
//             : posInvoiceTypeID,
//         invoicePayment: [
//           InvoicePayment(
//             paymentId: 5,
//             paymentValue: selectedItems.value.totalPriceAfterAddTaxAndDiscount,
//           )
//         ],
//         storeId: selectedStore.storeId!,
//       );
//
//       // set loading to true
//       loadingController.show();
//       isLoading.value = true;
//
//       if (Get.find<HomeController>().isInternetConnected.value) {
//         // send the invoice to backend and get the invoice print parameters
//         final result = await remoteDataSource.moneyInvoice(params.toJson());
//
//         // if result is null we return null
//         if (result == null) {
//           // show error message
//           showFlutterToast('Un Excepted Erro', redColor);
//           return null;
//         }
//         // else then we have the printing data and ready for print
//         else {
//           // set our print data
//           PrintData posPrintData = result;
//
//           // run the generate pdf function and get the doc back from it
//           final document =
//               await PrintingServices.generatePOSAndRestaurantPDFDoc(
//             posPrintData,
//             params,
//             selectedItems.value.totalPriceAfterAddTaxAndDiscount,
//             selectedStore,
//             selectedCustomer,
//             posReportNumber,
//           );
//
//           // goto print preview page with the document back from the function
//           Get.toNamed(
//             Routes.PRINT_PREVIEW,
//             arguments: {
//               'document': document,
//             },
//           );
//
//           // clear all items and update the ui
//           clearItems();
//           update();
//           return;
//         }
//       } else {
//         showFlutterToast(
//           'Invoice Saved Untill Internet Is Back',
//           Colors.yellow,
//           textColor: Colors.black,
//         );
//         GetStorage storage = GetStorage();
//
//         final savedInvoices = storage.read(offlineInvoicesKey) ?? [];
//         String dataSource = '';
//
//         if (remoteDataSource is PosRemoteDataSource) {
//           dataSource = 'posRemoteDataSource';
//         } else {
//           dataSource = 'restaurantPosRemoteDataSource';
//         }
//
//         savedInvoices.add({
//           'dataSource': dataSource,
//           'params': params.toJson(),
//         });
//
//         await storage.write(offlineInvoicesKey, savedInvoices);
//
//         // clear all items and update the ui
//         clearItems();
//       }
//     } catch (e) {
//       // if error we print it
//       print(e);
//       rethrow;
//     } finally {
//       loadingController.hide();
//       isLoading.value = false;
//
//       if (remoteDataSource is RestaurantPosRemoteDataSource) {
//         Get.find<PosRestaurantController>().reset();
//       }
//     }
//   }
//
//   // use this function in the returns button in pos screen
//   Future<void> toReturn(data) async {
//     // show the movement type bottom sheet and the result back from it
//     final result = await Get.bottomSheet(
//       MovementTypeBottomSheet(
//         data: data,
//       ),
//     ) as ReturnResult?;
//
//     // if result is null we return
//     if (result == null) return;
//   }
//
//   // send the return items to backend and get the print results
//   void returnItems(remoteDataSource, int posReportNumber) async {
//     try {
//       // set loading to true
//       isLoading.value = true;
//       loadingController.show();
//
//       // define the return invoice params to send them
//
//       final params = InvoiceParams(
//         sourceId: returnResult!.sourceId,
//         invoiceType: 17,
//         amountPaid: selectedItems.value.totalPriceAfterAddTaxAndDiscount,
//         remainingAmount: 0,
//         sceId: selectedCustomer.id!,
//         selectedItems: selectedItems.value,
//         invoicePayment: [
//           InvoicePayment(
//             paymentId: 5,
//             paymentValue: selectedItems.value.totalPriceAfterAddTaxAndDiscount,
//           )
//         ],
//         storeId: selectedStore.storeId!,
//       );
//
//       // send the invoice to backend and get the invoice print parameters
//       final result = await remoteDataSource.moneyInvoice(params.toJson());
//
//       // if result is null we return null
//       if (result == null) {
//         log('result is null');
//         return null;
//       }
//       // we print the invoice after send it
//       else {
//         showFlutterToast('تم الإسترجاع بنجاح', greenColor);
//         if (printStatus.value == PrintStatus.enable) {
//           // set our print data
//           PrintData posPrintData = result;
//
//           // run the generate pdf function and get the doc back from it
//           final document =
//               await PrintingServices.generatePOSAndRestaurantPDFDoc(
//             posPrintData,
//             params,
//             selectedItems.value.totalPriceAfterAddTaxAndDiscount,
//             selectedStore,
//             selectedCustomer,
//             posReportNumber,
//           );
//
//           // goto print preview page with the document back from the function
//           Get.toNamed(
//             Routes.PRINT_PREVIEW,
//             arguments: {
//               'document': document,
//             },
//           );
//         }
//         // disable the return mode and clear the items list and update ui
//         disableReturnMode();
//         selectedItems.value.clear();
//         update();
//         return;
//       }
//     } catch (e) {
//       print(e);
//       rethrow;
//     } finally {
//       isLoading.value = false;
//       loadingController.hide();
//     }
//   }
// }
