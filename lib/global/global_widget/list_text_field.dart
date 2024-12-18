import 'package:chameleon/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../app/modules/home/model/hr/get_employee_leaves/HrEmployees.dart';
import '../../app/modules/home/model/hr/get_employee_leaves/HrLeaveTypes.dart';
import '../../app/modules/home/model/hr/get_employee_loan/HrLoanTypes.dart';
import '../constants/constants.dart';
import '../controllers/language_controller.dart';

class ListTextField extends StatelessWidget {
  final onSuggetionSelected, controller, suggetionCallBack;
  VoidCallback? action;

  ListTextField({
    Key? key,
    this.controller,
    this.onSuggetionSelected,
    this.action,
    this.suggetionCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField<HrLeaveTypes>(
      hintText: LocaleKeys.holidayType.tr,
      action: action,
      suggestionsCallback: suggetionCallBack,
      onSuggestionSelected: onSuggetionSelected,
      controller: controller,
      itemBuilder: (_, item) => SuggestionTile(
        title: Get.find<LanguageController>().isArabic
            ? item.nameA ?? ''
            : item.nameE ?? '',
        subtitle: '',
      ),
    );
  }
}

class ListLoanTypeTextField extends StatelessWidget {
  final onSuggetionSelected, controller, suggetionCallBack;
  VoidCallback? action;

  ListLoanTypeTextField({
    Key? key,
    this.controller,
    this.onSuggetionSelected,
    this.action,
    this.suggetionCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField<HrLoanTypes>(
      hintText: LocaleKeys.solfaType.tr,
      action: action,
      suggestionsCallback: suggetionCallBack,
      onSuggestionSelected: onSuggetionSelected,
      controller: controller,
      itemBuilder: (_, item) => SuggestionTile(
        title: Get.find<LanguageController>().isArabic
            ? item.nameA ?? ''
            : item.nameE ?? '',
        subtitle: '',
      ),
    );
  }
}

class ListEmployessTextField extends StatelessWidget {
  final onSuggetionSelected, controller, suggetionCallBack;
  VoidCallback? action;

  ListEmployessTextField({
    Key? key,
    this.controller,
    this.onSuggetionSelected,
    this.action,
    this.suggetionCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField<HrEmployees>(
      hintText: LocaleKeys.embloyee.tr,
      action: action,
      suggestionsCallback: suggetionCallBack,
      onSuggestionSelected: onSuggetionSelected,
      controller: controller,
      itemBuilder: (_, item) =>
          SuggestionTile(
            title: Get
                .find<LanguageController>()
                .isArabic ?
            item.nameA ?? '' : item.nameE ?? '',
            subtitle: '',
          ),
    );
  }
}

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({Key? key, required this.title, required this.subtitle})
      : super(key: key);
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: const TextStyle(),
      ),
      subtitle: Text(subtitle, style: const TextStyle()),
    );
  }
}


class CustomTextField<T> extends StatelessWidget {
  CustomTextField({Key? key,
    this.suggestionsBoxController,
    required this.suggestionsCallback,
    required this.onSuggestionSelected,
    required this.controller,
    required this.itemBuilder,
    required this.hintText,
    this.action,
    this.isClearButtonVisible = true})
      : super(key: key);
  final SuggestionsBoxController? suggestionsBoxController;
  final SuggestionsCallback<T> suggestionsCallback;
  final SuggestionSelectionCallback<T> onSuggestionSelected;
  final TextEditingController controller;
  final ItemBuilder<T> itemBuilder;
  final String hintText;
  VoidCallback? action;

  final bool isClearButtonVisible;

  // final VoidCallback on

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TypeAheadField<T>(
          suggestionsBoxController: suggestionsBoxController,
          suggestionsCallback: suggestionsCallback,
          loadingBuilder: (context) {
            return const SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
          itemBuilder: itemBuilder,
          noItemsFoundBuilder: (context) {
            return const SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  'لم نجد نتيجه',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
          onSuggestionSelected: (T suggestion) {
            // controller.text = suggestion.toString();
            onSuggestionSelected(suggestion);
          },
          textFieldConfiguration: TextFieldConfiguration(
            onTap: () {},
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey)),
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 12.0,
              ),
              contentPadding: const EdgeInsets.fromLTRB(
                5,
                0,
                5,
                0,
              ),
            ),
          ),
        ),
        if (isClearButtonVisible)
          Positioned.fill(
            left: 5,
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SizedBox(
                height: 25,
                width: 25,
                child: FloatingActionButton(
                  heroTag: null,
                  mini: true,
                  onPressed: action,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 17,
                  ),
                  backgroundColor: greyColor,
                ),
              ),
            ),
          )
      ],
    );
  }
}

