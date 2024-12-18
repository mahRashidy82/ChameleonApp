import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as t;
import 'package:intl/intl.dart';

import '../controllers/language_controller.dart';

class CustomDateTimePicker extends StatelessWidget {
  final onChange, controller, label;

  const CustomDateTimePicker({
    Key? key,
    this.controller,
    this.label,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      format: Get
          .find<LanguageController>()
          .isArabic ||
          Get
              .find<LanguageController>()
              .isUrdo ||
          Get
              .find<LanguageController>()
              .isHindi ?
      t.DateFormat('yyyy-MM-dd') :
      t.DateFormat('dd/MM/yyyy'),
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          return DateTimeField.combine(date, null);
        } else {
          return currentValue;
        }
      },
      validator: (value) {
        if (value.toString().isEmpty) {
          return 'Please Choose Date';
        } else {
          return null;
        }
      },
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
          //labelText: label,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black)),
      onChanged: onChange,
      controller: controller,
    );
  }
}

class CustomDateMonthTimePicker extends StatelessWidget {
  final onChange, controller, label;
  DateFormat? format;

   CustomDateMonthTimePicker({
    Key? key,
    this.controller,
    this.label,
    this.onChange,
    this.format,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      format: format!,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          initialDate: currentValue ?? DateTime.now(),
        );
        if (date != null) {
          return DateTimeField.combine(date, null);
        } else {
          return currentValue;
        }
      },
      validator: (value) {
        if (value.toString().isEmpty) {
          return 'Please Choose Date';
        } else {
          return null;
        }
      },
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
          //labelText: label,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black)),
      onChanged: onChange,
      controller: controller,
    );
  }
}

class CustomDateTimePicker2 extends StatelessWidget {
  final onChange, controller, label;

  const CustomDateTimePicker2({
    Key? key,
    this.controller,
    this.label,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      format: Get
          .find<LanguageController>()
          .isArabic ||
          Get
              .find<LanguageController>()
              .isUrdo ||
          Get
              .find<LanguageController>()
              .isHindi ?
      t.DateFormat('yyyy-MM-dd hh:mm a') :
      t.DateFormat('dd/MM/yyyy hh:mm a'),
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(
              currentValue ?? DateTime.now(),
            ),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
      validator: (value) {
        if (value
            .toString()
            .isEmpty) {
          return 'Please Choose Date';
        } else {
          return null;
        }
      },
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
          //labelText: label,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black)),
      onChanged: onChange,
      controller: controller,
    );
  }
}

class CustomDateTimePicker3 extends StatelessWidget {
  final onChange, controller, label;

  const CustomDateTimePicker3({
    Key? key,
    this.controller,
    this.label,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      format: Get
          .find<LanguageController>()
          .isArabic ||
          Get
              .find<LanguageController>()
              .isUrdo ||
          Get
              .find<LanguageController>()
              .isHindi
          ? t.DateFormat('hh:mm a')
          : t.DateFormat('hh:mm a'),
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(
            currentValue ?? DateTime.now(),
          ),
        );
        return DateTimeField.combine(DateTime.now(), time);
      },
      validator: (value) {
        if (value.toString().isEmpty) {
          return 'Please Choose Date';
        } else {
          return null;
        }
      },
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
          //labelText: label,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black)),
      onChanged: onChange,
      controller: controller,
    );
  }
}
